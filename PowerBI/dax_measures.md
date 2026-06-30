# DAX Measures Catalog

```DAX
Total Transactions = COUNTROWS(Fact_Transactions)
Total Revenue = SUM(Fact_Transactions[AmountINR])
Fraud Transactions = CALCULATE([Total Transactions], Fact_Transactions[Fraud_Label] = 1)
Fraud % = DIVIDE([Fraud Transactions], [Total Transactions], 0)
Risk Score Avg = AVERAGE(Fact_Transactions[Risk_Score])

MTD Revenue = TOTALMTD([Total Revenue], DimDate[Date])
YTD Revenue = TOTALYTD([Total Revenue], DimDate[Date])
Rolling 12M Revenue =
CALCULATE(
    [Total Revenue],
    DATESINPERIOD(DimDate[Date], MAX(DimDate[Date]), -12, MONTH)
)

YoY Growth % =
DIVIDE(
    [Total Revenue] - CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(DimDate[Date])),
    CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(DimDate[Date])),
    0
)

Top Customer Rank =
RANKX(ALL(DimCustomer[Customer_ID]), [Total Revenue], , DESC, DENSE)

QoQ Growth % =
VAR CurrQ = [Total Revenue]
VAR PrevQ = CALCULATE([Total Revenue], DATEADD(DimDate[Date], -1, QUARTER))
RETURN DIVIDE(CurrQ - PrevQ, PrevQ, 0)

Running Total Revenue =
CALCULATE(
    [Total Revenue],
    FILTER(ALLSELECTED(DimDate[Date]), DimDate[Date] <= MAX(DimDate[Date]))
)

Moving Average 30D =
AVERAGEX(
    DATESINPERIOD(DimDate[Date], MAX(DimDate[Date]), -30, DAY),
    [Total Revenue]
)

Top N Customers Revenue =
VAR TopNTable =
    TOPN(10, ALL(DimCustomer[Customer_ID]), [Total Revenue], DESC)
RETURN
    CALCULATE([Total Revenue], KEEPFILTERS(TopNTable))

Customer Lifetime Value =
[Total Revenue] * 0.25

Dynamic Title =
"Revenue vs Fraud | " & SELECTEDVALUE(DimChannel[Transaction_Channel], "All Channels")
```
