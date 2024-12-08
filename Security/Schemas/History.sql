USE [SERP];
GO

SET QUOTED_IDENTIFIER ON;
SET ARITHABORT ON;
SET NUMERIC_ROUNDABORT OFF;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
GO

RAISERROR
(
	N'Creando el esquema [History]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE SCHEMA "History";
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'Ms_Description',
	@value = N'Esquema para almacenamiento de registros modificados.',
	@level0type = N'SCHEMA',
	@level0name=N'History';
GO