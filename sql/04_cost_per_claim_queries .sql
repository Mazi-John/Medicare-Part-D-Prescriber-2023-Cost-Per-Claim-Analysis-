COST PER CLAIM MEASURES


1
--query exported to Power BI
SELECT
  p.prscrbr_npi,
  p.prscrbr_first_name,
  p.prscrbr_last_org_name AS prscrbr_last_name,
  p.prscrbr_type AS specialty,
  p.prscrbr_type_src AS prscrbr_source,
  pl.prscrbr_cntry AS prscrbr_country,
  pl.prscrbr_state_abrvtn AS prscrbr_state,
  pl.prscrbr_city,
  pl.prscrbr_zip5 AS prscrbr_zip,
  pl.prscrbr_ruca,
  pl.prscrbr_ruca_desc,
  SUM(ds.tot_clms) AS total_claims,
  SUM(ds.tot_drug_cst) AS total_cost,
  ROUND(SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0), 2) AS cost_per_claim,
  
  CASE
    WHEN SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0) <= 100 THEN 'Tier 1 - Low'
    WHEN SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0) <= 500 THEN 'Tier 2 - Moderate'
    WHEN SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0) <= 1000 THEN 'Tier 3 - High'
    ELSE 'Tier 4 - Very High'
  END AS cost_tier,
  
  CASE 
      WHEN ROUND(ds.tot_drug_cst/ds.tot_clms) <71 THEN 'lower_50%'
      WHEN ROUND(ds.tot_drug_cst/ds.tot_clms) BETWEEN 71.1 AND 145.42 THEN 'btw_50&75%'
      WHEN ROUND(ds.tot_drug_cst/ds.tot_clms) >=610 THEN 'top_5%'
      END AS npi_segments,
      
  ROUND(
      CASE
        WHEN ROUND(SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0), 2) > 2000 THEN 100
        WHEN ROUND(SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0), 2) > 1000 THEN 90
        WHEN ROUND(SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0), 2) > 500 THEN 75
        WHEN ROUND(SUM(ds.tot_drug_cst) / NULLIF(SUM(ds.tot_clms), 0), 2) > 100 THEN 50
        ELSE 25
      END
      + LEAST(ds.tot_clms, 100) * 0.5 -- Volume risk factor
    , 1) AS risk_score
  
 

FROM drug_summary AS ds
JOIN prescribers AS p
ON ds.prscrbr_npi = p.prscrbr_npi
JOIN prescriber_locations AS pl
ON p.prscrbr_npi = pl.prscrbr_npi
GROUP BY p.prscrbr_npi, p.prscrbr_first_name,p.prscrbr_last_org_name,p.prscrbr_type,
					pl.prscrbr_city, pl.prscrbr_state_abrvtn, ds.tot_drug_cst, ds.tot_clms ,pl.prscrbr_cntry,
          pl.prscrbr_zip5, pl.prscrbr_ruca, pl.prscrbr_ruca_desc, p.prscrbr_type_src
          
     ;     





2.
--summary statistics for cost per claim (cpc) for Part D 2023 data

SELECT ROUND(AVG(tot_drug_cst/tot_clms), 2) AS avg_cpc,
       ROUND(MAX(tot_drug_cst/tot_clms), 2) AS max_cpc,
       ROUND(MIN(tot_drug_cst/tot_clms), 2) AS min_cpc,
       ROUND(SUM(tot_drug_cst/tot_clms), 2) AS total_cpc,
       PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY ROUND(tot_drug_cst/tot_clms,2))AS q1_cpc,
       PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY ROUND(tot_drug_cst/tot_clms,2))AS median_cpc,
       PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY ROUND(tot_drug_cst/tot_clms,2))AS q3_cpc,
       PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY ROUND(tot_drug_cst/tot_clms))AS q95th_cpc,
       PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY ROUND(tot_drug_cst/tot_clms))AS q99th_cpc,
       ROUND(CORR(tot_drug_cst, tot_clms)::NUMERIC,2) AS cst_clm_corr,
       ROUND(STDDEV(tot_drug_cst/tot_clms)::NUMERIC, 2) AS stddev_cpc

FROM drug_summary


3.
/*top 5% of prescribers and the % contribution of their brand, 
generic and other drug cost to their cpc*/

SELECT ds.prscrbr_npi, 
       ROUND(ds.tot_drug_cst/ds.tot_clms, 2) AS cpc, 
       bgo.brnd_tot_drug_cst AS brnd_cst, 
       bgo.gnrc_tot_drug_cst AS gnrc_cst,
       bgo.othr_tot_drug_cst AS other_cst,
       CASE WHEN tot_drug_cst != 0 THEN ROUND(brnd_tot_drug_cst * 100.0/tot_drug_cst, 3) ELSE 0 END AS brand_pct,
       CASE WHEN tot_drug_cst != 0 THEN ROUND(gnrc_tot_drug_cst * 100.0 / tot_drug_cst, 3) ELSE 0 END AS generic_pct,
       CASE WHEN tot_drug_cst !=0 THEN ROUND(othr_tot_drug_cst * 100.0 / tot_drug_cst, 3) ELSE 0 END AS other_pct 
