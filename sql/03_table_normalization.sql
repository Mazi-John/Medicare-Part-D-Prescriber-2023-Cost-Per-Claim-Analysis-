/*
File: 03_table_normalization.sql
Description: broke the large (part_d_2023) table into seven smaller tables and inserted data afterwards
	     - changed prescrbr_npi data type from text to bigint 
	     - enabled easier validation, modular analysis, indexing, indexing and joins
	     - tables are easier to manage and query
Author: John Ofoegbu

*/



--changed the data type of the prscrbr_npi from text to bigint

ALTER TABLE part_d_2023
ALTER COLUMN prscrbr_npi
TYPE BIGINT
USING prscrbr_npi::bigint;

-- create the prescriber table
CREATE TABLE prescribers (
  prscrbr_npi BIGINT PRIMARY KEY,
  prscrbr_last_org_name TEXT,
  prscrbr_first_name TEXT,
  prscrbr_mi TEXT,
  prscrbr_crdntls TEXT,
  prscrbr_ent_cd TEXT,
  prscrbr_type TEXT,
  prscrbr_type_src TEXT
  );

--create table prescriber_location

CREATE TABLE prescriber_location (
       prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
       prscrbr_st1 TEXT,
       prscrbr_st2 TEXT,
       prscrbr_city TEXT,
       prscrbr_state_abrvtn TEXT,
       prscrbr_state_fips TEXT,
       prscrbr_zip5 TEXT,
       prscrbr_ruca TEXT,
       prscrbr_ruca_desc TEXT,
       prscrbr_cntry TEXT
);


--create the drug_summary table
CREATE TABLE drug_summary (
  prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
  tot_clms INTEGER,
  tot_30day_fills NUMERIC,
  tot_drug_cst NUMERIC,
  tot_day_suply INTEGER,
  tot_benes INTEGER
);

--create the demographics table
CREATE TABLE demographics (
  prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
  bene_avg_age NUMERIC,
  bene_age_lt_65_cnt INTEGER,
  bene_age_65_74_cnt INTEGER,
  bene_age_75_84_cnt INTEGER,
  bene_age_gt_84_cnt INTEGER,
  bene_feml_cnt INTEGER,
  bene_male_cnt INTEGER,
  bene_race_wht_cnt INTEGER,
  bene_race_black_cnt INTEGER,
  bene_race_api_cnt INTEGER,
  bene_race_hspnc_cnt INTEGER,
  bene_race_natind_cnt INTEGER,
  bene_race_othr_cnt INTEGER,
  bene_dual_cnt INTEGER,
  bene_ndual_cnt INTEGER,
  bene_avg_risk_scre NUMERIC
);

--create the opioid, antibiotics, antipsychotics details table
CREATE TABLE opioids_antibiotics_psychs (
  prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
  opioid_tot_clms INTEGER,
  opioid_tot_drug_cst NUMERIC,
  opioid_tot_suply INTEGER,
  opioid_tot_benes INTEGER,
  opioid_prscrbr_rate NUMERIC,
  opioid_la_tot_clms INTEGER,
  opioid_la_tot_drug_cst NUMERIC,
  opioid_la_tot_suply INTEGER,
  opioid_la_tot_benes INTEGER,
  opioid_la_prscrbr_rate NUMERIC,
  antbtc_tot_clms INTEGER,
  antbtc_tot_drug_cst NUMERIC,
  antbtc_tot_benes INTEGER,
  antpsyct_ge65_sprsn_flag TEXT,
  antpsyct_ge65_tot_clms INTEGER,
  antpsyct_ge65_tot_drug_cst NUMERIC,
  antpsyct_ge65_bene_suprsn_flag TEXT,
  antpsyct_ge65_tot_benes INTEGER
);

--create table plan_summary
CREATE TABLE plan_summary (
  prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
  lis_sprsn_flag TEXT,
  lis_tot_clms INTEGER,
  lis_drug_cst NUMERIC,
  nonlis_sprsn_flag TEXT,
  nonlis_tot_clms INTEGER,
  nonlis_drug_cst NUMERIC,
  mapd_sprsn_flag TEXT,
  mapd_tot_clms INTEGER,
  mapd_tot_drug_cst NUMERIC,
  pdp_sprsn_flag TEXT,
  pdp_tot_clms INTEGER,
  pdp_tot_drug_cst NUMERIC
);
--create table suppression_flags
CREATE TABLE suppression_flags (
  prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
  ge65_sprsn_flag TEXT,
  ge65_bene_sprsn_flag TEXT,
  brnd_sprsn_flag TEXT,
  gnrc_sprsn_flag TEXT,
  othr_sprsn_flag TEXT
);

