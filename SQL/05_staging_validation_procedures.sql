CREATE OR ALTER PROCEDURE stg.usp_validate_stage_transactions
    @BatchId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        DECLARE @total BIGINT;
        SELECT @total = COUNT_BIG(1) FROM stg.Transactions_Raw WHERE BatchId = @BatchId;

        ;WITH d AS (
            SELECT Transaction_ID,
                   ROW_NUMBER() OVER (PARTITION BY Transaction_ID ORDER BY LoadUTC DESC, StageID DESC) AS rn
            FROM stg.Transactions_Raw
            WHERE BatchId = @BatchId
        )
        DELETE r
        FROM stg.Transactions_Raw r
        INNER JOIN d ON r.Transaction_ID = d.Transaction_ID
        WHERE d.rn > 1;

        INSERT INTO err.Reject_Transactions (BatchId, Transaction_ID, RuleCode, Severity, RejectReason)
        SELECT @BatchId, Transaction_ID, 'INVALID_IFSC', 'HIGH', 'INVALID_IFSC'
        FROM stg.Transactions_Raw
        WHERE BatchId = @BatchId AND stg.ufn_is_valid_ifsc(IFSC_Code) = 0;

        DELETE FROM stg.Transactions_Raw
        WHERE BatchId = @BatchId AND stg.ufn_is_valid_ifsc(IFSC_Code) = 0;

        UPDATE stg.Transactions_Raw
        SET Merchant_Name = UPPER(LTRIM(RTRIM(Merchant_Name))),
            Merchant_Category = UPPER(LTRIM(RTRIM(Merchant_Category))),
            Amount = stg.ufn_normalized_currency_amount(Amount, Currency),
            Currency = 'INR'
        WHERE BatchId = @BatchId;

        UPDATE stg.Transactions_Raw
        SET Risk_Score = CASE
            WHEN Fraud_Label = 1 THEN IIF(Risk_Score < 70, 70, Risk_Score)
            WHEN Amount > 100000 THEN IIF(Risk_Score < 60, 60, Risk_Score)
            ELSE Risk_Score
        END
        WHERE BatchId = @BatchId;

        INSERT INTO audit.Data_Quality_Metrics (BatchId, RuleCode, FailedCount, TotalCount, FailedPct)
        SELECT
            @BatchId,
            'INVALID_IFSC',
            COUNT_BIG(1),
            @total,
            CASE WHEN @total = 0 THEN 0 ELSE (COUNT_BIG(1) * 100.0) / @total END
        FROM err.Reject_Transactions
        WHERE BatchId = @BatchId AND RuleCode = 'INVALID_IFSC';

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE audit.usp_log_pipeline_run
    @BatchId UNIQUEIDENTIFIER,
    @Status NVARCHAR(30),
    @PipelineName NVARCHAR(200) = 'pl_child_ingest_and_load',
    @RowsRead INT = NULL,
    @RowsWritten INT = NULL,
    @RejectCount INT = NULL,
    @CorrelationId NVARCHAR(100) = NULL
AS
BEGIN
    INSERT INTO audit.Pipeline_Run_Log
    (BatchId, PipelineName, Status, RowsRead, RowsWritten, RejectCount, CorrelationId, DurationSeconds, StartUTC, EndUTC)
    VALUES
    (@BatchId, @PipelineName, @Status, @RowsRead, @RowsWritten, @RejectCount, @CorrelationId, 0, SYSUTCDATETIME(), SYSUTCDATETIME());
END;
GO

CREATE OR ALTER PROCEDURE audit.usp_log_pipeline_error
    @PipelineName NVARCHAR(200),
    @BatchId UNIQUEIDENTIFIER = NULL,
    @ActivityName NVARCHAR(200) = NULL,
    @ErrorMessage NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO audit.Pipeline_Error_Log (BatchId, PipelineName, ActivityName, ErrorMessage)
    VALUES (@BatchId, @PipelineName, @ActivityName, @ErrorMessage);
END;
GO
