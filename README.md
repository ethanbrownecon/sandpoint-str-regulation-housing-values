# Short-Term Rental Regulation and Home Values in Sandpoint, Idaho

An applied economics research project examining whether Sandpoint, Idaho's
2018 short-term rental (STR) ordinance was followed by a change in local home
values relative to comparable U.S. cities.

## Research question

Did Sandpoint's 2018 cap on non-owner-occupied short-term rentals in
residential zones moderate home-value growth, or did values continue to
diverge from comparable places?

## Data and approach

- **Outcome:** American Community Survey (ACS) 5-year estimate of median
  owner-occupied home value.
- **Geography and period:** U.S. places, using a city-year panel covering
  2010–2023 in the primary analysis.
- **Policy timing:** Sandpoint's STR ordinance took effect in 2018.
- **Method:** Synthetic difference-in-differences (SDID), which combines
  difference-in-differences with synthetic-control weighting to construct a
  comparison from cities selected to resemble Sandpoint before the policy.

The housing data source is the
[U.S. Census Bureau's American Community Survey](https://www.census.gov/programs-surveys/acs).
The empirical method follows Arkhangelsky et al. (2021),
[*Synthetic Difference-in-Differences*](https://doi.org/10.1257/aer.20190159).

## Preliminary reported finding

The current analysis write-up reports a post-2018 SDID estimate of **0.308
log points**, equivalent to approximately **36% higher home values** relative
to its synthetic comparison, with a reported standard error of **0.139**
(*p* = 0.027). This is an estimated relative difference, not evidence that the
ordinance alone caused home values to rise.

**Inference is not yet reconciled.** Available saved analysis outputs also
report a standard error of **0.192** for an estimate of 0.308, while an older
SDID log reports an estimate of **0.115** (standard error **0.135**). These
results may reflect different specifications or data versions; the exact
source of the differences has not been verified. Treat the estimate and
statistical significance as provisional. This repository is a project
overview, not a replication package.

## Interpretation and limitations

The observed post-policy divergence does not establish that the ordinance
caused higher home values. The study's interpretation is limited by:

- ACS 5-year estimates, which pool survey responses across years and can
  smooth short-run changes;
- owner-reported home values and sampling uncertainty, especially in smaller
  places;
- potential differences between Sandpoint and the cities used to construct
  the synthetic comparison;
- concurrent housing-demand shocks, including migration and changes in
  remote work; and
- the lack of direct STR listing and enforcement data to verify how the
  ordinance changed the number of active rentals.

The result is best understood as a preliminary estimate of a relative
post-2018 change, with causal interpretation depending on the validity of the
comparison and the model specification.

## Reproducibility status

This repository intentionally contains a concise project summary only. The
paper document, underlying datasets, and analysis scripts are not included.
Replication materials should be published only after the estimation sample,
specification, inference settings, and reported results have been reconciled
and documented.
