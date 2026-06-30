# User Manual

## For Data Engineers
- Use ADF master pipeline for daily ingestion.
- Monitor `audit.Pipeline_Run_Log` and `audit.Pipeline_Error_Log`.
- Re-run failed batches by `BatchId`.

## For Analysts
- Query views under `rpt` schema.
- Validate KPI totals against `rpt.vw_daily_transaction_summary`.

## For Business Users
- Use Power BI pages:
  - Executive: strategy KPIs
  - Operational: daily monitoring
  - Management: branch/channel performance
