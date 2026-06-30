Write-Host "Running Python tests..."
python -m pytest "e:\BANK TRANSACTION ANALYTICS\Python\tests" -q

Write-Host "Run SQL reconciliation manually after batch load:"
Write-Host "EXEC audit.usp_reconcile_batch @BatchId = '<batch-guid>';"
