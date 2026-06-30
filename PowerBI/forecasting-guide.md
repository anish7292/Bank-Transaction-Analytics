# Forecasting and Anomaly Detection Guide

1. Use line chart with `DimDate[Date]` and `[Total Transactions]`.
2. Enable analytics pane forecast:
   - Forecast length: 30 days
   - Seasonality: auto
   - Confidence interval: 95%
3. Enable anomaly detection:
   - Sensitivity: 80
   - Explain by: `DimChannel`, `DimBranch`, `DimMerchant`
4. Publish narrative with smart narrative visual for executive insights.
