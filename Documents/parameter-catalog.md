# Parameter Catalog

## ADF Global Parameters
- `p_SourceContainer` default: `raw`
- `p_SourceFolder` default: `bank_transactions`
- `p_FilePattern` default: `bank_txn_*.csv`
- `p_TargetSchema` default: `stg`
- `p_TargetTable` default: `Transactions_Raw`
- `p_LoadType` values: `FULL`, `INCREMENTAL`
- `p_WatermarkColumn` default: `Transaction_Date`
- `p_BatchId` runtime-generated GUID

## SQL Procedure Parameters
- `@BatchId UNIQUEIDENTIFIER`
- `@PipelineName NVARCHAR(200)`
- `@SourceFileName NVARCHAR(500)`
- `@LoadStartUtc DATETIME2`
- `@LoadEndUtc DATETIME2`
