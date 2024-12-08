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
	N'Creando la tabla [dbo].[User]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[User]
(
	[id_user] BIGINT IDENTITY(1,1) NOT NULL,
	[user_username] NVARCHAR(255) NOT NULL,
	[user_password] NVARCHAR(255) NOT NULL,
	[user_email] NVARCHAR(255) NOT NULL,
	[user_phone] NVARCHAR(255) NULL,
	[user_is_admin] BIT NOT NULL
		CONSTRAINT [DF_User_user_is_admin]
		DEFAULT (0),
	[user_is_active] BIT NOT NULL
		CONSTRAINT [DF_User_user_is_active]
		DEFAULT (1),
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED
	(
		[id_user] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_User_Username] UNIQUE
	(
		[user_username]
	),
	CONSTRAINT [UQ_User_Email] UNIQUE
	(
		[user_email]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Un usuario representa una persona que interactúa con el sistema,
con sus credenciales y datos básicos de acceso.

¿Para qué sirve?:

1. Gestión de acceso y autenticación en el sistema.

2. Almacenamiento de información básica de los usuarios.

3. Control de estados y permisos de usuarios.

4. Seguimiento de actividad y auditoría de usuarios.

5. Base para la personalización de la experiencia de usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para el usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'id_user';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre de usuario para iniciar sesión.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'user_username';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Contraseña encriptada del usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'user_password';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Dirección de correo electrónico del usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'user_email';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Número de teléfono del usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'user_phone';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el usuario es Administrador (1) o normal (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'user_is_admin';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si el usuario está activo (1) o inactivo (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'COLUMN',
	@level2name = N'user_is_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_User';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para el nombre de usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_User_Username';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la dirección de correo electrónico del usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_User_Email';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el usuario no se crea como Administrador (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_User_user_is_admin';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto el usuario se crea como activo (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'User',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_User_user_is_active';
GO