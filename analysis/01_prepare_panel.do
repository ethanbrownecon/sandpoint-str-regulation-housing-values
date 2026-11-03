version 17.0
clear all
set more off

* Run from the repository root. Obtain the ACS extract separately; it is not
* committed because the source file is large.
local input "data/raw/acs_named_places_2009_2023_expanded.csv"
local output "data/processed/cleaned_sample_panel.csv"

capture mkdir "data"
capture mkdir "data/processed"

import delimited using "`input'", varnames(1) case(lower) clear

keep geoid place_name state_name year median_home_value median_gross_rent ///
    median_household_income population_total vacancy_rate ///
    median_year_structure_built seasonal_share single_family_share ///
    tourism_employment_share name state place

capture confirm string variable state
if !_rc {
    destring state, replace
}
capture confirm string variable place
if !_rc {
    destring place, replace
}

drop if year == 2009
drop if inlist(state_name, "Alaska", "Hawaii", "Puerto Rico")

foreach variable in median_home_value median_gross_rent ///
    median_household_income population_total vacancy_rate ///
    median_year_structure_built seasonal_share single_family_share ///
    tourism_employment_share {
    drop if `variable' < 0
}

drop if median_home_value > 2000000
drop if median_gross_rent > 2000
drop if median_household_income > 250000
drop if vacancy_rate > 100
drop if median_year_structure_built > 2025
drop if seasonal_share > 100
drop if single_family_share > 100
drop if tourism_employment_share > 100

* Keep only places observed in every analysis year, 2010 through 2023.
bysort state place: egen n_value_years = total(!missing(median_home_value))
keep if n_value_years == 14
drop n_value_years

isid state place year
assert inrange(year, 2010, 2023)

sort state place year
export delimited using "`output'", replace
