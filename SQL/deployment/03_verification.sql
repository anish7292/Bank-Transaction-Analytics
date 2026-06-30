PRINT 'Verification checks';

SELECT 'Schemas' AS CheckName, COUNT(*) AS Cnt
FROM sys.schemas
WHERE name IN ('stg','dw','rpt','ctl','audit','err');

SELECT 'CoreTables' AS CheckName, COUNT(*) AS Cnt
FROM sys.tables
WHERE schema_id IN (SCHEMA_ID('stg'), SCHEMA_ID('dw'), SCHEMA_ID('audit'), SCHEMA_ID('ctl'));

SELECT 'CoreProcedures' AS CheckName, COUNT(*) AS Cnt
FROM sys.procedures
WHERE schema_id IN (SCHEMA_ID('stg'), SCHEMA_ID('dw'), SCHEMA_ID('audit'), SCHEMA_ID('ctl'));

SELECT TOP 5 * FROM ctl.Data_Quality_Rules;
