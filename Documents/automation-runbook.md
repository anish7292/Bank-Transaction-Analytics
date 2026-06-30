# Automation and Operations Runbook

## End-to-End Flow
1. New file lands in `raw/bank_transactions/`.
2. Event/Schedule trigger starts `pl_master_bank_ingestion`.
3. Child pipeline copies data to `stg.Transactions_Raw`.
4. Validation and transform procedures load `dw` facts/dimensions.
5. Audit and error logs written to `audit` schema.
6. Power BI dataset refresh is triggered.
7. Alert sent if any stage fails or reject threshold exceeds limit.

## Retry and Failure Handling
- Copy activities retry: 3 attempts, 45 sec interval.
- Stored procedure activity retries: 2 attempts.
- Failures route to `pl_error_handler`.
- Severe errors send webhook/email alert.

## Replay Strategy
- Reprocess by `BatchId`.
- For late files, rerun child pipeline with file name override.
- Watermark rollback allowed only via controlled SQL script.

## SLA and SLO
- Daily batch completion target: < 45 mins for 500k rows.
- Data freshness target: dashboard updated within 60 mins.
- Data quality reject threshold: <= 2%.
