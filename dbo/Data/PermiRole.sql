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
	N'Agregando registros a la tabla [dbo].[PermiRole]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[PermiRole] ON;
GO

INSERT INTO [dbo].[PermiRole]
(
	[id_perol],
	[role_id],
	[permission_id],
	[entitycatalog_id],
	[perol_include],
	[perol_record]
)
VALUES
	(1, 1, 1, 2, 1, NULL),
	(2, 2, 2, 2, 0, NULL),
	(3, 3, 3, 2, 1, NULL),
	(4, 4, 4, 2, 0, NULL),
	(5, 5, 5, 2, 1, NULL),
	(6, 6, 6, 2, 0, NULL),
	(7, 7, 7, 2, 1, NULL);
GO

DBCC CHECKIDENT ('[dbo].[PermiRole]', RESEED, 7);
GO

SET IDENTITY_INSERT [dbo].[PermiRole] OFF;
GO