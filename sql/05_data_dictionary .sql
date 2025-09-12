    prscrbr_npi : national provider identifier
    prscrbr_last_org_name : last name / organisation name of the provider
    prscrbr_first_name : first name of the provider
    prscrbr_mi : middle initial of the provider
    prscrbr_crdntls : credentials of the provider
    prscrbr_ent_cd : entity type of the provider
    prscrbr_st1: street address 1 of the provider
    prscrbr_st2: street address 2 of the provider
    prscrbr_city: city of the provider
    prscrbr_state_abrvtn: state code of the provider
    prscrbr_state_fips: prescriber state FIPS code
    prscrbr_zip5: zip code of the provider (first five digits)
    prscrbr_ruca: prescriber RUCA (rural-urban commuting area codes)
    prscrbr_ruca_desc: prescriber ruca description
    prscrbr_cntry: country code of the provider
    prscrbr_type: provider specialty type
    prscrbr_type_src: source of provider specialty

    -- Clean numeric fields
    NULLIF(tot_clms, '')::INTEGER AS tot_clms: number of medicare part d claims, including refills
    NULLIF(tot_30day_fills, '')::NUMERIC AS tot_30day_fills: number of standardized 30-day fills, including refills
    NULLIF(tot_drug_cst, '')::NUMERIC AS tot_drug_cst: aggregate cost paid for all claims
    NULLIF(tot_day_suply, '')::INTEGER AS tot_day_suply: number of day's supply for all claims
    NULLIF(tot_benes, '')::INTEGER AS tot_benes: number of medicare beneficiaries

    ge65_sprsn_flag: reason for suppression of GE65_tot_clms, GE65_tot_30day_fills, GE65_tot_drug_cst & GE65_tot_day_suply
    NULLIF(ge65_tot_clms, '')::INTEGER AS ge65_tot_clms: number of claims, including refills, for beneficiaries age 65+
    NULLIF(ge65_tot_30day_fills, '')::NUMERIC AS ge65_tot_30day_fills: number of standardized 30-day fills, including refills, for beneficiaries age 65+
    NULLIF(ge65_tot_drug_cst, '')::NUMERIC AS ge65_tot_drug_cst: aggregate cost paid for all claims for beneficiaries age 65+
    NULLIF(ge65_tot_day_suply, '')::INTEGER AS ge65_tot_day_suply: number of day's supply for all claims for beneficiaries age 65+
    ge65_bene_sprsn_flag: reason for suppression of GE65_tot_benes
    NULLIF(ge65_tot_benes, '')::INTEGER AS ge65_tot_benes: number of beneficiaries age 65+

    brnd_sprsn_flag: reason for suppression of brnd_tot_clms and brnd_tot_drug_cst
    NULLIF(brnd_tot_clms, '')::INTEGER AS brnd_tot_clms: total claims of brand-name drugs, including refils
    NULLIF(brnd_tot_drug_cst, '')::NUMERIC AS brnd_tot_drug_cst: aggregate cost paid for brand-name drugs

    gnrc_sprsn_flag: reason for suppression of gnrc_tot_clms and gnrc_tot_drug_cst
    NULLIF(gnrc_tot_clms, '')::INTEGER AS gnrc_tot_clms: total claims of generic drugs, including refills
    NULLIF(gnrc_tot_drug_cst, '')::NUMERIC AS gnrc_tot_drug_cst: aggregate cost paid for generic drugs

    othr_sprsn_flag: reason for suppression of othr_tot_clms and othr_tot_drug_cst
    NULLIF(othr_tot_clms, '')::INTEGER AS othr_tot_clms: total claims of other drugs, including refills
    NULLIF(othr_tot_drug_cst, '')::NUMERIC AS othr_tot_drug_cst: aggregate cost paid for other drugs

    mapd_sprsn_flag: reason for suppression of madp_tot_clms and madp_tot_drug_cst
    NULLIF(mapd_tot_clms, '')::INTEGER AS mapd_tot_clms: number of claims for beneficiaries covered by MADP plans
    NULLIF(mapd_tot_drug_cst, '')::NUMERIC AS mapd_tot_drug_cst: aggregate cost paid for claims filled by beneficiaries in mapd plans

    pdp_sprsn_flag: reason for suppression of pdp_tot_clms and pdp_tot_drug_cst
    NULLIF(pdp_tot_clms, '')::INTEGER AS pdp_tot_clms: number of claims for beneficiaries covered by standalone pdp plans
    NULLIF(pdp_tot_drug_cst, '')::NUMERIC AS pdp_tot_drug_cst: aggregate cost paid for claims filled by beneficiaries in standalone pdp plans

    lis_sprsn_flag: reason for suppression of lis_tot_clms and lis_drug_cst
    NULLIF(lis_tot_clms, '')::INTEGER AS lis_tot_clms: number of claims for beneficiaries covered by low-income subsidy (lis)
    NULLIF(lis_drug_cst, '')::NUMERIC AS lis_drug_cst: aggregate cost paid for claims covered by low-income subsidy

    nonlis_sprsn_flag: reason for suppression of nonlis_tot_clms and nonlis_drug_cst
    NULLIF(nonlis_tot_clms, '')::INTEGER AS nonlis_tot_clms: number of claims for beneficiaries not covered by low-income subsidy
    NULLIF(nonlis_drug_cst, '')::NUMERIC AS nonlis_drug_cst: aggregate cost paid for claims not covered by low-income subsidy

    NULLIF(opioid_tot_clms, '')::INTEGER AS opioid_tot_clms: total claims of opioid drugs, including refills
    NULLIF(opioid_tot_drug_cst, '')::NUMERIC AS opioid_tot_drug_cst: aggregate cost paid for opioid drugs
    NULLIF(opioid_tot_suply, '')::INTEGER AS opioid_tot_suply: number of day's supply of all opioid drugs
    NULLIF(opioid_tot_benes, '')::INTEGER AS opioid_tot_benes: number of medicare beneficiaries filling opioid claims
    NULLIF(opioid_prscrbr_rate, '')::NUMERIC AS opioid_prscrbr_rate: opioid_tot_clms divided by tot_clms, multiplied by 100

    NULLIF(opioid_la_tot_clms, '')::INTEGER AS opioid_la_tot_clms: total claims of long-acting opioid drugs, including refills
    NULLIF(opioid_la_tot_drug_cst, '')::NUMERIC AS opioid_la_tot_drug_cst: aggregate cost paid for long-acting opioid drugs
    NULLIF(opioid_la_tot_suply, '')::INTEGER AS opioid_la_tot_suply: number of day's supply of all long-acting opioid drugs
    NULLIF(opioid_la_tot_benes, '')::INTEGER AS opioid_la_tot_benes: number of medicare beneficiaries filling long-acting opioid claims
    NULLIF(opioid_la_prscrbr_rate, '')::NUMERIC AS opioid_la_prscrbr_rate: opioid_la_tot_clms divided by the opioid_tot_clms, multiplied by 100

    NULLIF(antbtc_tot_clms, '')::INTEGER AS antbtc_tot_clms: total claims of antibiotic drug, including refills
    NULLIF(antbtc_tot_drug_cst, '')::NUMERIC AS antbtc_tot_drug_cst: aggregate cost paid for antibiotic drugs
    NULLIF(antbtc_tot_benes, '')::INTEGER AS antbtc_tot_benes: number of medicare beneficiaries filling antibiotic claims

    antpsyct_ge65_sprsn_flag: reason for suppression of antpsyct_GE65_tot_clms and antpsyct_GE65_tot_drug_cst
    NULLIF(antpsyct_ge65_tot_clms, '')::INTEGER AS antpsyct_ge65_tot_clms: total claims of antipsychotic drugs, including refills, for beneficiaries age 65+
    NULLIF(antpsyct_ge65_tot_drug_cst, '')::NUMERIC AS antpsyct_ge65_tot_drug_cst: aggregate cost paid for antipsychotic drugs for beneficiaries age 65+
    antpsyct_ge65_bene_suprsn_flag: reason for suppression of antpsyct_GE65_tot_benes
    NULLIF(antpsyct_ge65_tot_benes, '')::INTEGER AS antpsyct_ge65_tot_benes: number of medicare beneficiaries age 65+ filling antipsychotic claims

    NULLIF(bene_avg_age, '')::NUMERIC AS bene_avg_age: average age of beneficiaries
    NULLIF(bene_age_lt_65_cnt, '')::INTEGER AS bene_age_lt_65_cnt: number of beneficiaries age less than 65
    NULLIF(bene_age_65_74_cnt, '')::INTEGER AS bene_age_65_74_cnt: number of beneficiaries age 65 to 74
    NULLIF(bene_age_75_84_cnt, '')::INTEGER AS bene_age_75_84_cnt: number of beneficiaries age 75 to 84
    NULLIF(bene_age_gt_84_cnt, '')::INTEGER AS bene_age_gt_84_cnt: number of beneficiaries age greater than 84

    NULLIF(bene_feml_cnt, '')::INTEGER AS bene_feml_cnt: number of female beneficiaries
    NULLIF(bene_male_cnt, '')::INTEGER AS bene_male_cnt: number of male beneficiaries

    NULLIF(bene_race_wht_cnt, '')::INTEGER AS bene_race_wht_cnt: number of non-hispanic white beneficiaries
    NULLIF(bene_race_black_cnt, '')::INTEGER AS bene_race_black_cnt: number of black or african american beneficiaries
    NULLIF(bene_race_api_cnt, '')::INTEGER AS bene_race_api_cnt: number of asian pacific islander beneficiaries
    NULLIF(bene_race_hspnc_cnt, '')::INTEGER AS bene_race_hspnc_cnt: number of hispanic beneficiaries
    NULLIF(bene_race_natind_cnt, '')::INTEGER AS bene_race_natind_cnt: number of american indian/alaskan native beneficiaries
    NULLIF(bene_race_othr_cnt, '')::INTEGER AS bene_race_othr_cnt: number of beneficiaries with race not elsewhere classified

    NULLIF(bene_dual_cnt, '')::INTEGER AS bene_dual_cnt: number of beneficiaries with medicare and medicaid entitlement
    NULLIF(bene_ndual_cnt, '')::INTEGER AS bene_ndual_cnt: number of beneficiaries with medicare only entitlement
    NULLIF(bene_avg_risk_scre, '')::NUMERIC AS bene_avg_risk_scre: average hierarchical condition category (HCC) risk score of beneficiaries