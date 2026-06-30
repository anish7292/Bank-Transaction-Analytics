CREATE ROLE role_data_engineer;
CREATE ROLE role_data_analyst;
CREATE ROLE role_data_ops;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::stg TO role_data_engineer;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dw TO role_data_engineer;
GRANT EXECUTE ON SCHEMA::stg TO role_data_engineer;
GRANT EXECUTE ON SCHEMA::dw TO role_data_engineer;

GRANT SELECT ON SCHEMA::rpt TO role_data_analyst;
GRANT SELECT ON SCHEMA::dw TO role_data_analyst;

GRANT SELECT, INSERT, UPDATE ON SCHEMA::audit TO role_data_ops;
GRANT EXECUTE ON SCHEMA::audit TO role_data_ops;
GO
