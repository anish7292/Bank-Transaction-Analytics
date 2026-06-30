# Azure Data Factory ARM Deployment Guide

## Deploy with Azure CLI
```powershell
az deployment group create `
  --resource-group <rg-name> `
  --template-file "ADF/arm/ARMTemplateForFactory.json" `
  --parameters @"ADF/arm/ARMTemplateParametersForFactory.json"
```

## Environment Deployment
- Dev: `ADF/arm/parameters.dev.json`
- Test: `ADF/arm/parameters.test.json`
- Prod: `ADF/arm/parameters.prod.json`

## Linked Service Parameterization
- `ls_adls_mi.json`: ADLS URL is environment-specific.
- `ls_sql_managed_identity.json`: SQL server/db values injected by parameters.

## CI/CD Readiness
- Build validation in GitHub `ci.yml`.
- Promotion deployment in `cd.yml`.
- Use environment secrets for credentials and connection values.
