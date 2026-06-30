# Step-by-Step Implementation Guide (Production Path)

## Step 1 - Provision Azure Infrastructure
1. Deploy `infra/main.bicep`.
2. Create ADLS containers: `raw`, `curated`, `audit`, `reject`.
3. Configure SQL firewall and ADF managed identity permissions.

## Step 2 - Database Initialization
1. Run scripts in `SQL/README.md` order.
2. Run extra enterprise scripts:
   - `SQL/13_security_roles_and_grants.sql`
   - `SQL/14_row_level_security.sql`
   - `SQL/15_data_quality_rule_tables.sql`
   - `SQL/16_reconciliation_procedures.sql`

## Step 3 - Data Generation and Landing
1. Run `Python/scripts/generate_banking_dataset.py`.
2. Upload generated files to ADLS raw folder partitioned by date.

## Step 4 - ADF Configuration
1. Import linked services and datasets from `ADF/linkedServices` and `ADF/datasets`.
2. Import pipelines and trigger.
3. Configure global parameters and alert rules.

## Step 5 - Execute Incremental Pipeline
1. Trigger `pl_master_bank_ingestion` with `p_LoadType=INCREMENTAL`.
2. Validate staging and rejection logs.
3. Verify watermark updates in `ctl.IngestionMetadata`.

## Step 6 - Validate Warehouse Loads
1. Execute reconciliation:
   `EXEC audit.usp_reconcile_batch @BatchId='<batch-guid>';`
2. Check DQ metrics and reject thresholds.

## Step 7 - Build Power BI
1. Connect to reporting views.
2. Apply theme and DAX measures.
3. Configure RLS roles and validate access.
4. Add forecasting/anomaly visuals.

## Step 8 - ML Fraud Scoring
1. Train model using `Python/src/train_fraud_model.py`.
2. Score new batch using `Python/src/score_fraud_model.py`.
3. Register model metadata via `Python/src/register_model.py`.

## Step 9 - Testing and Release
1. Run `Testing/run-tests.ps1`.
2. Validate CI workflow status.
3. Publish release notes and evidence screenshots.
