# ADLS Gen2 Zone and Partition Design

## Containers
- `raw`: immutable source files from upstream systems.
- `curated`: cleaned intermediate outputs.
- `audit`: pipeline logs, row counts, quality metrics.
- `reject`: invalid records with reason codes.

## Folder Strategy
- `raw/bank_transactions/year=YYYY/month=MM/day=DD/`
- `curated/bank_transactions/year=YYYY/month=MM/day=DD/`
- `audit/pipeline_runs/year=YYYY/month=MM/day=DD/`
- `reject/bank_transactions/year=YYYY/month=MM/day=DD/`

## File Naming Convention
- `bank_txn_<YYYYMMDD_HHMM>_<batch_seq>.csv`

## Incremental Strategy
- Watermark based on `Transaction_Date` + filename ingestion timestamp.
- Late-arriving records handled by overlap window of `T-2 days` in child pipeline.

## Access Pattern
- ADF managed identity: read raw, write curated/audit/reject.
- SQL external loaders: read curated.
- Power BI does not access ADLS directly in this design; it reads SQL views.
