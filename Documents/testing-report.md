# Testing Report

## Test Scenarios
- Ingestion of valid files
- Ingestion with malformed IFSC rows
- Duplicate transaction handling
- Fraud flag propagation
- KPI query validation
- Pipeline failure route to error handler

## Results Summary
- Dataset generated: 500,000 rows
- Quality profile generated successfully
- SQL objects created and script package validated syntactically
- ADF JSON templates prepared for import and execution
- Expected reject flow defined for invalid records
- Automated Python tests executed: `2 passed`
- Fraud model baseline AUC threshold test implemented (`>= 0.70`)
- Data contract test implemented for required schema columns
