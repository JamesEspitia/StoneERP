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
	N'Creando la tabla [dbo].[Company]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[Company]
(
	[id_compa] BIGINT IDENTITY(1,1) NOT NULL,
	[compa_name] NVARCHAR(255) NOT NULL,
	[compa_tradename] NVARCHAR(255) NOT NULL,
	[compa_doctype] NVARCHAR(2) NOT NULL
		CONSTRAINT [CK_Company_DocType]
		CHECK
		(
			[compa_doctype] IN
			(
				'NI',
				'CC',
				'CE',
				'PP',
				'OT'
			)
		),
	[compa_docnum] NVARCHAR(255) NOT NULL,
	[compa_address] NVARCHAR(255) NOT NULL,
	[compa_city] NVARCHAR(255) NOT NULL,
	[compa_state] NVARCHAR(255) NOT NULL,
	[compa_country] NVARCHAR(255) NOT NULL,
	[compa_industry] NVARCHAR(255) NOT NULL,
	[compa_phone] NVARCHAR(255) NOT NULL,
	[compa_email] NVARCHAR(255) NOT NULL,
	[compa_website] NVARCHAR(255) NULL,
	[compa_logo] NVARCHAR(MAX) NULL,
	[compa_active] BIT NOT NULL
		CONSTRAINT [DF_Company_compa_active]
		DEFAULT (1),
	CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED
	(
		[id_compa] ASC
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
	@value = N'Una compañía representa una entidad empresarial con sus datos de identificación,
ubicación y características principales dentro del sistema ERP.

¿Para qué sirve?:

1. Gestión centralizada de la información básica de las empresas en el sistema.

2. Soporte para operaciones comerciales y administrativas específicas de cada empresa.

3. Cumplimiento de requisitos legales y fiscales relacionados con la identificación empresarial.

4. Base para la configuración de parámetros y políticas específicas de cada empresa.

5. Facilitar la gestión multi-empresa dentro del sistema ERP.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'id_compa';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre legal completo de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre comercial o marca de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_tradename';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Tipo de documento de identificación de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_doctype';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Número de identificación fiscal o documento legal de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_docnum';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Dirección física de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_address';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Ciudad donde está ubicada la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_city';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Departamento o estado donde está ubicada la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_state';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'País donde está ubicada la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_country';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Sector industrial al que pertenece la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_industry';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Número de teléfono principal de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_phone';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Dirección de correo electrónico principal de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_email';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Sitio web oficial de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_website';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Logo oficial de la compañía.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_logo';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si la compañía está activa (1) o inactiva (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'COLUMN',
	@level2name = N'compa_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Validación del tipo de documento permitido para la compañía (NI, CC, CE, PP, OT).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'CONSTRAINT',
	@level2name = N'CK_Company_DocType';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto la compañía se crea como activa (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'Company',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_Company_compa_active';
GO