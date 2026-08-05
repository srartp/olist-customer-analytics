# Olist Customer Analytics

Customer segmentation and retention analysis of the Brazilian e-commerce
platform Olist (~100k orders, 2016-2018), built as an end-to-end analytics
project: data modeling with dbt, analysis in SQL and Python, and
CRM-oriented business recommendations.

## Business Problem

Olist wants to improve customer retention and optimize its CRM actions.
Which customer segments should be prioritized, and what is the potential
impact?

## Stack

- **DuckDB**: analytical database
- **dbt**: data modeling (staging to marts) and data quality tests
- **SQL**: segmentation, cohort and retention analysis
- **Python (pandas, matplotlib)**: exploration and visualization

## Key Insights

- **Data coverage and cleaning**: the dataset spans Sept 2016 to Oct 2018, but Sept-Dec 2016 show erratic order volumes (as low as 1 order/month), consistent with a platform ramp-up period, and Sept-Oct 2018 are incomplete. Analysis is restricted to Jan 2017 to Aug 2018 for reliable trend and cohort analysis.

- **Customer identifier**: `customer_id` is generated per order, while `customer_unique_id` identifies the actual person. All customer-level analysis uses `customer_unique_id` to avoid inflating customer counts and hiding repeat purchases.

- **Low repeat purchase rate**: only about 3% of customers made more than one purchase overall. Since about 97% of customers made only one purchase, the frequency dimension has limited discriminating power in the RFM segmentation, and most of the segmentation signal comes from recency and monetary value.

- **Retention drops sharply after acquisition**: month-1 retention is consistently below 1% across all monthly cohorts (Jan 2017 to Aug 2018), confirming the low repeat-purchase rate holds consistently across acquisition periods rather than being an isolated anomaly.

- **At Risk customers are high value, not low value**: Champions and At Risk customers show nearly identical average spending (about R$312-313), despite being on opposite ends of the recency dimension. At Risk customers are not simply less valuable, they are high-value customers who have gone quiet, making them a strong reactivation target.

## Recommendations

Based on the RFM segmentation, the following CRM actions are recommended,
drawing on hands-on experience implementing activation campaigns with
Adobe Campaign and Bloomreach:

| Segment | Size | Avg. Spend | Recommended Action | Channel |
|---|---|---|---|---|
| At Risk | 5,955 | R$312 | Time-limited win-back offer | Email + SMS |
| Needs Attention | 15,899 | R$216 | Soft re-engagement with personalized product recommendations | Email |
| Champions | 6,461 | R$312 | Loyalty program / early access to new products | Email + push |
| New Customers | 14,880 | R$163 | Onboarding sequence to drive second purchase | Automated email |
| Loyal Customers | 27,207 | R$134 | Cross-sell / upsell based on purchase history | Email |
| Lost | 6,330 | R$56 | Low priority, low-cost mass campaign only | Mass email |

Given the near-1% month-1 retention rate, a proactive reactivation strategy
(especially for At Risk and Needs Attention) is likely to have more impact
than relying on organic repeat purchases.

## Project Structure

    ├── sql/            # documented analysis queries
    ├── dbt_project/     # dbt project (staging, marts, tests)
    ├── notebooks/       # numbered analysis notebooks
    ├── src/             # reusable Python functions
    └── outputs/         # exported visuals

## How to Reproduce

1. Download the dataset from
   [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
   and place the CSV files in `data/`.

2. Load the raw data into DuckDB:

       duckdb olist.duckdb < sql/00_load_data.sql

3. Install dependencies:

       pip3 install dbt-duckdb duckdb pandas jupyter matplotlib

4. Configure `~/.dbt/profiles.yml` to point to `olist.duckdb`
   (see `dbt_project/` for the expected profile name).

5. Run the dbt models and tests:

       cd dbt_project
       dbt run
       dbt test

6. Explore the analysis notebooks in `notebooks/`, in order:
   `01_exploration.ipynb`, `02_rfm_segmentation.ipynb`,
   `03_retention_cohorts.ipynb`.

## About the Data

Public dataset released by Olist on
[Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
Raw CSVs are not versioned in this repo.