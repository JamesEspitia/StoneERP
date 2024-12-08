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
	N'Agregando registros a la tabla [dbo].[Permission]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[Permission] ON;
GO

INSERT INTO [dbo].[Permission]
(
	[id_permi],
	[name],
	[description],
	[can_create],
	[can_read],
	[can_update],
	[can_delete],
	[can_import],
	[can_export]
)
VALUES
	(1, N'Basic Read', N'Permisos básicos de solo lectura', 0, 1, 0, 0, 0, 0),
	(2, N'Basic Create', N'Permisos básicos de creación y lectura', 1, 1, 0, 0, 0, 0),
	(3, N'CRUD', N'Permisos para crear, leer, actualizar y eliminar', 1, 1, 1, 1, 0, 0),
	(4, N'Admin', N'Permisos administrativos completos, incluyendo CRUD y exportar', 1, 1, 1, 1, 1, 1),
	(5, N'Read Only', N'Permisos de solo lectura y exportación', 0, 1, 0, 0, 0, 1),
	(6, N'Export Only', N'Permisos para exportar datos', 0, 0, 0, 0, 0, 1),
	(7, N'Import Only', N'Permisos para importar datos', 0, 0, 0, 0, 1, 0),
	(8, N'Import Export', N'Permisos para importar y exportar datos', 0, 0, 0, 0, 1, 1);
GO

DBCC CHECKIDENT ('[dbo].[Permission]', RESEED, 8);
GO

SET IDENTITY_INSERT [dbo].[Permission] OFF;
GO