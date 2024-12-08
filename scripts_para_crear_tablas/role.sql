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
	N'Creando la tabla [dbo].[Role]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[Role]
(
	[id_role] BIGINT IDENTITY(1,1) NOT NULL,
	[company_id] BIGINT NOT NULL
		CONSTRAINT [FK_Role_Company]
		FOREIGN KEY REFERENCES [Company]
		(
			[id_compa]
		),
	[role_name] NVARCHAR(255) NOT NULL,
	[role_code] NVARCHAR(255) NOT NULL,
	[role_description] NVARCHAR(MAX) NULL,
	[role_active] BIT NOT NULL
		CONSTRAINT [DF_Role_role_active]
		DEFAULT (1),
	CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED
	(
		[id_role] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_Company_RoleCode] UNIQUE
	(
		[company_id],
		[role_code]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Un rol representa un conjunto de permisos y responsabilidades que pueden
ser asignados a usuarios dentro de una compañía específica.

¿Para qué sirve?:

1. Definición de niveles de acceso y permisos por compañía.

2. Agrupación de funcionalidades y accesos para asignación eficiente.

3. Control granular de las capacidades de los usuarios en el sistema.

4. Simplificación de la gestión de permisos por grupos de usuarios.

5. Estandarización de roles y responsabilidades dentro de cada compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'COLUMN',
	@level2name = N'id_role';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Compañía a la que pertenece este rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'COLUMN',
	@level2name = N'company_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre descriptivo del rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'COLUMN',
	@level2name = N'role_name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Código único del rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'COLUMN',
	@level2name = N'role_code';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Descripción detallada del rol y sus responsabilidades.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'COLUMN',
	@level2name = N'role_description';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el rol está activo (1) o inactivo (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'COLUMN',
	@level2name = N'role_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_Role';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de ID de compañía y código de rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_Company_RoleCode';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la compañía en la tabla Company.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_Role_Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el rol se crea como activo (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Role',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Role_role_active';
GO