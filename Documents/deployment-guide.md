# Deployment Guide

## Infra Deployment Sequence
1. Resource Group
2. ADLS Gen2 with containers
3. Azure SQL Server + DB
4. ADF instance
5. Key Vault secrets

## App Deployment Sequence
1. Deploy SQL objects.
2. Upload ADF JSON artifacts and link datasets/services.
3. Configure triggers and integration runtime.
4. Run smoke batch with one file.
5. Enable production trigger schedule.

## Rollback
- Disable trigger.
- Restore last DB backup if required.
- Replay from latest successful watermark.
