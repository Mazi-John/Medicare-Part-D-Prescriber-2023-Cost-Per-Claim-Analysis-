# Table Name — `prescribers`

## Table Overview
- **Description:** Provider master table. One row per prescriber, identified by National Provider Identifier (NPI).
- **Grain:** One row per prescriber (NPI).
- **Primary Key:** `prscrbr_npi`

## Relationships
- No foreign key relationships.

## Columns
| Column Name | Data Type | Description | Notes |
|---|---|---|---|
| `prscrbr_npi` | BIGINT | National provider identifier (NPI). | Primary key. |
| `prscrbr_last_org_name` | TEXT | Last name or organization name of the provider. |  |
| `prscrbr_first_name` | TEXT | First name of the provider. |  |
| `prscrbr_mi` | TEXT | Middle initial of the provider. |  |
| `prscrbr_crdntls` | TEXT | Credentials of the provider. |  |
| `prscrbr_ent_cd` | TEXT | Entity type code of the provider. |  |
| `prscrbr_type` | TEXT | Provider specialty type. |  |
| `prscrbr_type_src` | TEXT | Source of provider specialty classification. |  |

## Notes
- Generated from the provided PostgreSQL DDL and field-definition notes.
- Data types reflect the uploaded schema.
