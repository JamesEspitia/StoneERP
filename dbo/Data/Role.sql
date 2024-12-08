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
	N'Agregando registros a la tabla [dbo].[Role]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[Role] ON;
GO

INSERT INTO [dbo].[Role]
(
	[id_role],
	[company_id],
	[role_name],
	[role_code],
	[role_description],
	[role_active]
)
VALUES
	(1, 1, N'Administrador General', N'ADM_GEN', N'Rol con acceso completo al sistema y todas las funcionalidades.', 1),
	(2, 1, N'Gerente de Ventas', N'GER_VENT', N'Responsable de las operaciones de ventas y sus reportes.', 1),
	(3, 1, N'Analista Financiero', N'ANA_FIN', N'Rol encargado del análisis y reportes financieros.', 1),
	(4, 1, N'Coordinador de Operaciones', N'COOR_OP', N'Responsable de supervisar las operaciones del negocio.', 1),
	(5, 1, N'Técnico de Soporte', N'TEC_SUP', N'Encargado de brindar soporte técnico y resolver incidencias.', 1),
	(6, 1, N'Especialista en Marketing', N'ESP_MKT', N'Rol encargado de estrategias y campañas de marketing.', 1),
	(7, 1, N'Desarrollador Backend', N'DEV_BCK', N'Rol responsable del desarrollo y mantenimiento de sistemas backend.', 1);
GO

DBCC CHECKIDENT ('[dbo].[Role]', RESEED, 7);
GO

SET IDENTITY_INSERT [dbo].[Role] OFF;
GO