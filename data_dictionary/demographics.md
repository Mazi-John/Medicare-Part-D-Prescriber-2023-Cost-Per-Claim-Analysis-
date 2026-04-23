# Table Name — `demographics`

## Table Overview
- **Description:** Beneficiary demographic and risk characteristics aggregated to the prescriber level.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `bene_avg_age` | NUMERIC | Average age of beneficiaries. |  |
| `bene_age_lt_65_cnt` | INTEGER | Number of beneficiaries younger than 65. |  |
| `bene_age_65_74_cnt` | INTEGER | Number of beneficiaries age 65 to 74. |  |
| `bene_age_75_84_cnt` | INTEGER | Number of beneficiaries age 75 to 84. |  |
| `bene_age_gt_84_cnt` | INTEGER | Number of beneficiaries older than 84. |  |
| `bene_feml_cnt` | INTEGER | Number of female beneficiaries. |  |
| `bene_male_cnt` | INTEGER | Number of male beneficiaries. |  |
| `bene_race_wht_cnt` | INTEGER | Number of non-Hispanic White beneficiaries. |  |
| `bene_race_black_cnt` | INTEGER | Number of Black or African American beneficiaries. |  |
| `bene_race_api_cnt` | INTEGER | Number of Asian Pacific Islander beneficiaries. |  |
| `bene_race_hspnc_cnt` | INTEGER | Number of Hispanic beneficiaries. |  |
| `bene_race_natind_cnt` | INTEGER | Number of American Indian/Alaska Native beneficiaries. |  |
| `bene_race_othr_cnt` | INTEGER | Number of beneficiaries with race not elsewhere classified. |  |
| `bene_dual_cnt` | INTEGER | Number of beneficiaries with both Medicare and Medicaid entitlement. |  |
| `bene_ndual_cnt` | INTEGER | Number of beneficiaries with Medicare-only entitlement. |  |
| `bene_avg_risk_scre` | NUMERIC | Average Hierarchical Condition Category (HCC) risk score of beneficiaries. |  |


