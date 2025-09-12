
/*
File: 02_clean_table
Description: provides a clean table from the staging table (part_d_2023_raw)
	     - cleaned sql script for rendering data imported into psql
	     - uses correct data types and handles empty strings with NULL
	     - assumes table name: 'part_d_2023'
Author: John Ofoegbu



CREATE TABLE part_d_2023 AS
SELECT
    prscrbr_npi,
    prscrbr_last_org_name,
    prscrbr_first_name,
    prscrbr_mi,
    prscrbr_crdntls,
    prscrbr_ent_cd,
    prscrbr_st1,
    prscrbr_st2,
    prscrbr_city,
    prscrbr_state_abrvtn,
    prscrbr_state_fips,
    prscrbr_zip5,
    prscrbr_ruca,
    prscrbr_ruca_desc,
    prscrbr_cntry,
    prscrbr_type,
    prscrbr_type_src,

    -- Clean numeric fields
    NULLIF(tot_clms, '')::INTEGER AS tot_clms,
    NULLIF(tot_30day_fills, '')::NUMERIC AS tot_30day_fills,
    NULLIF(tot_drug_cst, '')::NUMERIC AS tot_drug_cst,
    NULLIF(tot_day_suply, '')::INTEGER AS tot_day_suply,
    NULLIF(tot_benes, '')::INTEGER AS tot_benes,

    ge65_sprsn_flag,
    NULLIF(ge65_tot_clms, '')::INTEGER AS ge65_tot_clms,
    NULLIF(ge65_tot_30day_fills, '')::NUMERIC AS ge65_tot_30day_fills,
    NULLIF(ge65_tot_drug_cst, '')::NUMERIC AS ge65_tot_drug_cst,
    NULLIF(ge65_tot_day_suply, '')::INTEGER AS ge65_tot_day_suply,
    ge65_bene_sprsn_flag,
    NULLIF(ge65_tot_benes, '')::INTEGER AS ge65_tot_benes,

    brnd_sprsn_flag,
    NULLIF(brnd_tot_clms, '')::INTEGER AS brnd_tot_clms,
    NULLIF(brnd_tot_drug_cst, '')::NUMERIC AS brnd_tot_drug_cst,

    gnrc_sprsn_flag,
    NULLIF(gnrc_tot_clms, '')::INTEGER AS gnrc_tot_clms,
    NULLIF(gnrc_tot_drug_cst, '')::NUMERIC AS gnrc_tot_drug_cst,

    othr_sprsn_flag,
    NULLIF(othr_tot_clms, '')::INTEGER AS othr_tot_clms,
    NULLIF(othr_tot_drug_cst, '')::NUMERIC AS othr_tot_drug_cst,

    mapd_sprsn_flag,
    NULLIF(mapd_tot_clms, '')::INTEGER AS mapd_tot_clms,
    NULLIF(mapd_tot_drug_cst, '')::NUMERIC AS mapd_tot_drug_cst,

    pdp_sprsn_flag,
    NULLIF(pdp_tot_clms, '')::INTEGER AS pdp_tot_clms,
    NULLIF(pdp_tot_drug_cst, '')::NUMERIC AS pdp_tot_drug_cst,

    lis_sprsn_flag,
    NULLIF(lis_tot_clms, '')::INTEGER AS lis_tot_clms,
    NULLIF(lis_drug_cst, '')::NUMERIC AS lis_drug_cst,

    nonlis_sprsn_flag,
    NULLIF(nonlis_tot_clms, '')::INTEGER AS nonlis_tot_clms,
    NULLIF(nonlis_drug_cst, '')::NUMERIC AS nonlis_drug_cst,

    NULLIF(opioid_tot_clms, '')::INTEGER AS opioid_tot_clms,
    NULLIF(opioid_tot_drug_cst, '')::NUMERIC AS opioid_tot_drug_cst,
    NULLIF(opioid_tot_suply, '')::INTEGER AS opioid_tot_suply,
    NULLIF(opioid_tot_benes, '')::INTEGER AS opioid_tot_benes,
    NULLIF(opioid_prscrbr_rate, '')::NUMERIC AS opioid_prscrbr_rate,

    NULLIF(opioid_la_tot_clms, '')::INTEGER AS opioid_la_tot_clms,
    NULLIF(opioid_la_tot_drug_cst, '')::NUMERIC AS opioid_la_tot_drug_cst,
    NULLIF(opioid_la_tot_suply, '')::INTEGER AS opioid_la_tot_suply,
    NULLIF(opioid_la_tot_benes, '')::INTEGER AS opioid_la_tot_benes,
    NULLIF(opioid_la_prscrbr_rate, '')::NUMERIC AS opioid_la_prscrbr_rate,

    NULLIF(antbtc_tot_clms, '')::INTEGER AS antbtc_tot_clms,
    NULLIF(antbtc_tot_drug_cst, '')::NUMERIC AS antbtc_tot_drug_cst,
    NULLIF(antbtc_tot_benes, '')::INTEGER AS antbtc_tot_benes,

    antpsyct_ge65_sprsn_flag,
    NULLIF(antpsyct_ge65_tot_clms, '')::INTEGER AS antpsyct_ge65_tot_clms,
    NULLIF(antpsyct_ge65_tot_drug_cst, '')::NUMERIC AS antpsyct_ge65_tot_drug_cst,
    antpsyct_ge65_bene_suprsn_flag,
    NULLIF(antpsyct_ge65_tot_benes, '')::INTEGER AS antpsyct_ge65_tot_benes,

    NULLIF(bene_avg_age, '')::NUMERIC AS bene_avg_age,
    NULLIF(bene_age_lt_65_cnt, '')::INTEGER AS bene_age_lt_65_cnt,
    NULLIF(bene_age_65_74_cnt, '')::INTEGER AS bene_age_65_74_cnt,
    NULLIF(bene_age_75_84_cnt, '')::INTEGER AS bene_age_75_84_cnt,
    NULLIF(bene_age_gt_84_cnt, '')::INTEGER AS bene_age_gt_84_cnt,

    NULLIF(bene_feml_cnt, '')::INTEGER AS bene_feml_cnt,
    NULLIF(bene_male_cnt, '')::INTEGER AS bene_male_cnt,

    NULLIF(bene_race_wht_cnt, '')::INTEGER AS bene_race_wht_cnt,
    NULLIF(bene_race_black_cnt, '')::INTEGER AS bene_race_black_cnt,
    NULLIF(bene_race_api_cnt, '')::INTEGER AS bene_race_api_cnt,
    NULLIF(bene_race_hspnc_cnt, '')::INTEGER AS bene_race_hspnc_cnt,
    NULLIF(bene_race_natind_cnt, '')::INTEGER AS bene_race_natind_cnt,
    NULLIF(bene_race_othr_cnt, '')::INTEGER AS bene_race_othr_cnt,

    NULLIF(bene_dual_cnt, '')::INTEGER AS bene_dual_cnt,
    NULLIF(bene_ndual_cnt, '')::INTEGER AS bene_ndual_cnt,
    NULLIF(bene_avg_risk_scre, '')::NUMERIC AS bene_avg_risk_scre

FROM part_d_2023_raw;
