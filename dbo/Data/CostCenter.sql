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
	N'Agregando registros a la tabla [dbo].[CostCenter]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[CostCenter] ON;
GO

INSERT INTO [dbo].[CostCenter]
(
	[id_cosce],
	[company_id],
	[cosce_parent_id],
	[cosce_code],
	[cosce_name],
	[cosce_description],
	[cosce_budget],
	[cosce_level],
	[cosce_active]
)
VALUES
	(1, 1, NULL, N'CC001', N'Administración', N'Área encargada de la gestión administrativa', 50000.00, 1, 1),
	(2, 1, 1, N'CC002', N'Finanzas', N'Departamento financiero', 30000.00, 2, 1),
	(3, 1, 1, N'CC003', N'Recursos Humanos', N'Responsable de la gestión de personal', 20000.00, 2, 1),
	(4, 1, NULL, N'CC004', N'Operaciones', N'Área operativa principal', 100000.00, 1, 1),
	(5, 1, 4, N'CC005', N'Producción', N'Departamento de producción de bienes', 75000.00, 2, 1);
GO

DBCC CHECKIDENT ('[dbo].[CostCenter]', RESEED, 5);
GO

SET IDENTITY_INSERT [dbo].[CostCenter] OFF;
GO