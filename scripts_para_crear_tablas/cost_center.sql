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
	N'Creando la tabla [dbo].[CostCenter]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[CostCenter]
(
	[id_cosce] BIGINT IDENTITY(1,1) NOT NULL,
	[company_id] BIGINT NOT NULL
		CONSTRAINT [FK_CostCenter_Company]
		FOREIGN KEY REFERENCES [dbo].[Company]
		(
			[id_compa]
		),
	[cosce_parent_id] BIGINT NULL
		CONSTRAINT [FK_CostCenter_Parent]
		FOREIGN KEY REFERENCES [dbo].[CostCenter]
		(
			[id_cosce]
		),
	[cosce_code] NVARCHAR(255) NOT NULL,
	[cosce_name] NVARCHAR(255) NOT NULL,
	[cosce_description] NVARCHAR(MAX) NULL,
	[cosce_budget] DECIMAL(15,2) NOT NULL
		CONSTRAINT [DF_CostCenter_cosce_budget]
		DEFAULT (0),
	[cosce_level] SMALLINT NOT NULL
		CONSTRAINT [DF_CostCenter_cosce_level]
		DEFAULT (1),
		CONSTRAINT [CK_CostCenter_Level]
		CHECK ([cosce_level] > 0),
	[cosce_active] BIT NOT NULL
		CONSTRAINT [DF_CostCenter_cosce_active]
		DEFAULT (1),
	CONSTRAINT [PK_CostCenter] PRIMARY KEY CLUSTERED
	(
		[id_cosce] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_Company_CostCenterCode] UNIQUE
	(
		[company_id],
		[cosce_code]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Un centro de costo representa una unidad organizacional dentro de una empresa
que permite agrupar y controlar costos específicos.

¿Para qué sirve?:

1. Gestión y control de costos por unidad organizativa.

2. Seguimiento detallado de gastos y presupuestos por área.

3. Análisis de rentabilidad por centro de responsabilidad.

4. Facilitación de la toma de decisiones basada en costos.

5. Implementación de estructuras jerárquicas para el control de costos.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el centro de costo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'id_cosce';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Compañía a la que pertenece este centro de costo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'company_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Centro de costo superior en la jerarquía organizativa.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_parent_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Código único que identifica el centro de costo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_code';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre descriptivo del centro de costo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Descripción detallada del centro de costo y su propósito.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_description';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Presupuesto asignado al centro de costo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_budget';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nivel en la jerarquía de centros de costo (1 para nivel superior).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_level';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el centro de costo está activo (1) o inactivo (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'COLUMN',
	@level2name = N'cosce_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_CostCenter';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la compañía en la tabla Company.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_CostCenter_Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al centro de costo superior en la tabla CostCenter.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_CostCenter_Parent';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de ID de compañía y código de centro de costo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_Company_CostCenterCode';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Validación del nivel jerárquico del centro de costo (debe ser mayor a 0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'CK_CostCenter_Level';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el presupuesto asignado al centro de costo es cero.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_CostCenter_cosce_budget';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el nivel en la jerarquía de centros de costo es 1, es decir, de nivel superior.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_CostCenter_cosce_level';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el centro de costo se crea como activo (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'CostCenter',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_CostCenter_cosce_active';
GO