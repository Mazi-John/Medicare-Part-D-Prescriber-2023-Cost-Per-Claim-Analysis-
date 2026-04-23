# Table Name — `opioids_antibiotics_psychs`

## Table Overview
- **Description:** Prescriber-level utilization and cost metrics for opioid, long-acting opioid, antibiotic, and antipsychotic prescribing.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `opioid_tot_clms` | INTEGER | Total opioid claims, including refills. |  |
| `opioid_tot_drug_cst` | NUMERIC | Aggregate cost paid for opioid drugs. |  |
| `opioid_tot_suply` | INTEGER | Total days supply of opioid drugs. |  |
| `opioid_tot_benes` | INTEGER | Number of beneficiaries filling opioid claims. |  |
| `opioid_prscrbr_rate` | NUMERIC | Opioid claims divided by total claims, multiplied by 100. |  |
| `opioid_la_tot_clms` | INTEGER | Total long-acting opioid claims, including refills. |  |
| `opioid_la_tot_drug_cst` | NUMERIC | Aggregate cost paid for long-acting opioid drugs. |  |
| `opioid_la_tot_suply` | INTEGER | Total days supply of long-acting opioid drugs. |  |
| `opioid_la_tot_benes` | INTEGER | Number of beneficiaries filling long-acting opioid claims. |  |
| `opioid_la_prscrbr_rate` | NUMERIC | Long-acting opioid claims divided by opioid claims, multiplied by 100. |  |
| `antbtc_tot_clms` | INTEGER | Total antibiotic claims, including refills. |  |
| `antbtc_tot_drug_cst` | NUMERIC | Aggregate cost paid for antibiotic drugs. |  |
| `antbtc_tot_benes` | INTEGER | Number of beneficiaries filling antibiotic claims. |  |
| `antpsyct_ge65_sprsn_flag` | TEXT | Reason for suppression of antipsychotic 65+ claim and cost measures. |  |
| `antpsyct_ge65_tot_clms` | INTEGER | Total antipsychotic claims for beneficiaries age 65+, including refills. |  |
| `antpsyct_ge65_tot_drug_cst` | NUMERIC | Aggregate cost paid for antipsychotic drugs for beneficiaries age 65+. |  |
| `antpsyct_ge65_bene_suprsn_flag` | TEXT | Reason for suppression of antipsychotic 65+ beneficiary count. |  |
| `antpsyct_ge65_tot_benes` | INTEGER | Number of beneficiaries age 65+ filling antipsychotic claims. |  |


