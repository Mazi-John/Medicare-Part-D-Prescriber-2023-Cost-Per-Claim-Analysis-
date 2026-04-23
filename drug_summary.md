# Table Name — `drug_summary`

## Table Overview
- **Description:** Aggregate Medicare Part D utilization and cost metrics at the prescriber level.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `tot_clms` | INTEGER | Number of Medicare Part D claims, including refills. |  |
| `tot_30day_fills` | NUMERIC | Number of standardized 30-day fills, including refills. |  |
| `tot_drug_cst` | NUMERIC | Aggregate cost paid for all claims. |  |
| `tot_day_suply` | INTEGER | Total days supply for all claims. |  |
| `tot_benes` | INTEGER | Number of Medicare beneficiaries. |  |