-- create table brand_gene_other_drugs
CREATE TABLE brand_gene_other_drugs(
  prscrbr_npi BIGINT PRIMARY KEY REFERENCES prescribers(prscrbr_npi),
  brnd_tot_clms INTEGER,
  brnd_tot_drug_cst NUMERIC,
  gnrc_tot_clms INTEGER,
  gnrc_tot_drug_cst NUMERIC,
  othr_tot_clms INTEGER,
  othr_tot_drug_cst NUMERIC
  );


--insert into prescribers
INSERT INTO prescribers
SELECT 
  prscrbr_npi,
  prscrbr_last_org_name,
  prscrbr_first_name,
  prscrbr_mi,
  prscrbr_crdntls,
  prscrbr_ent_cd,
  prscrbr_type,
  prscrbr_type_src
FROM part_d_2023;

--insert into prescriber_locations
INSERT INTO prescriber_locations
SELECT prscrbr_npi,
       prscrbr_st1,
       prscrbr_st2,
       prscrbr_city,
       prscrbr_state_abrvtn,
       prscrbr_state_fips,
       prscrbr_zip5,
       prscrbr_ruca,
       prscrbr_ruca_desc,
       prscrbr_cntry
FROM part_d_2023;

--insert into opioids_antibiotics_psychs
INSERT INTO opioids_antibiotics_psychs
SELECT 
  prscrbr_npi ,
  opioid_tot_clms ,
  opioid_tot_drug_cst ,
  opioid_tot_suply ,
  opioid_tot_benes ,
  opioid_prscrbr_rate ,
  opioid_la_tot_clms ,
  opioid_la_tot_drug_cst,
  opioid_la_tot_suply ,
  opioid_la_tot_benes ,
  opioid_la_prscrbr_rate ,
  antbtc_tot_clms ,
  antbtc_tot_drug_cst ,
  antbtc_tot_benes ,
  antpsyct_ge65_sprsn_flag ,
  antpsyct_ge65_tot_clms ,
  antpsyct_ge65_tot_drug_cst,
  antpsyct_ge65_bene_suprsn_flag ,
  antpsyct_ge65_tot_benes 
FROM part_d_2023;

--insert into demographics
INSERT INTO demographics
SELECT 
  prscrbr_npi ,
  bene_avg_age ,
  bene_age_lt_65_cnt,
  bene_age_65_74_cnt ,
  bene_age_75_84_cnt ,
  bene_age_gt_84_cnt ,
  bene_feml_cnt,
  bene_male_cnt ,
  bene_race_wht_cnt ,
  bene_race_black_cnt ,
  bene_race_api_cnt ,
  bene_race_hspnc_cnt ,
  bene_race_natind_cnt ,
  bene_race_othr_cnt ,
  bene_dual_cnt ,
  bene_ndual_cnt ,
  bene_avg_risk_scre 
FROM part_d_2023;

--insert into drug_summary
INSERT INTO drug_summary
SELECT 
  prscrbr_npi ,
  tot_clms ,
  tot_30day_fills ,
  tot_drug_cst ,
  tot_day_suply ,
  tot_benes 
FROM part_d_2023;

--insert into suppression_flags
INSERT INTO suppression_flags
SELECT 
  prscrbr_npi ,
  ge65_sprsn_flag ,
  ge65_bene_sprsn_flag,
  brnd_sprsn_flag ,
  gnrc_sprsn_flag ,
  othr_sprsn_flag 
FROM part_d_2023;

--insert into plan_summary
INSERT INTO plan_summary
SELECT 
  prscrbr_npi ,
  lis_sprsn_flag ,
  lis_tot_clms,
  lis_drug_cst ,
  nonlis_sprsn_flag ,
  nonlis_tot_clms ,
  nonlis_drug_cst ,
  mapd_sprsn_flag ,
  mapd_tot_clms ,
  mapd_tot_drug_cst,
  pdp_sprsn_flag,
  pdp_tot_clms,
  pdp_tot_drug_cst
FROM part_d_2023;

--insert into brand_gene_other_drugs
INSERT INTO brand_gene_other_drugs
SELECT
  prscrbr_npi ,
  brnd_tot_clms ,
  brnd_tot_drug_cst ,
  gnrc_tot_clms ,
  gnrc_tot_drug_cst ,
  othr_tot_clms ,
  othr_tot_drug_cst 
FROM part_d_2023;