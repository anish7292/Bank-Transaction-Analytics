CREATE OR ALTER PROCEDURE audit.usp_reconcile_batch
    @BatchId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @stg_count BIGINT = (
        SELECT COUNT_BIG(1) FROM stg.Transactions_Raw WHERE BatchId = @BatchId
    );
    DECLARE @fact_count BIGINT = (
        SELECT COUNT_BIG(1)
        FROM dw.Fact_Transactions f
        WHERE EXISTS (
            SELECT 1 FROM stg.Transactions_Raw s
            WHERE s.BatchId = @BatchId AND s.Transaction_ID = f.Transaction_ID
        )
    );

    SELECT
        @BatchId AS BatchId,
        @stg_count AS StagingCount,
        @fact_count AS FactCount,
        (@stg_count - @fact_count) AS DeltaCount;
END;
GO
