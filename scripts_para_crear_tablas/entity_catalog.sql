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
	N'Creando la tabla [dbo].[EntityCatalog]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[EntityCatalog]
(
	[id_entit] INT IDENTITY(1,1) NOT NULL,
	[entit_name] NVARCHAR(255) NOT NULL,
	[entit_descrip] NVARCHAR(255) NOT NULL,
	[entit_active] BIT NOT NULL
		CONSTRAINT [DF_EntityCatalog_entit_active]
		DEFAULT (1),
	[entit_config] NVARCHAR(MAX) NULL,
	CONSTRAINT [PK_EntityCatalog] PRIMARY KEY CLUSTERED
	(
		[id_entit] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_EntityCatalog_entit_name] UNIQUE
	(
		[entit_name]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Un catálogo de entidades representa una tabla que almacena todas las entidades 
(modelos) disponibles en el sistema Django, facilitando su gestión y referencia.

¿Para qué sirve?:

1. Mantener un registro centralizado de todas las entidades del sistema.

2. Facilitar la gestión y el mantenimiento de la estructura de la base de datos.

3. Permitir la referencia dinámica a diferentes modelos del sistema.

4. Proveer una base para la implementación de funcionalidades genéricas.

5. Apoyar en la documentación y organización del sistema.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el elemento del catálogo de entidades.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'COLUMN',
	@level2name = N'id_entit';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre del modelo Django asociado.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'COLUMN',
	@level2name = N'entit_name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Descripción del elemento del catálogo de entidades.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'COLUMN',
	@level2name = N'entit_descrip';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el elemento del catálogo está activo (1) o inactivo (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'COLUMN',
	@level2name = N'entit_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Configuración adicional para el elemento del catálogo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'COLUMN',
	@level2name = N'entit_config';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_EntityCatalog';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para el nombre de la entidad.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_EntityCatalog_entit_name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el elemento del catálogo se crea como activo (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'EntityCatalog',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_EntityCatalog_entit_active';
GO