FROM drug_summary AS ds
JOIN brand_gene_other_drugs AS bgo
ON ds.prscrbr_npi = bgo.prscrbr_npi
WHERE ROUND(ds.tot_drug_cst/ds.tot_clms, 2) >= 610
ORDER BY cpc DESC;



4.
--number of top 5% prescribers by cost per claim=69153
SELECT COUNT(prscrbr_npi)
FROM drug_summary
WHERE ROUND(tot_drug_cst/tot_clms) >= 610











       

5.
--segmenting prescribers according to their cpc tier system:
--Used this for prioritizing audits, educational outreach, or formulary control.

WITH cost_band AS (
SELECT ROUND(tot_drug_cst/tot_clms, 2) AS cpc, prscrbr_npi
FROM drug_summary
  )
  
  SELECT CASE WHEN cpc <= 100 THEN 'tier_1_low_cost'
  	      WHEN cpc BETWEEN 101 AND 500 THEN 'tier_2_medium_cost'
              WHEN cpc BETWEEN 501 AND 1000 THEN 'tier_3_high_cost'
              WHEN cpc > 1000 THEN 'tier_4_very_high_cost' 
              ELSE 'unknown' END AS tier_category,
	 COUNT (prscrbr_npi)
   
   FROM cost_band
   GROUP BY tier_category
   ORDER BY tier_category



| Tier   | Cost Per Claim | Strategic Use                            |
| ------ | -------------- | ---------------------------------------- |
| Tier 1 | ≤ \$100        | Low-cost, standard care — likely safe    |
| Tier 2 | \$101–\$500    | Medium-cost, may include specialty drugs |
| Tier 3 | \$501–\$1,000  | High-cost, may need deeper review        |
| Tier 4 | > \$1,000      | Very high-cost — potential audit flag    |


6.

-- cost tier-ing and risk scores by prescriber
 
WITH prescriber_summary AS (
  SELECT
    prscrbr_npi,
    SUM(tot_drug_cst) AS total_cost,
    SUM(tot_clms) AS total_claims,
    ROUND(SUM(tot_drug_cst) / NULLIF(SUM(tot_clms), 0), 2) AS cost_per_claim
  FROM 
  	drug_summary
  GROUP BY
    prscrbr_npi
  ORDER BY cost_per_claim DESC
  
),

 prescriber_with_tiers AS (
  SELECT *,
    CASE
      WHEN cost_per_claim <= 100 THEN 'Tier 1 - Low Cost'
      WHEN cost_per_claim <= 500 THEN 'Tier 2 - Moderate Cost'
      WHEN cost_per_claim <= 1000 THEN 'Tier 3 - High Cost'
      ELSE 'Tier 4 - Very High Cost'
    END AS cost_tier,
    
    -- Simple risk score: weighted by cost and volume
    ROUND(
      CASE
        WHEN cost_per_claim > 2000 THEN 100
        WHEN cost_per_claim > 1000 THEN 90
        WHEN cost_per_claim > 500 THEN 75
        WHEN cost_per_claim > 100 THEN 50
        ELSE 25
      END
      + LEAST(total_claims, 100) * 0.5 -- Volume risk factor
    , 1) AS risk_score
  FROM prescriber_summary
)
SELECT * FROM prescriber_with_tiers
ORDER BY risk_score DESC;



DRUG MIX ANALYSIS & GENERIC UTILIZATION

/*top 5% of prescribers and the % contribution of their brand, 
generic and other drug cost to their cpc*/

SELECT ds.prscrbr_npi, 
       ROUND(ds.tot_drug_cst/ds.tot_clms, 2) AS cpc, 
       bgo.brnd_tot_drug_cst AS brnd_cst, 
       bgo.gnrc_tot_drug_cst AS gnrc_cst,
       bgo.othr_tot_drug_cst AS other_cst,
       CASE WHEN tot_drug_cst != 0 THEN ROUND(brnd_tot_drug_cst * 100.0/tot_drug_cst, 3) ELSE 0 END AS brand_pct,
       CASE WHEN tot_drug_cst != 0 THEN ROUND(gnrc_tot_drug_cst * 100.0 / tot_drug_cst, 3) ELSE 0 END AS generic_pct,
       CASE WHEN tot_drug_cst !=0 THEN ROUND(othr_tot_drug_cst * 100.0 / tot_drug_cst, 3) ELSE 0 END AS other_pct 
FROM drug_summary AS ds
JOIN brand_gene_other_drugs AS bgo
ON ds.prscrbr_npi = bgo.prscrbr_npi
WHERE ROUND(ds.tot_drug_cst/ds.tot_clms, 2) >= 610
ORDER BY cpc DESC;

