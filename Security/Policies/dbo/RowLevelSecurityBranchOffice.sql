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
	N'Creando la política de seguridad [dbo].[RowLevelSecurityBranchOffice]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE SECURITY POLICY [dbo].[RowLevelSecurityBranchOffice]
ADD FILTER PREDICATE [dbo].[RowLevelSecurity]
(
	[id_broff],
	2,
	CAST(SESSION_CONTEXT(N'ViewActiveStatus') AS BIT)
) ON [dbo].[BranchOffice];
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Política de seguridad que aplica a la tabla [dbo].[BranchOffice], utilizando Row-Level Security para controlar el acceso a nivel de usuario y de rol, considerando permisos explícitos y el estado activo/inactivo de los registros.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'SECURITY POLICY',
	@level1name = N'RowLevelSecurityBranchOffice';
GO