CREATE TABLE dw.Fact_Transactions (
    TransactionKey BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
    Transaction_ID NVARCHAR(50) NOT NULL,
    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    AccountKey INT NOT NULL,
    MerchantKey INT NULL,
    LocationKey INT NULL,
    BranchKey INT NULL,
    PaymentMethodKey INT NULL,
    DeviceKey INT NULL,
    CardKey INT NULL,
    ChannelKey INT NULL,
    CurrencyKey INT NULL,
    RiskKey INT NULL,
    LoanKey INT NULL,
    AmountINR DECIMAL(18,2) NOT NULL,
    Balance_Before DECIMAL(18,2) NULL,
    Balance_After DECIMAL(18,2) NULL,
    Fraud_Label BIT NOT NULL,
    Risk_Score INT NOT NULL
);

CREATE TABLE dw.Fact_Fraud (
    FraudFactKey BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    RiskKey INT NULL,
    AmountINR DECIMAL(18,2) NOT NULL,
    Fraud_Label BIT NOT NULL,
    Risk_Score INT NOT NULL
);

CREATE TABLE dw.Fact_Balance (
    BalanceFactKey BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    AccountKey INT NOT NULL,
    Balance_Before DECIMAL(18,2) NULL,
    Balance_After DECIMAL(18,2) NULL
);

CREATE TABLE dw.Fact_DailySummary (
    DailySummaryKey BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DateKey INT NOT NULL,
    BranchKey INT NULL,
    ChannelKey INT NULL,
    TotalTransactions BIGINT NOT NULL,
    TotalAmountINR DECIMAL(18,2) NOT NULL,
    FraudTransactions BIGINT NOT NULL
);

ALTER TABLE dw.Fact_Transactions ADD CONSTRAINT FK_FactTxn_DimDate FOREIGN KEY (DateKey) REFERENCES dw.DimDate(DateKey);
ALTER TABLE dw.Fact_Transactions ADD CONSTRAINT FK_FactTxn_DimCustomer FOREIGN KEY (CustomerKey) REFERENCES dw.DimCustomer(CustomerKey);
ALTER TABLE dw.Fact_Transactions ADD CONSTRAINT FK_FactTxn_DimAccount FOREIGN KEY (AccountKey) REFERENCES dw.DimAccount(AccountKey);

CREATE NONCLUSTERED INDEX IX_FactTransactions_DateKey ON dw.Fact_Transactions(DateKey);
CREATE NONCLUSTERED INDEX IX_FactTransactions_CustomerKey ON dw.Fact_Transactions(CustomerKey);
CREATE NONCLUSTERED INDEX IX_FactTransactions_BranchKey ON dw.Fact_Transactions(BranchKey);
