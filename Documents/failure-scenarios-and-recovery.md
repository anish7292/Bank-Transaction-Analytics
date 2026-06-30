# Failure Scenarios and Recovery Methods

| Scenario | Detection | Root Cause Examples | Recovery Method |
|---|---|---|---|
| Pipeline failure | ADF failed run + alert | transient source/SQL outage | retry, rerun child with same `BatchId`, review error log |
| SQL failure | SP exception + error log | deadlock, permission issue | fix root cause, rerun batch, reconciliation check |
| Storage failure | copy activity failure | ADLS unavailable, permission loss | verify MI RBAC, requeue file, rerun pipeline |
| Authentication issues | linked service test failure | secret expiry, MI role revoked | regrant roles/update secret, test connection |
| Missing files | lookup returns empty | upstream delay | hold pipeline, alert upstream, rerun after arrival |
| Corrupt CSV | parse failures/reject spike | bad delimiter/header mismatch | quarantine file, fix source, replay batch |
| Duplicate transactions | DQ metric + dedupe count | source resend | dedupe logic in stage, monitor repeat rate |
| Null critical values | DQ rules fail | incomplete source payload | reject + route to data steward, request resend |
| Late arriving data | watermark drift checks | delayed source systems | overlap window (`T-2`) and replay |
| Incremental load failure | watermark stale | control update failed | rerun `ctl.usp_update_watermark` after successful load |
| Power BI refresh failure | refresh history error | gateway/credential issue | refresh rerun + credential validation |

## Standard Recovery Workflow
1. Identify `BatchId` and `CorrelationId`.
2. Inspect `audit.Pipeline_Error_Log`.
3. Apply fix and replay only impacted batch.
4. Execute `audit.usp_reconcile_batch`.
5. Publish incident summary and preventive control.
