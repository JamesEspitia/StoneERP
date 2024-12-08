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
	N'Creando la tabla [dbo].[PermiUser]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[PermiUser]
(
	[id_peusr] BIGINT IDENTITY(1,1) NOT NULL,
	[usercompany_id] BIGINT NOT NULL
		CONSTRAINT [FK_PermiUser_UserCompany]
		FOREIGN KEY REFERENCES [dbo].[UserCompany]([id_useco]),
	[permission_id] BIGINT NOT NULL
		CONSTRAINT [FK_PermiUser_Permission]
		FOREIGN KEY REFERENCES [dbo].[Permission]([id_permi]),
	[entitycatalog_id] INT NOT NULL
		CONSTRAINT [FK_PermiUser_EntityCatalog]
		FOREIGN KEY REFERENCES [dbo].[EntityCatalog]([id_entit]),
	[peusr_include] BIT NOT NULL
		CONSTRAINT [DF_PermiUser_peusr_include]
		DEFAULT (1),
	CONSTRAINT [PK_PermiUser] PRIMARY KEY CLUSTERED
	(
		[id_peusr] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_UserCompany_Permission_Entity] UNIQUE
	(
		[usercompany_id],
		[permission_id],
		[entitycatalog_id]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Representa los permisos específicos asignados a un usuario para una 
entidad particular dentro de una compañía.

¿Para qué sirve?:

1. Asignación de permisos específicos por usuario y entidad.

2. Control granular de accesos a nivel de usuario-compañía.

3. Personalización de capacidades por entidad del sistema.

4. Gestión detallada de privilegios por usuario.

5. Implementación de políticas de seguridad específicas por entidad.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el permiso de usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'COLUMN',
	@level2name = N'id_peusr';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Relación usuario-compañía a la que se asigna el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'COLUMN',
	@level2name = N'usercompany_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permiso asignado al usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'COLUMN',
	@level2name = N'permission_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Entidad sobre la que se aplica el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'COLUMN',
	@level2name = N'entitycatalog_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el permiso se incluye (1) o se excluye (0) para el usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'COLUMN',
	@level2name = N'peusr_include';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_PermiUser';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de usuario-compañía, permiso y entidad.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_UserCompany_Permission_Entity';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la relación usuario-compañía en la tabla UserCompany.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiUser_UserCompany';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al permiso en la tabla Permission.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiUser_Permission';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la entidad en la tabla EntityCatalog.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiUser_EntityCatalog';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el permiso se incluye (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiUser',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_PermiUser_peusr_include';
GO