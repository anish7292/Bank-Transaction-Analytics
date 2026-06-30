USE [$(DbName)];
GO

-- Safe rollback for project objects only
IF EXISTS (SELECT 1 FROM sys.security_policies WHERE name = 'BranchAccessPolicy')
    DROP SECURITY POLICY sec.BranchAccessPolicy;
GO

DROP TABLE IF EXISTS dw.Fact_DailySummary, dw.Fact_Balance, dw.Fact_Fraud, dw.Fact_Transactions;
DROP TABLE IF EXISTS dw.DimLoan, dw.DimRisk, dw.DimCurrency, dw.DimChannel, dw.DimCard, dw.DimDevice,
                    dw.DimPaymentMethod, dw.DimBranch, dw.DimLocation, dw.DimMerchant, dw.DimAccount,
                    dw.DimCustomer, dw.DimDate;
DROP TABLE IF EXISTS stg.Transactions_Raw, ctl.IngestionMetadata, ctl.File_Ingestion_Log, ctl.PowerBI_Refresh_Log,
                    ctl.Pipeline_Batch_Control, ctl.Data_Quality_Rules, audit.Data_Quality_Metrics,
                    audit.Pipeline_Run_Log, audit.Pipeline_Error_Log, err.Reject_Transactions, sec.UserBranchAccess;
GO
