CREATE TABLE ctl.IngestionMetadata (
    MetadataId INT IDENTITY(1,1) PRIMARY KEY,
    SourceSystem NVARCHAR(100) NOT NULL,
    SourcePath NVARCHAR(300) NOT NULL,
    TargetSchema NVARCHAR(50) NOT NULL,
    TargetTable NVARCHAR(100) NOT NULL,
    LoadType NVARCHAR(20) NOT NULL,
    WatermarkColumn NVARCHAR(100) NOT NULL,
    LastWatermarkValue DATETIME2 NULL,
    PartitionColumn NVARCHAR(100) NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE ctl.Pipeline_Batch_Control (
    BatchId UNIQUEIDENTIFIER PRIMARY KEY,
    PipelineName NVARCHAR(200) NOT NULL,
    LoadType NVARCHAR(20) NOT NULL,
    BatchStatus NVARCHAR(30) NOT NULL DEFAULT 'STARTED',
    CorrelationId NVARCHAR(100) NULL,
    RetryCount INT NOT NULL DEFAULT 0,
    StartedUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CompletedUTC DATETIME2 NULL
);

CREATE TABLE audit.Pipeline_Run_Log (
    PipelineRunId BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchId UNIQUEIDENTIFIER NOT NULL,
    PipelineName NVARCHAR(200) NOT NULL,
    SourceFileName NVARCHAR(500) NULL,
    Status NVARCHAR(30) NOT NULL,
    RowsRead INT NULL,
    RowsWritten INT NULL,
    RejectCount INT NULL,
    CorrelationId NVARCHAR(100) NULL,
    DurationSeconds INT NULL,
    StartUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    EndUTC DATETIME2 NULL
);

CREATE TABLE audit.Pipeline_Error_Log (
    PipelineErrorId BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchId UNIQUEIDENTIFIER NULL,
    PipelineName NVARCHAR(200) NOT NULL,
    ActivityName NVARCHAR(200) NULL,
    ErrorMessage NVARCHAR(MAX) NOT NULL,
    ErrorUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE err.Reject_Transactions (
    RejectId BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchId UNIQUEIDENTIFIER NULL,
    Transaction_ID NVARCHAR(50) NULL,
    SourceFileName NVARCHAR(500) NULL,
    RuleCode NVARCHAR(100) NULL,
    Severity NVARCHAR(20) NULL,
    RejectReason NVARCHAR(500) NOT NULL,
    RejectUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
