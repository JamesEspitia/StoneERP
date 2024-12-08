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
	N'Agregando registros a la tabla [dbo].[EntityCatalog]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[EntityCatalog] ON;
GO

INSERT INTO [dbo].[EntityCatalog]
(
	[id_entit],
	[entit_name],
	[entit_descrip],
	[entit_active],
	[entit_config]
)
VALUES
	(1, N'Company', N'Tabla que almacena las compañías del sistema', 1, N'dbo'),
	(2, N'BranchOffice', N'Tabla que almacena las sucursales asociadas a las compañías', 1, N'dbo'),
	(3, N'CostCenter', N'Tabla que almacena los centros de costo de las compañías', 1, N'dbo'),
	(4, N'EntityCatalog', N'Tabla que define las entidades del sistema', 1, N'dbo'),
	(5, N'Permission', N'Tabla que almacena los permisos del sistema', 1, N'dbo'),
	(6, N'Role', N'Tabla que almacena los roles de usuario del sistema', 1, N'dbo'),
	(7, N'User', N'Tabla que almacena los usuarios del sistema', 1, N'dbo'),
	(8, N'UserCompany', N'Tabla que relaciona usuarios con compañías', 1, N'dbo'),
	(9, N'PermiRole', N'Tabla que relaciona permisos con roles', 1, N'dbo'),
	(10, N'PermiUser', N'Tabla que relaciona permisos con usuarios', 1, N'dbo'),
	(11, N'PermiRoleRecord', N'Tabla que almacena registros específicos de permisos para roles', 1, N'dbo'),
	(12, N'PermiUserRecord', N'Tabla que almacena registros específicos de permisos para usuarios', 1, N'dbo');
GO

DBCC CHECKIDENT ('[dbo].[EntityCatalog]', RESEED, 12);
GO

SET IDENTITY_INSERT [dbo].[EntityCatalog] OFF;
GO