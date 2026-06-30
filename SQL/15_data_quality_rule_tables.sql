CREATE TABLE ctl.Data_Quality_Rules (
    RuleId INT IDENTITY(1,1) PRIMARY KEY,
    RuleCode NVARCHAR(100) NOT NULL UNIQUE,
    RuleDescription NVARCHAR(500) NOT NULL,
    Severity NVARCHAR(20) NOT NULL,
    ThresholdPct DECIMAL(5,2) NULL,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO ctl.Data_Quality_Rules (RuleCode, RuleDescription, Severity, ThresholdPct)
VALUES
('INVALID_IFSC', 'Invalid IFSC code format', 'HIGH', 0.50),
('MISSING_CUSTOMER', 'Customer_ID is null or blank', 'HIGH', 0.10),
('NEGATIVE_BAL_AFTER', 'Balance_After below allowed threshold', 'MEDIUM', 2.00),
('DUPLICATE_TXN', 'Duplicate Transaction_ID within batch', 'HIGH', 0.05);
GO

CREATE TABLE audit.Data_Quality_Metrics (
    DqMetricId BIGINT IDENTITY(1,1) PRIMARY KEY,
    BatchId UNIQUEIDENTIFIER NOT NULL,
    RuleCode NVARCHAR(100) NOT NULL,
    FailedCount BIGINT NOT NULL,
    TotalCount BIGINT NOT NULL,
    FailedPct DECIMAL(7,4) NOT NULL,
    LoggedUTC DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO
