# Complete Testing Module

## 1. Unit Tests
- Python data contract tests
- Fraud model quality threshold tests

## 2. Integration Tests
- ADF pipeline execution with sample batch
- SQL validation + DW load procedure run
- Reconciliation procedure checks

## 3. Data Quality Tests
- Duplicate ratio within threshold
- Invalid IFSC reject behavior
- Null critical fields check

## 4. Performance Tests
- 500k row ingestion duration
- Warehouse query response for top KPIs

## 5. UAT Tests
- Dashboard KPI validation against SQL outputs
- Drillthrough, tooltips, filters, role security checks
