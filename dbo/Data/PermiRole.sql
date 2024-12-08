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
	(7, 7, 7, 2, 1, NULL),
	(8, 1, 1, 3, 1, NULL),
	(9, 2, 2, 3, 0, NULL),
	(10, 3, 3, 3, 1, NULL),
	(11, 4, 4, 3, 0, NULL),
	(12, 5, 5, 3, 1, NULL),
	(13, 6, 6, 3, 0, NULL),
	(14, 7, 7, 3, 1, NULL);
GO

DBCC CHECKIDENT ('[dbo].[PermiRole]', RESEED, 14);
GO

SET IDENTITY_INSERT [dbo].[PermiRole] OFF;
GO