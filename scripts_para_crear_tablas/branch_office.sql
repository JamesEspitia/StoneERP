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
	N'Creando la tabla [dbo].[BranchOffice]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[BranchOffice]
(
	[id_broff] BIGINT IDENTITY(1,1) NOT NULL,
	[company_id] BIGINT NOT NULL
		CONSTRAINT [FK_BranchOffice_Company]
		FOREIGN KEY REFERENCES [dbo].[Company]
		(
			[id_compa]
		),
	[broff_name] NVARCHAR(255) NOT NULL,
	[broff_code] NVARCHAR(255) NOT NULL,
	[broff_address] NVARCHAR(255) NOT NULL,
	[broff_city] NVARCHAR(255) NOT NULL,
	[broff_state] NVARCHAR(255) NOT NULL,
	[broff_country] NVARCHAR(255) NOT NULL,
	[broff_phone] NVARCHAR(255) NOT NULL,
	[broff_email] NVARCHAR(255) NOT NULL,
	[broff_active] BIT NOT NULL
		CONSTRAINT [DF_BranchOffice_broff_active]
		DEFAULT (1),
	CONSTRAINT [PK_BranchOffice] PRIMARY KEY CLUSTERED
	(
		[id_broff] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY],
	CONSTRAINT [UQ_Company_BranchCode] UNIQUE
	(
		[company_id],
		[broff_code]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Una sucursal representa un establecimiento físico o punto de operación 
que pertenece a una compañía específica.

¿Para qué sirve?:

1. Gestión y control de múltiples ubicaciones de una misma empresa.

2. Organización de operaciones por punto de venta o servicio.

3. Seguimiento y análisis de desempeño por sucursal.

4. Asignación y control de recursos específicos por ubicación.

5. Facilitar la gestión descentralizada de operaciones empresariales.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Identificador único para la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'id_broff';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Compañía a la que pertenece esta sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'company_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Nombre descriptivo de la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_name';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Código único que identifica la sucursal dentro de la empresa.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_code';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Dirección física de la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_address';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Ciudad donde está ubicada la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_city';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Departamento o estado donde está ubicada la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_state';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'País donde está ubicada la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_country';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Número de teléfono de la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_phone';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Dirección de correo electrónico de la sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_email';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Indica si la sucursal está activa (1) o inactiva (0).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'COLUMN',
	@level2name = N'broff_active';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave primaria de la tabla',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_BranchOffice';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Llave foránea que referencia a la compañía en la tabla Company.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_BranchOffice_Company';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de ID de compañía y código de sucursal.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_Company_BranchCode';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Por defecto la sucursal se crea como activa (1).',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'BranchOffice',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_BranchOffice_broff_active';
GO