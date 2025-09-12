DATA PROCESSING & ANALYSIS WORKFLOW

Data Download

•	Source: CMS Medicare Part D Prescribers - by Provider 2023 dataset link: https://data.cms.gov/provider-summary-by-type-of-service/medicare-part-d-prescribers/medicare-part-d-prescribers-by-provider/data

•	File Format: CSV, Size:631MB


Database Setup: Using SQL Shell (psql) and Beekeeper (GUI) graphical user interface

•	Copied column names (84 columns) and their data type to a notepad

•	Created a table on SQL Shell using the above

•	Had trouble importing CSV data into the table on SQL Shell due to data type issues

•	Created a ‘staging table’ (part_d_2023_raw) that defined all columns as TEXT data type so that data import of the CSV file into the already created table on SQL Shell does not fail even on empty or malformed cells
![Loading Script](sql/01_load_raw_staging_table.sql) 

•	Loaded the staging table using:   
\copy part_d_2023_raw FROM 'C:/Users/John/Downloads/Medicare_Part_D_Prescribers_by_Provider_CSV’ DELIMETER ‘,’ CSV HEADER;
This showed a record count of 1,380,665, indicating that the data was successfully imported into the table on SQL Shell without errors.


Data Cleaning & Validation

•	Changed the prescriber NPI column data type from TEXT to BIGINT data type 

•	Created a cleaned table, part_d_2023 from part_d_2023_raw ![Cleaning Script](sql/02_clean_table.sql)



•	Created seven smaller tables from the part_d_2023 into meaningful entities and relationships namely: prescriber, prescriber_location, drug_summary, demographics, opioids_antibiotics_psychs, plan_summary, suppression_flags and brand_gene_other_drug using the CREATE TABLE command. ![Table Normalization](sql/03_table_normalization.sql)

This enables easier validation, modular analysis, indexing, performance, and joins.

•	Inserted data into the smaller tables using the INSERT INTO command

•	Conducted data validation on the tables

Analysis Queries ![Analysis](sql/04_cost_per_claim_queries.sql)

•	summary statistics for cost per claim (cpc) for Part D 2023 data

•	segmenting prescribers according to their cpc tier system: Used this for prioritizing audits, educational outreach, or formulary control

•	cost tiers by prescriber cost per claim

•	top 5% of prescribers and the % contribution of their brand, generic, and other drug costs to their cpc


Export to Power BI






