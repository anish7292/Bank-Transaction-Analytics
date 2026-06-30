# Bank Transaction Analytics using Microsoft Azure Data Engineering Pipeline

Enterprise-level end-to-end data engineering and analytics project for banking transactions using Azure services, SQL warehouse modeling, automation, and Power BI.

## Project Outcome

- Ingest raw banking CSV files with Azure Data Factory (ADF)
- Store files in ADLS Gen2 (`raw`, `curated`, `audit`, `reject`)
- Load to Azure SQL staging and transform with ELT stored procedures
- Build star schema warehouse (facts + dimensions)
- Deliver KPI dashboards with Power BI and DAX
- Automate detection, load, validation, transform, refresh, logging, and alerts
- Apply enterprise security (SQL roles, RLS), reconciliation, and CI/CD quality gates
- Include operational fraud ML training/scoring pipeline and test automation

## Architecture

Raw CSV -> ADLS Gen2 Raw -> ADF Master/Child -> SQL Staging -> ELT Procedures -> Warehouse -> Power BI

## Folders

- `Dataset/`
- `ADF/`
- `SQL/`
- `Python/`
- `PowerBI/`
- `Documents/`
- `Architecture/`
- `Screenshots/`
- `Reports/`
- `Presentation/`

## Execution Order

1. Generate dataset (`Python/scripts/generate_banking_dataset.py`)
2. Upload CSV to ADLS raw container
3. Deploy SQL objects from `SQL/` in sequence
4. Import/publish ADF assets from `ADF/`
5. Run master pipeline
6. Refresh Power BI model
7. Run `Testing/run-tests.ps1` and validate CI workflow

## Enterprise Enhancements Added

- Incremental watermark update procedure and ADF incremental controls
- Data quality rules table + DQ metrics logging
- MERGE-based dimension loading and idempotent fact load logic
- SQL security roles and row-level security policy
- Reconciliation procedure for batch-level auditability
- IaC Bicep template and GitHub Actions CI/CD
- Production ML scripts (`train`, `score`, `register`) and pytest test suite

## Evidence for University Viva

- ADF trigger and run history
- Data quality audit and reject logs
- Warehouse fact/dimension counts
- KPI validation SQL outputs
- Dashboard screenshots and business narrative
