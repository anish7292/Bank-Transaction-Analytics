# 120 Viva Questions and Answers (Interview + University)

## Azure Data Factory
1. **What is ADF?** Managed cloud integration service for orchestrating data movement and transformation.
2. **Why use ADF here?** To automate ingestion, incremental loading, retries, and monitoring.
3. **Master vs child pipeline?** Master orchestrates; child executes reusable ingestion/load logic.
4. **What is parameterization in ADF?** Runtime values for source path, table, load type, watermark.
5. **Why metadata-driven pipelines?** Add new sources by config table, not code rewrites.
6. **How is retry handled?** Activity policy with retry count and interval.
7. **How are failures handled?** Error pipeline + SQL audit/error logging.
8. **What is trigger type used?** Schedule trigger; can extend to event trigger.
9. **What is watermark?** Last successful incremental boundary value.
10. **How prevent duplicate load?** Idempotent fact insert and transaction dedupe in staging.
11. **How monitor ADF runs?** ADF Monitor + Azure Monitor alerts + audit tables.
12. **Why managed identity?** Secretless authentication and better security posture.
13. **How support Dev/Test/Prod?** ARM parameter files and environment configs.
14. **What is integration runtime?** Compute infrastructure used by ADF activities.
15. **What are global parameters?** Factory-level values reused across pipelines.

## Azure SQL / Warehouse
16. **Why Azure SQL for this project?** Good enterprise fit for OLAP-lite DW with lower complexity.
17. **What are schemas used?** `stg`, `dw`, `rpt`, `ctl`, `audit`, `err`.
18. **Why staging layer?** Isolates raw loads from curated warehouse transforms.
19. **What is ELT here?** Load first, transform in SQL with stored procedures.
20. **How ensure transaction safety?** `TRY...CATCH` and explicit transactions.
21. **What is reconciliation?** Compare stage and fact counts for each batch.
22. **How tune performance?** Indexes, set-based queries, optimized views, batch writes.
23. **Why use MERGE?** Upsert dimensions with idempotent behavior.
24. **What are audit tables for?** Operational lineage, runtimes, errors, DQ metrics.
25. **How enforce security?** SQL roles, grants, and row-level security policy.
26. **What is RLS?** User-specific row filtering at query time.
27. **Why avoid SELECT *?** Stable contracts and reduced IO.
28. **What is dynamic SQL use case?** Runtime Top-N reporting query generation.
29. **How handle late-arriving data?** Overlap window and replay by batch.
30. **How rollback?** Dedicated rollback script for project objects.

## ADLS Gen2
31. **Why ADLS Gen2?** Scalable, hierarchical namespace, analytics-ready storage.
32. **What are zones?** Raw, curated, audit, reject.
33. **Why partition files by date?** Faster retrieval and manageable incremental loads.
34. **What naming convention is used?** `bank_txn_YYYYMMDD_HHMM_batch.csv`.
35. **How handle corrupt files?** Quarantine to reject + alert + replay.
36. **How secure storage?** RBAC with managed identity and restricted container access.

## ETL vs ELT
37. **Difference ETL vs ELT?** ETL transforms before load; ELT transforms after load.
38. **Why ELT for Azure SQL?** Push transformations to SQL engine, simpler orchestration.
39. **ELT trade-off?** Requires stronger SQL governance and performance tuning.

## Data Warehouse / Star Schema
40. **What is star schema?** Central fact tables linked to denormalized dimensions.
41. **Why star schema for BI?** Fast aggregations and intuitive business slicing.
42. **Fact table in project?** `Fact_Transactions` primary transactional fact.
43. **Dimension table example?** `DimCustomer` with demographic attributes.
44. **What is surrogate key?** Integer warehouse key independent of source systems.
45. **Why keep business keys too?** Traceability to source records.
46. **What is grain?** One row per transaction in `Fact_Transactions`.
47. **How model date?** `DateKey` integer and `DimDate` for time intelligence.
48. **When use snapshot facts?** For periodic balance and daily summaries.
49. **What is conformed dimension?** Shared dimensions reused across facts.
50. **Why separate `rpt` views?** Stable BI interface and abstraction from raw schema.

## Stored Procedures / SQL Patterns
51. **Why stored procedures?** Encapsulation, reusability, security, and operational control.
52. **CTE usage?** Ranking/top-customer and inactivity analysis.
53. **Window function usage?** Dedupe (`ROW_NUMBER`) and ranking metrics.
54. **Pivot usage?** Channel-wise transaction amount cross-tab.
55. **How handle nulls?** DQ rules + standardization + reject routing for critical fields.
56. **How validate IFSC?** Validation function and reject flow.
57. **How standardize merchants?** Trim + uppercase normalization.
58. **Currency conversion strategy?** Normalize to INR in validation phase.
59. **How detect outliers?** Threshold rules and risk score adjustments.
60. **How make loads idempotent?** `NOT EXISTS` filters and MERGE for dimensions.

