# Table Name — `brand_gene_other_drugs`

## Table Overview
- **Description:** Prescriber-level utilization and cost metrics by drug type: brand, generic, and other.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `brnd_tot_clms` | INTEGER | Total brand-name drug claims, including refills. |  |
| `brnd_tot_drug_cst` | NUMERIC | Aggregate cost paid for brand-name drugs. |  |
| `gnrc_tot_clms` | INTEGER | Total generic drug claims, including refills. |  |
| `gnrc_tot_drug_cst` | NUMERIC | Aggregate cost paid for generic drugs. |  |
| `othr_tot_clms` | INTEGER | Total claims for other drug categories, including refills. |  |
| `othr_tot_drug_cst` | NUMERIC | Aggregate cost paid for other drug categories. |  |


