-- Fraud and risk by region
SELECT
    l.Merchant_State,
    COUNT_BIG(*) AS TotalTxn,
    SUM(CASE WHEN f.Fraud_Label = 1 THEN 1 ELSE 0 END) AS FraudTxn,
    AVG(CAST(f.Risk_Score AS DECIMAL(10,2))) AS AvgRiskScore
FROM dw.Fact_Transactions f
LEFT JOIN dw.DimLocation l ON f.LocationKey = l.LocationKey
GROUP BY l.Merchant_State
ORDER BY FraudTxn DESC;

-- Branch performance
SELECT
    b.Branch_ID,
    COUNT_BIG(*) AS TotalTxn,
    SUM(f.AmountINR) AS TotalAmountINR,
    SUM(CASE WHEN f.Fraud_Label = 1 THEN 1 ELSE 0 END) AS FraudTxn
FROM dw.Fact_Transactions f
LEFT JOIN dw.DimBranch b ON f.BranchKey = b.BranchKey
GROUP BY b.Branch_ID
ORDER BY TotalAmountINR DESC;

-- Customer retention indicator (inactive > 90 days)
WITH last_txn AS (
    SELECT
        c.Customer_ID,
        MAX(CONVERT(date, CONVERT(varchar(8), f.DateKey))) AS LastTxnDate
    FROM dw.Fact_Transactions f
    INNER JOIN dw.DimCustomer c ON f.CustomerKey = c.CustomerKey
    GROUP BY c.Customer_ID
)
SELECT
    Customer_ID,
    LastTxnDate,
    DATEDIFF(DAY, LastTxnDate, CAST(GETDATE() AS date)) AS DaysInactive
FROM last_txn
WHERE DATEDIFF(DAY, LastTxnDate, CAST(GETDATE() AS date)) > 90
ORDER BY DaysInactive DESC;
