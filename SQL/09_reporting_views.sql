CREATE OR ALTER VIEW rpt.vw_transaction_kpi_base
AS
SELECT
    f.Transaction_ID,
    f.DateKey,
    c.Customer_ID,
    b.Branch_ID,
    ch.Transaction_Channel,
    f.AmountINR,
    f.Fraud_Label,
    f.Risk_Score
FROM dw.Fact_Transactions f
INNER JOIN dw.DimCustomer c ON f.CustomerKey = c.CustomerKey
LEFT JOIN dw.DimBranch b ON f.BranchKey = b.BranchKey
LEFT JOIN dw.DimChannel ch ON f.ChannelKey = ch.ChannelKey;
GO

CREATE OR ALTER VIEW rpt.vw_daily_transaction_summary
AS
SELECT
    DateKey,
    COUNT_BIG(1) AS TotalTransactions,
    SUM(AmountINR) AS TotalAmount,
    SUM(CASE WHEN Fraud_Label = 1 THEN 1 ELSE 0 END) AS FraudTransactions,
    AVG(AmountINR) AS AvgTransactionAmount
FROM dw.Fact_Transactions
GROUP BY DateKey;
GO
