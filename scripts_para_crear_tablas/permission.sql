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
	N'Creando la tabla [dbo].[Permission]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[Permission]
(
	[id_permi] BIGINT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(255) NOT NULL,
	[description] NVARCHAR(MAX) NULL,
	[can_create] BIT NOT NULL
		CONSTRAINT [DF_Permission_can_create]
		DEFAULT (0),
	[can_read] BIT NOT NULL
		CONSTRAINT [DF_Permission_can_read]
		DEFAULT (0),
	[can_update] BIT NOT NULL
		CONSTRAINT [DF_Permission_can_update]
		DEFAULT (0),
	[can_delete] BIT NOT NULL
		CONSTRAINT [DF_Permission_can_delete]
		DEFAULT (0),
	[can_import] BIT NOT NULL
		CONSTRAINT [DF_Permission_can_import]
		DEFAULT (0),
	[can_export] BIT NOT NULL
		CONSTRAINT [DF_Permission_can_export]
		DEFAULT (0),
	CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED
	(
		[id_permi] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY]
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Un permiso representa los diferentes niveles de acceso y operaciones
que pueden realizarse sobre una entidad del sistema.

¿Para qué sirve?:

1. Control granular de acciones sobre entidades del sistema.

2. Definición de permisos específicos para operaciones CRUD.

3. Gestión de capacidades de importación y exportación de datos.

4. Implementación de políticas de seguridad y acceso.

5. Configuración flexible de permisos por funcionalidad.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'id_permi';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre descriptivo del permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Descripción detallada del permiso y su propósito.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'description';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permite crear nuevos registros.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'can_create';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permite ver registros existentes.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'can_read';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permite modificar registros existentes.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'can_update';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permite eliminar registros existentes.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'can_delete';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permite importar datos masivamente.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'can_import';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permite exportar datos del sistema.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'COLUMN',
	@level2name = N'can_export';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_Permission';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto no permite crear nuevos registros (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Permission_can_create';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto no permite ver registros existentes (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Permission_can_read';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto no permite modificar registros existentes (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Permission_can_update';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto no permite eliminar registros existentes (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Permission_can_delete';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto no permite importar datos masivamente (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Permission_can_import';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto no permite exportar datos del sistema (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Permission',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Permission_can_export';
GO