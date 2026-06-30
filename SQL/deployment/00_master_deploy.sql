:setvar DbName BANK_TRANSACTION_ANALYTICS
:setvar SqlUser sa
:setvar SqlPassword StrongPassword!123

PRINT 'Starting one-click SQL deployment...';

:r .\01_create_database.sql
:r ..\01_create_schemas.sql
:r ..\02_staging_tables.sql
:r ..\03_control_audit_tables.sql
:r ..\04_validation_functions.sql
:r ..\05_staging_validation_procedures.sql
:r ..\06_dw_dimensions.sql
:r ..\07_dw_facts.sql
:r ..\08_dw_load_procedures.sql
:r ..\09_reporting_views.sql
:r ..\10_kpi_queries.sql
:r ..\11_automation_control.sql
:r ..\13_security_roles_and_grants.sql
:r ..\14_row_level_security.sql
:r ..\15_data_quality_rule_tables.sql
:r ..\16_reconciliation_procedures.sql
:r .\02_seed_reference_data.sql
:r .\03_verification.sql

PRINT 'SQL deployment completed successfully.';
