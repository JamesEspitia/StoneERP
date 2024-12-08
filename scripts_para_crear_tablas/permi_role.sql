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
	N'Creando la tabla [dbo].[PermiRole]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[PermiRole]
(
	[id_perol] BIGINT IDENTITY(1,1) NOT NULL,
	[role_id] BIGINT NOT NULL
		CONSTRAINT [FK_PermiRole_Role]
		FOREIGN KEY REFERENCES [dbo].[Role]
		(
			[id_role]
		),
	[permission_id] BIGINT NOT NULL
		CONSTRAINT [FK_PermiRole_Permission]
		FOREIGN KEY REFERENCES [dbo].[Permission]
		(
			[id_permi]
		),
	[entitycatalog_id] INT NOT NULL
		CONSTRAINT [FK_PermiRole_EntityCatalog]
		FOREIGN KEY REFERENCES [dbo].[EntityCatalog]
		(
			[id_entit]
		),
	[perol_include] BIT NOT NULL
		CONSTRAINT [DF_PermiRole_perol_include]
		DEFAULT (1),
	[perol_record] BIGINT NULL,
	CONSTRAINT [PK_PermiRole] PRIMARY KEY CLUSTERED
	(
		[id_perol] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_Role_Permission_Entity_Record] UNIQUE
	(
		[role_id],
		[permission_id],
		[entitycatalog_id],
		[perol_record]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Representa los permisos específicos asignados a un rol para una 
entidad particular dentro del sistema.

¿Para qué sirve?:

1. Asignación de permisos específicos por rol y entidad.

2. Control granular de accesos a nivel de rol.

3. Personalización de capacidades por entidad del sistema.

4. Gestión detallada de privilegios por rol.

5. Implementación de políticas de seguridad específicas por rol y entidad.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el permiso de rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'COLUMN',
	@level2name = N'id_perol';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Rol al que se asigna el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'COLUMN',
	@level2name = N'role_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Permiso asignado al rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'COLUMN',
	@level2name = N'permission_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Entidad sobre la que se aplica el permiso.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'COLUMN',
	@level2name = N'entitycatalog_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el permiso se incluye (1) o se excluye (0) para el rol.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'COLUMN',
	@level2name = N'perol_include';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Campo mencionado en unique_together pero no en el modelo.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'COLUMN',
	@level2name = N'perol_record';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_PermiRole';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de rol, permiso, entidad y registro.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_Role_Permission_Entity_Record';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al rol en la tabla Role.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiRole_Role';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al permiso en la tabla Permission.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiRole_Permission';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la entidad en la tabla EntityCatalog.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_PermiRole_EntityCatalog';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el permiso se incluye (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'PermiRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_PermiRole_perol_include';
GO