# Complete Testing Documentation

## 1) Unit Testing
- Python schema contract test
- Fraud model quality threshold test
- SQL function/procedure smoke checks

## 2) Integration Testing
- ADLS -> ADF -> Staging -> DW end-to-end
- Batch reconciliation after load
- Power BI dataset refresh validation

## 3) System Testing
- Full daily pipeline execution
- Error pipeline routing
- Retry and alert behavior

## 4) Performance Testing
- 500k row ingestion time benchmark
- ELT runtime benchmark
- Key KPI query response benchmark

## 5) Test Cases (Sample)
| Test ID | Test Case | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| UT-001 | Required column contract | pass | pass | Pass |
| UT-002 | Fraud AUC >= 0.70 | pass | pass | Pass |
| IT-001 | Incremental load updates watermark | updated | updated | Pass |
| IT-002 | Invalid IFSC sent to reject | rejected | rejected | Pass |
| ST-001 | Master pipeline success | completed | completed | Pass |
| PT-001 | 500k ingest under SLA | <45 min |  | Pending |

## 6) UAT Report Template
- Business scenario tested
- KPI validated against SQL
- Dashboard navigation/drillthrough verified
- User sign-off (name/date/comments)
