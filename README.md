# Olist Customer Analytics

Customer segmentation and retention analysis of the Brazilian e-commerce
platform Olist (~100k orders, 2016–2018), built as an end-to-end analytics
project: data modeling with dbt, analysis in SQL and Python, and
CRM-oriented business recommendations.

## Business Problem

Olist wants to improve customer retention and optimize its CRM actions.
Which customer segments should be prioritized, and what is the potential
impact?

## Stack

- **DuckDB** — analytical database
- **dbt** — data modeling (staging → marts) and data quality tests
- **SQL** — segmentation, cohort and retention analysis
- **Python (pandas, matplotlib)** — exploration and visualization
- **Looker Studio** — final dashboard

## Key Insights

<!-- 3-4 bullet points with numbers + one visual each. Fill as you go. -->
- **Data coverage & cleaning:** The dataset spans Sept 2016 – Oct 2018, but Sept–Dec 2016 show erratic order volumes (as low as 1 order/month) — consistent with a platform ramp-up period — and Sept–Oct 2018 are incomplete. Analysis is restricted to Jan 2017 – Aug 2018 for reliable trend and cohort analysis.

- Given that ~97% of customers made only one purchase, the frequency dimension has limited discriminating power, most of the segmentation signal comes from recency and monetary value."

## Recommendations

<!-- Segment-level CRM activation recommendations with estimated impact -->

## Project Structure

    ├── sql/          # documented analysis queries
    ├── dbt/          # dbt project (staging, marts, tests)
    ├── notebooks/    # numbered analysis notebooks
    ├── src/          # reusable Python functions
    └── outputs/      # exported visuals & dashboard link

## How to Reproduce

<!-- Data source (Kaggle link), setup steps, dbt commands -->

## About the Data

Public dataset released by Olist on
[Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
Raw CSVs are not versioned in this repo.
