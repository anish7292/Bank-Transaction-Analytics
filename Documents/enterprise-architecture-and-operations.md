# Enterprise Architecture and Operations Guide

## Architecture Explanation
The platform follows a modern medallion-style enterprise pattern:
1. Source CSV lands in ADLS Gen2 `raw`.
2. ADF metadata-driven orchestration ingests into SQL staging.
3. ELT procedures validate, cleanse, standardize, and enrich.
4. Star-schema warehouse (`dw`) stores facts/dimensions.
5. Reporting views (`rpt`) feed Power BI semantic model.
6. Audit and reject flows capture reliability evidence.

## Data Flow Explanation
- Ingestion: ADF `pl_master_bank_ingestion` -> `pl_child_ingest_and_load`.
- Validation: `stg.usp_validate_stage_transactions`.
- Transformation/load: `dw.usp_transform_and_load_dw`.
- Monitoring: `audit.Pipeline_Run_Log`, `audit.Pipeline_Error_Log`, `audit.Data_Quality_Metrics`.

## Star Schema Explanation
- Facts: `Fact_Transactions`, `Fact_Fraud`, `Fact_Balance`, `Fact_DailySummary`.
- Dimensions: customer, account, date, merchant, location, branch, payment, device, card, channel, currency, risk, loan.
- Benefits: faster BI slicing, easier KPI aggregation, cleaner semantic layer.

## Security Implementation
- SQL roles/grants: `SQL/13_security_roles_and_grants.sql`.
- Row-level security: `SQL/14_row_level_security.sql`.
- Managed identity usage for ADF linked services.
- Environment secret segregation through CI/CD secret stores.

## Error Handling
- Activity-level retries in ADF.
- Dedicated error pipeline `pl_error_handler`.
- SQL `TRY...CATCH` + explicit transaction blocks.
- Reject table with reason, severity, and rule code.

## Logging Strategy
- Batch/correlation IDs in pipeline logs.
- DQ metric capture per batch and rule.
- Reconciliation procedure for stage-to-fact count parity.

## Monitoring Strategy
- Azure Monitor alert template in `ADF/alerts/azure_monitor_alerts.json`.
- Pipeline failure alerting + duration alerting.
- Daily runbook checks for reject thresholds and stale watermark.

## Performance Optimization
- MERGE/idempotent dimension maintenance.
- Nonclustered indexes on high-selectivity fact keys.
- Batch writes in ADF copy sink.
- Reporting views for BI query simplification.

## Scalability Discussion
- Metadata-driven onboarding of new source paths.
- Partition-ready ADLS path strategy by date.
- SQL scale-up/scale-out options via service tier adjustments.

## Cost Optimization
- Scheduled batching vs always-on processing.
- Archive old raw data to cool tier.
- Right-size Azure SQL and scale for load windows.
- Incremental loads reduce compute and refresh cost.
