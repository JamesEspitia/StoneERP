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
	N'Creando la tabla [dbo].[PermiRoleRecord]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[PermiRoleRecord]
(
	[id_perrc] BIGINT IDENTITY(1,1) NOT NULL,
	[role_id] BIGINT NOT NULL
		CONSTRAINT [FK_PermiRoleRecord_Role]
		FOREIGN KEY REFERENCES [dbo].[Role]
		(
			[id_role]
		),
	[permission_id] BIGINT NOT NULL
		CONSTRAINT [FK_PermiRoleRecord_Permission]
		FOREIGN KEY REFERENCES [dbo].[Permission]
		(
			[id_permi]
		),
	[entitycatalog_id] INT NOT NULL
		CONSTRAINT [FK_PermiRoleRecord_EntityCatalog]
		FOREIGN KEY REFERENCES [dbo].[EntityCatalog]
		(
			[id_entit]
		),
	[perrc_record] BIGINT NOT NULL,
	[perrc_include] BIT NOT NULL
		CONSTRAINT [DF_PermiRoleRecord_perrc_include]
		DEFAULT (1),
	CONSTRAINT [PK_PermiRoleRecord] PRIMARY KEY CLUSTERED
	(
		[id_perrc] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_PermiRoleRecord_role_id_permission_id_entitycatalog_id_perrc_record] UNIQUE
	(
		[role_id],
		[permission_id],
		[entitycatalog_id],
		[perrc_record]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Representa los permisos específicos asignados a un rol para una 
entidad y registro particular dentro del sistema.

¿Para qué sirve?:

1. Asignación de permisos específicos por rol, entidad y registro.

2. Control granular de accesos a nivel de rol y registro.

3. Personalización de capacidades por entidad y registro del sistema.

4. Gestión detallada de privilegios por rol y registro específico.

5. Implementación de políticas de seguridad específicas por rol, entidad y registro.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el permiso de rol por registro.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'COLUMN',
	@level2name = N'id_perrc';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Rol al que se asigna el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'COLUMN',
	@level2name = N'role_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permiso asignado al rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'COLUMN',
	@level2name = N'permission_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Entidad sobre la que se aplica el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'COLUMN',
	@level2name = N'entitycatalog_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador del registro específico al que se aplica el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'COLUMN',
	@level2name = N'perrc_record';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el permiso se incluye (1) o se excluye (0) para el rol y registro.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'COLUMN',
	@level2name = N'perrc_include';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_PermiRoleRecord';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de rol, permiso, entidad y registro.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_PermiRoleRecord_role_id_permission_id_entitycatalog_id_perrc_record';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al rol en la tabla Role.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiRoleRecord_Role';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al permiso en la tabla Permission.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiRoleRecord_Permission';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la entidad en la tabla EntityCatalog.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiRoleRecord_EntityCatalog';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el permiso se incluye (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRoleRecord',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_PermiRoleRecord_perrc_include';
GO