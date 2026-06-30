# Engineering Standards

## SQL Standards
- Use schemas: `stg`, `dw`, `rpt`, `ctl`, `audit`, `err`.
- Prefix stored procedures with `usp_`, functions with `ufn_`, views with `vw_`.
- Use `TRY...CATCH`, explicit transactions, and centralized logging.
- Avoid `SELECT *`; specify column lists for stable contracts.

## ADF Standards
- One master pipeline orchestrates parameterized child pipelines.
- Use metadata tables for source/target mappings and load mode.
- Enforce retry policy on copy/data flow activities.
- Every pipeline writes audit logs for row counts and timings.

## Data Quality Standards
- Duplicate detection by `Transaction_ID`.
- Referential integrity checks for customer/account/branch.
- IFSC and currency validation using reference dimensions.
- Reject invalid rows with reason code into `err.Reject_Transactions`.

## Performance Standards
- Clustered indexes on warehouse surrogate keys.
- Nonclustered indexes on frequent filters (`DateKey`, `CustomerKey`, `BranchKey`).
- Partition large facts by month on `DateKey`.
