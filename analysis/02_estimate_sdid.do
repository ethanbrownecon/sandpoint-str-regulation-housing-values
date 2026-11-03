version 17.0
clear all
set more off

* Run from the repository root after 01_prepare_panel.do.
local input "data/processed/cleaned_sample_panel.csv"
local results "results"

capture mkdir "`results'"

import delimited using "`input'", varnames(1) case(lower) clear
capture confirm string variable state
if !_rc {
    destring state, replace
}
capture confirm string variable place
if !_rc {
    destring place, replace
}

count if state == 16 & place == 72100
assert r(N) == 14

egen long city = group(state place)
isid city year
xtset city year

gen double lvalue = ln(median_home_value) if median_home_value > 0
regress lvalue i.state median_household_income population_total ///
    vacancy_rate single_family_share tourism_employment_share
predict double price_residuals, residuals

* Match comparison cities to Sandpoint on pre-policy residualized level,
* linear trend, and first-difference volatility.
tempfile slopes donor_ids

preserve
    keep if year < 2018
    gen double t = year
    statsby slope_pre = _b[t], by(city) saving("`slopes'", replace): ///
        regress price_residuals t
restore

preserve
    keep if year < 2018
    gen double dprice = D.price_residuals
    bysort city: egen double level_pre = mean(price_residuals)
    bysort city: egen double vol_pre = sd(dprice)
    collapse (mean) level_pre vol_pre, ///
        by(city state place place_name state_name)
    merge 1:1 city using "`slopes'", assert(match) nogen

    foreach metric in level_pre slope_pre vol_pre {
        egen double z_`metric' = std(`metric')
    }

    quietly summarize z_level_pre if state == 16 & place == 72100, meanonly
    local target_level = r(mean)
    quietly summarize z_slope_pre if state == 16 & place == 72100, meanonly
    local target_slope = r(mean)
    quietly summarize z_vol_pre if state == 16 & place == 72100, meanonly
    local target_vol = r(mean)
    assert !missing(`target_level', `target_slope', `target_vol')

    gen double dist_score = sqrt( ///
        (z_level_pre - `target_level')^2 + ///
        (z_slope_pre - `target_slope')^2 + ///
        (z_vol_pre - `target_vol')^2)
    keep if dist_score < 0.20
    assert state == 16 & place == 72100 if dist_score == 0
    keep city
    duplicates drop
    save "`donor_ids'"
restore

merge m:1 city using "`donor_ids'", keep(match) nogen
gen byte treat_post = state == 16 & place == 72100 & year >= 2018
gen double lprice = ln(median_home_value) if median_home_value > 0
sort city year

capture log close _all
log using "`results'/sdid_model.log", text replace
sdid lprice city year treat_post, vce(placebo) seed(12345) graph
log close

graph export "`results'/sdid_path.png", replace
