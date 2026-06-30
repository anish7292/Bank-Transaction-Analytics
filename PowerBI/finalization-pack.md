# Power BI Finalization Pack

## Complete DAX Measure List (Core + Advanced)
- Total Transactions
- Total Revenue
- Fraud Transactions
- Fraud %
- Risk Score Avg
- MTD Revenue
- YTD Revenue
- Rolling 12M Revenue
- YoY Growth %
- QoQ Growth %
- Running Total Revenue
- Moving Average 30D
- Top Customer Rank
- Top N Customers Revenue
- Customer Lifetime Value
- Dynamic Title

## Dashboard Build Checklist
- Import dark theme
- Validate star-schema relationships
- Hide technical columns
- Add measure table and display folders
- Configure pages (Executive/Operational/Management/Fraud/Branch)
- Enable drillthrough and tooltips
- Add bookmarks/navigation buttons
- Validate slicers and cross-filtering

## Theme Guide
- Background: `#0F172A`
- Foreground: `#E2E8F0`
- Accent: `#00B3A4`
- Alert: `#EF5350`

## Navigation Flow
Home -> Executive -> Operational -> Fraud -> Branch -> Customer Drillthrough

## KPI Definitions
- Fraud % = Fraud Transactions / Total Transactions
- Risk % = Transactions with high-risk band / Total Transactions
- CLV (proxy) = Revenue * retention factor

## Drillthrough Design
- Customer detail: trend, fraud events, channels used, branch interactions.
- Branch detail: transaction volume, fraud %, ATM usage, peak hours.

## Tooltip Design
- KPI tooltip includes current, prior period, variance, and trend arrow.

## Performance Optimization Checklist
- Prefer measures over calculated columns
- Disable unnecessary bidirectional filters
- Use aggregated views for high-cardinality visuals
- Limit visuals per page and use query reduction options
