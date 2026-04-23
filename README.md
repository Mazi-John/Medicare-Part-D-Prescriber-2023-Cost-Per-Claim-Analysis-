# Data Dictionary



## Included Tables
- [`prescribers.md`](prescribers.md)
- [`prescriber_location.md`](prescriber_location.md)
- [`drug_summary.md`](drug_summary.md)
- [`demographics.md`](demographics.md)
- [`opioids_antibiotics_psychs.md`](opioids_antibiotics_psychs.md)
- [`plan_summary.md`](plan_summary.md)
- [`suppression_flags.md`](suppression_flags.md)
- [`brand_gene_other_drugs.md`](brand_gene_other_drugs.md)

## Modeling Summary
`prescribers` is the hub table. Each other table uses `prscrbr_npi` as both:
- its primary key
- a foreign key to `prescribers(prscrbr_npi)`

That makes the supporting tables 1:1 extensions of the prescriber entity.
