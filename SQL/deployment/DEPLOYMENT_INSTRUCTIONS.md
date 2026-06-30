# One-Click SQL Deployment Instructions

## Prerequisites
- SQLCMD mode enabled in SSMS or use `sqlcmd` CLI.
- Azure SQL connectivity and deployment permissions.

## Deploy
```powershell
sqlcmd -S <server>.database.windows.net -d master -U <user> -P <password> -i "SQL/deployment/00_master_deploy.sql"
```

## Verify
- Review output of `SQL/deployment/03_verification.sql`.
- Validate key objects in `dw`, `stg`, `audit`, and `ctl` schemas.

## Rollback
```powershell
sqlcmd -S <server>.database.windows.net -d BANK_TRANSACTION_ANALYTICS -U <user> -P <password> -i "SQL/deployment/99_rollback.sql"
```

## Notes
- Deployment is idempotent for core seed/config.
- Re-run safe for scripts using `CREATE OR ALTER` and `NOT EXISTS` filters.
