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
	N'Agregando registros a la tabla [dbo].[PermiRoleRecord]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[PermiRoleRecord] ON;
GO

INSERT INTO [dbo].[PermiRoleRecord]
(
	[id_perrc],
	[role_id],
	[permission_id],
	[entitycatalog_id],
	[perrc_record],
	[perrc_include]
)
VALUES
	(1, 1, 1, 2, 1, 1),
	(2, 2, 2, 2, 3, 1),
	(3, 4, 4, 2, 4, 0),
	(4, 5, 5, 2, 4, 0),
	(5, 7, 7, 2, -1, 0),
	(6, 1, 1, 3, 1, 1),
	(7, 2, 2, 3, 3, 1),
	(8, 4, 4, 3, 4, 0),
	(9, 5, 5, 3, 4, 0),
	(10, 7, 7, 3, -1, 0);
GO

DBCC CHECKIDENT ('[dbo].[PermiRoleRecord]', RESEED, 10);
GO

SET IDENTITY_INSERT [dbo].[PermiRoleRecord] OFF;
GO