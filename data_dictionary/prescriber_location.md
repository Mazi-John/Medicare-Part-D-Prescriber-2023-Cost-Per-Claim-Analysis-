# Table Name — `prescriber_location`

## Table Overview
- **Description:** Prescriber address and geographic classification details.
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- `prscrbr_npi` references `prescribers(prscrbr_npi)`.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key and foreign key to `prescribers`. |
| `prscrbr_st1` | TEXT | Street address line 1 of the provider. |  |
| `prscrbr_st2` | TEXT | Street address line 2 of the provider. |  |
| `prscrbr_city` | TEXT | City of the provider. |  |
| `prscrbr_state_abrvtn` | TEXT | Two-letter state abbreviation/code of the provider. |  |
| `prscrbr_state_fips` | TEXT | Prescriber state FIPS code. |  |
| `prscrbr_zip5` | TEXT | First five digits of the provider ZIP code. |  |
| `prscrbr_ruca` | TEXT | RUCA code (Rural-Urban Commuting Area). |  |
| `prscrbr_ruca_desc` | TEXT | Description of the RUCA classification. |  |
| `prscrbr_cntry` | TEXT | Country code of the provider. |  |

