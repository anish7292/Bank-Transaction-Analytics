IF DB_ID('$(DbName)') IS NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) = 'CREATE DATABASE [$(DbName)]';
    EXEC(@sql);
END;
GO

USE [$(DbName)];
GO
