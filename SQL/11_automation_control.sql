CREATE TABLE ctl.File_Ingestion_Log (
    FileLogId BIGINT IDENTITY(1,1) PRIMARY KEY,
    FileName NVARCHAR(500) NOT NULL,
    FilePath NVARCHAR(1000) NOT NULL,
    FileReceivedUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    IsProcessed BIT NOT NULL DEFAULT 0,
    ProcessedUTC DATETIME2 NULL,
    BatchId UNIQUEIDENTIFIER NULL
);

CREATE TABLE ctl.PowerBI_Refresh_Log (
    RefreshLogId BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchId UNIQUEIDENTIFIER NOT NULL,
    RefreshStatus NVARCHAR(30) NOT NULL,
    RefreshUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    Details NVARCHAR(2000) NULL
);

CREATE OR ALTER PROCEDURE ctl.usp_mark_file_processed
    @FileName NVARCHAR(500),
    @BatchId UNIQUEIDENTIFIER
AS
BEGIN
    UPDATE ctl.File_Ingestion_Log
    SET IsProcessed = 1,
        ProcessedUTC = SYSUTCDATETIME(),
        BatchId = @BatchId
    WHERE FileName = @FileName;
END;
GO

CREATE OR ALTER PROCEDURE ctl.usp_update_watermark
    @BatchId UNIQUEIDENTIFIER,
    @SourcePath NVARCHAR(300)
AS
BEGIN
    DECLARE @latest DATETIME2 = (
        SELECT MAX(CAST(Transaction_Date AS DATETIME2))
        FROM stg.Transactions_Raw
        WHERE BatchId = @BatchId
    );

    UPDATE ctl.IngestionMetadata
    SET LastWatermarkValue = @latest
    WHERE SourcePath = @SourcePath;
END;
GO
