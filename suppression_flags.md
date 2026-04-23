# Table Name — `suppression_flags`

## Table Overview
- **Description:** Suppression flag indicators for age and drug-type summary metrics.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `ge65_sprsn_flag` | TEXT | Reason for suppression of age-65+ claim/fill/cost/day-supply metrics. |  |
| `ge65_bene_sprsn_flag` | TEXT | Reason for suppression of age-65+ beneficiary count. |  |
| `brnd_sprsn_flag` | TEXT | Reason for suppression of brand-name claim and cost metrics. |  |
| `gnrc_sprsn_flag` | TEXT | Reason for suppression of generic claim and cost metrics. |  |
| `othr_sprsn_flag` | TEXT | Reason for suppression of other drug claim and cost metrics. |  |

