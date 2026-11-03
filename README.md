# Short Term Rental Regulation and Home Values in Sandpoint, Idaho

Senior research seminar project (ECO 499), Berry College, Fall 2025.

## Question

How did home values in Sandpoint, Idaho change after the city's 2018 short term rental ordinance, relative to comparable cities?

## Why it matters

Many tourist towns restrict short term rentals to protect housing for residents. Whether those rules change home values is an open empirical question, and Sandpoint is a small tourism town with a clear policy date, which makes it a useful case.

## Data

The outcome is the American Community Survey (ACS) 5 year estimate of median owner occupied home value for U.S. places, 2010 to 2023, collected through the Census API. Controls include household income, population, vacancy rate, single family share, and tourism employment share. Data files are not included in this repository.

## Method

Synthetic difference in differences (Arkhangelsky et al., 2021), estimated in Stata with the `sdid` package and placebo standard errors. Home values are residualized on state effects and the controls above. Comparison cities are selected by how closely their pre 2018 level, trend, and volatility match Sandpoint's, and the model then builds a weighted synthetic counterfactual from that group.

## Finding

After 2018, home values in Sandpoint rose relative to the synthetic counterfactual. The saved output reports an estimate of 0.308 log points, roughly 36 percent. Estimates differ across saved specifications, so the magnitude should be treated as preliminary. The result is a relative difference, not proof that the ordinance alone caused the change.

## Limitations

- ACS 5 year estimates pool responses across years and smooth short run changes.
- Home values are owner reported and noisy for small places.
- Sandpoint may differ from its comparison cities in ways the controls miss.
- Other shocks in the period, such as migration and remote work, may also have raised home values.
- There is no direct data on active rental listings or enforcement.

## Reproducing the analysis

1. Place the ACS extract at `data/raw/acs_named_places_2009_2023_expanded.csv`.
2. Install Stata 17 or later and the `sdid` command (`ssc install sdid`).
3. From the repository root, run `analysis/01_prepare_panel.do`, then `analysis/02_estimate_sdid.do`.

## Repository contents

- `analysis/01_prepare_panel.do`: cleans the ACS extract and builds a balanced 2010 to 2023 city panel.
- `analysis/02_estimate_sdid.do`: selects comparison cities and estimates the model.
