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
	N'Agregando registros a la tabla [dbo].[PermiUserRecord]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[PermiUserRecord] ON;
GO

INSERT INTO [dbo].[PermiUserRecord]
(
	[id_peusr],
	[usercompany_id],
	[permission_id],
	[entitycatalog_id],
	[peusr_record],
	[peusr_include]
)
VALUES
	(1, 1, 1, 2, 1, 1),
	(2, 2, 2, 2, 2, 1),
	(3, 3, 3, 2, 3, 0),
	(4, 5, 5, 2, 5, 0),
	(5, 6, 6, 2, -1, 0);
GO

DBCC CHECKIDENT ('[dbo].[PermiUserRecord]', RESEED, 5);
GO

SET IDENTITY_INSERT [dbo].[PermiUserRecord] OFF;
GO