## Power BI / DAX
61. **Why Power BI?** Enterprise-grade semantic + visualization + governance.
62. **How connect model?** SQL views in `rpt` schema.
63. **What is a measure?** Dynamic calculation evaluated in filter context.
64. **Time intelligence examples?** MTD, YTD, rolling 12M, YoY, QoQ.
65. **Fraud % DAX?** Fraud transactions divided by total transactions.
66. **Why field parameters?** Dynamic axis/measure switching for interactive reports.
67. **What is drillthrough?** Context transfer from summary to detail pages.
68. **What is tooltip page?** Rich hover detail without page navigation.
69. **How optimize report performance?** Fewer visuals, star schema, aggregated views, measure tuning.
70. **How implement RLS in Power BI?** Role filter on user mapping table with `USERPRINCIPALNAME()`.

## Incremental Loading / Reliability
71. **What is incremental load?** Process only new/changed records since watermark.
72. **Where watermark stored?** `ctl.IngestionMetadata.LastWatermarkValue`.
73. **How update watermark?** `ctl.usp_update_watermark` after successful batch.
74. **What if incremental fails mid-run?** Keep old watermark, rerun failed batch safely.
75. **How avoid data loss?** Replay capability and overlap extraction window.
76. **How avoid overcounting?** Dedupe + idempotent inserts.

## Fraud Detection / Analytics
77. **Fraud detection approach?** Rule-based + ML probability scoring.
78. **Models used?** Logistic Regression, Random Forest, optional XGBoost/LightGBM.
79. **Key fraud features?** Amount, channel, merchant category, risk score, credit score.
80. **Why class imbalance matters?** Fraud is rare; accuracy alone is misleading.
81. **Best metric for fraud?** AUC/Recall/Precision trade-off, business-cost aware.
82. **How operationalize ML?** Train, score, register model scripts and threshold governance.
83. **How show ML in BI?** Fraud probability in semantic model visuals.
84. **What is risk scoring?** Composite threat indicator based on transaction and profile attributes.

## Business KPIs and Insights
85. **Core KPI examples?** Total transactions, revenue, fraud %, risk %, branch performance.
86. **How calculate CLV proxy?** Revenue multiplied by retention factor.
87. **What is branch performance?** Volume, value, fraud ratio, channel mix.
88. **What is churn indicator?** Days since last transaction above threshold.
89. **Why peak hour analysis?** Workforce planning and fraud surge detection.
90. **Why segmentation?** Personalized strategy for retention and growth.

## Performance Optimization
91. **Database optimization done?** Clustered PK, nonclustered indexes, set-based loads.
92. **ADF optimization done?** Batch copy settings and retries.
93. **Power BI optimization done?** Measures-first model and reduced visual complexity.
94. **How benchmark performance?** SLA-driven ingestion and query timing tests.
95. **What if SLA breach?** Scale SQL tier, optimize procedures, parallelize safe activities.

## Failure Scenarios / Recovery
96. **How detect pipeline failure?** ADF monitor + alert + audit logs.
97. **How recover from SQL SP failure?** Fix root cause and replay by `BatchId`.
98. **How handle missing file?** Alert, hold batch, rerun when file arrives.
99. **How handle corrupt CSV?** Reject/quarantine and request resend.
100. **How handle duplicate transactions?** Dedupe and monitor DQ metric trend.
101. **How handle auth failures?** Validate MI/RBAC/secret and retest linked service.
102. **How handle Power BI refresh failure?** Fix credentials/gateway and rerun refresh.
103. **How ensure disaster readiness?** Backup/restore plan and DR runbook tests.
104. **How track incident closure?** Post-incident report with preventive action.

## Architecture Trade-offs / Real World
105. **Why Azure SQL vs Synapse?** Lower complexity/cost for student scale; Synapse for massive MPP.
106. **Why batch over streaming?** Simpler and enough for daily banking analytics.
107. **When move to streaming?** Fraud near-real-time requirements.
108. **Why metadata-driven architecture?** Faster source onboarding and reduced code duplication.
109. **What are governance challenges?** Ownership, quality drift, lineage consistency.
110. **How ensure interview readiness?** Explain decisions, trade-offs, and measured outcomes.
111. **Most critical production control?** Reconciliation + idempotent processing.
112. **Biggest risk in banking analytics?** Data quality and delayed failure detection.
113. **How reduce operational risk?** Alerting, runbooks, replay capability, and test automation.
114. **How prove business value?** Fraud reduction potential, faster insights, branch/channel optimization.
115. **How scale to multi-country?** Currency/calendar dimensions, regional policies, local compliance.
116. **How improve model governance?** Versioning, drift checks, retraining cadence.
117. **How improve data governance?** Purview lineage + glossary + stewardship workflow.
118. **How optimize cost long term?** Tiered storage, incremental refresh, workload scheduling.
119. **What is your project uniqueness?** Full enterprise pipeline, not only dashboards.
120. **Final one-line summary?** End-to-end Azure banking analytics platform with automation, governance, and BI.
