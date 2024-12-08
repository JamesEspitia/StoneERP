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
	N'Agregando registros a la tabla [dbo].[PermiUser]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[PermiUser] ON;
GO

INSERT INTO [dbo].[PermiUser]
(
	[id_peusr],
	[usercompany_id],
	[permission_id],
	[entitycatalog_id],
	[peusr_include]
)
VALUES
	(1, 1, 1, 2, 0),
	(2, 2, 2, 2, 1),
	(3, 3, 3, 2, 0),
	(4, 4, 4, 2, 1),
	(5, 5, 5, 2, 0),
	(6, 6, 6, 2, 1),
	(7, 7, 7, 2, 0),
	(8, 1, 1, 3, 0),
	(9, 2, 2, 3, 1),
	(10, 3, 3, 3, 0),
	(11, 4, 4, 3, 1),
	(12, 5, 5, 3, 0),
	(13, 6, 6, 3, 1),
	(14, 7, 7, 3, 0);
GO

DBCC CHECKIDENT ('[dbo].[PermiUser]', RESEED, 14);
GO

SET IDENTITY_INSERT [dbo].[PermiUser] OFF;
GO