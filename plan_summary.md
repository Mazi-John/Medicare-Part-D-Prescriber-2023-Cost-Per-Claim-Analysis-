# Table Name — `plan_summary`

## Table Overview
- **Description:** Prescriber-level utilization and cost metrics split by Medicare Part D plan/benefit categories.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `lis_sprsn_flag` | TEXT | Reason for suppression of low-income subsidy (LIS) claim and cost metrics. |  |
| `lis_tot_clms` | INTEGER | Number of claims for beneficiaries covered by low-income subsidy (LIS). |  |
| `lis_drug_cst` | NUMERIC | Aggregate cost paid for claims covered by low-income subsidy (LIS). |  |
| `nonlis_sprsn_flag` | TEXT | Reason for suppression of non-LIS claim and cost metrics. |  |
| `nonlis_tot_clms` | INTEGER | Number of claims for beneficiaries not covered by low-income subsidy. |  |
| `nonlis_drug_cst` | NUMERIC | Aggregate cost paid for claims not covered by low-income subsidy. |  |
| `mapd_sprsn_flag` | TEXT | Reason for suppression of MAPD claim and cost metrics. |  |
| `mapd_tot_clms` | INTEGER | Number of claims for beneficiaries covered by Medicare Advantage prescription drug (MAPD) plans. |  |
| `mapd_tot_drug_cst` | NUMERIC | Aggregate cost paid for claims filled by beneficiaries in MAPD plans. |  |
| `pdp_sprsn_flag` | TEXT | Reason for suppression of standalone PDP claim and cost metrics. |  |
| `pdp_tot_clms` | INTEGER | Number of claims for beneficiaries covered by standalone prescription drug plans (PDP). |  |
| `pdp_tot_drug_cst` | NUMERIC | Aggregate cost paid for claims filled by beneficiaries in standalone PDP plans. |  |

