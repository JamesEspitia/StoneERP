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
	N'Creando la tabla [dbo].[UserCompany]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[UserCompany]
(
	[id_useco] BIGINT IDENTITY(1,1) NOT NULL,
	[user_id] BIGINT NOT NULL
		CONSTRAINT [FK_UserCompany_User]
		FOREIGN KEY REFERENCES [dbo].[User]
		(
			[id_user]
		),
	[company_id] BIGINT NOT NULL
		CONSTRAINT [FK_UserCompany_Company]
		FOREIGN KEY REFERENCES [dbo].[Company]
		(
			[id_compa]
		),
	[useco_active] BIT NOT NULL
		CONSTRAINT [DF_UserCompany_useco_active]
		DEFAULT (1),
	CONSTRAINT [PK_UserCompany] PRIMARY KEY CLUSTERED
	(
		[id_useco] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_User_Company] UNIQUE
	(
		[user_id],
		[company_id]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Representa la relación entre un usuario y una compañía, permitiendo gestionar
el acceso de usuarios a múltiples compañías en el sistema.

¿Para qué sirve?:

1. Gestión de permisos de usuarios por compañía.

2. Control de acceso multiempresa para cada usuario.

3. Seguimiento de actividades de usuarios por compañía.

4. Configuración de preferencias específicas por usuario y compañía.

5. Soporte para roles y responsabilidades diferentes en cada compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para la relación usuario-compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'COLUMN',
	@level2name = N'id_useco';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Usuario asociado a la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'COLUMN',
	@level2name = N'user_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Compañía asociada al usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'COLUMN',
	@level2name = N'company_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si la relación usuario-compañía está activa (1) o inactiva (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'COLUMN',
	@level2name = N'useco_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_UserCompany';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de usuario y compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_User_Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia al usuario en la tabla User.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_UserCompany_User';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la compañía en la tabla Company.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_UserCompany_Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto la relación usuario-compañía se crea como activa (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserCompany',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_UserCompany_useco_active';
GO