-- CTE + Window + Ranking
WITH customer_txn AS (
    SELECT c.Customer_ID, SUM(f.AmountINR) AS TotalAmount
    FROM dw.Fact_Transactions f
    INNER JOIN dw.DimCustomer c ON f.CustomerKey = c.CustomerKey
    GROUP BY c.Customer_ID
)
SELECT TOP 20
    Customer_ID,
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS CustomerRank
FROM customer_txn
ORDER BY TotalAmount DESC;

-- Monthly aggregation
SELECT
    LEFT(CONVERT(VARCHAR(8), DateKey), 6) AS YearMonth,
    COUNT_BIG(1) AS MonthlyTransactions,
    SUM(AmountINR) AS MonthlyAmount
FROM dw.Fact_Transactions
GROUP BY LEFT(CONVERT(VARCHAR(8), DateKey), 6)
ORDER BY YearMonth;

-- Pivot example by transaction channel
SELECT *
FROM (
    SELECT ch.Transaction_Channel, f.AmountINR
    FROM dw.Fact_Transactions f
    LEFT JOIN dw.DimChannel ch ON f.ChannelKey = ch.ChannelKey
) s
PIVOT (
    SUM(AmountINR) FOR Transaction_Channel IN ([ATM],[Branch],[Internet Banking],[Mobile Banking],[UPI])
) p;

-- Dynamic SQL for Top N branches
DECLARE @TopN INT = 10;
DECLARE @sql NVARCHAR(MAX) =
N'SELECT TOP (' + CAST(@TopN AS NVARCHAR(10)) + N')
      b.Branch_ID,
      SUM(f.AmountINR) AS TotalAmount
  FROM dw.Fact_Transactions f
  LEFT JOIN dw.DimBranch b ON f.BranchKey = b.BranchKey
  GROUP BY b.Branch_ID
  ORDER BY SUM(f.AmountINR) DESC;';
EXEC sp_executesql @sql;
