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
	N'Creando la prueba para validar que la función [dbo].[RowLevelSecurity] le permit seleccionar todas las filas a un usuario administrador...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER PROCEDURE [testRowLevelSecurity].[testRowLevelSecurityUserIsAdmin] AS
BEGIN
	EXECUTE [dbo].[sp_set_session_context]
		@key = N'CurrentUserID',
		@value = 1;
	EXECUTE [dbo].[sp_set_session_context]
		@key = N'ViewActiveStatus',
		@value = 1;
	CREATE TABLE #ExpectedResult
	(
		[id_broff] INTEGER,
		[company_id] INTEGER,
		[broff_name] NVARCHAR(255),
		[broff_code] NVARCHAR(255),
		[broff_address] NVARCHAR(255),
		[broff_city] NVARCHAR(255),
		[broff_state] NVARCHAR(255),
		[broff_country] NVARCHAR(255),
		[broff_phone] NVARCHAR(255),
		[broff_email] NVARCHAR(255),
		[broff_active] BIT
	);
	INSERT INTO #ExpectedResult
	(
		[id_broff],
		[company_id],
		[broff_name],
		[broff_code],
		[broff_address],
		[broff_city],
		[broff_state],
		[broff_country],
		[broff_phone],
		[broff_email],
		[broff_active]
	)
	VALUES
		(1, 1, N'Sucursal Centro', N'CTR001', N'Calle 1 #10-20', N'Bogotá', N'Cundinamarca', N'Colombia', N'+57 310 1234567', N'centro@compania.com', 1),
		(2, 1, N'Sucursal Norte', N'NRT002', N'Calle 85 #15-30', N'Bogotá', N'Cundinamarca', N'Colombia', N'+57 310 7654321', N'norte@compania.com', 1),
		(3, 1, N'Sucursal Sur', N'SUR003', N'Calle 50 #20-10', N'Bogotá', N'Cundinamarca', N'Colombia', N'+57 320 1234567', N'sur@compania.com', 1),
		(4, 1, N'Sucursal Medellín', N'MED001', N'Carrera 50 #45-30', N'Medellín', N'Antioquia', N'Colombia', N'+57 301 1234567', N'medellin@compania.com', 1),
		(5, 1, N'Sucursal Cali', N'CAL001', N'Avenida 5 #10-20', N'Cali', N'Valle del Cauca', N'Colombia', N'+57 302 1234567', N'cali@compania.com', 0);
	CREATE TABLE #ActualResult
	(
		[id_broff] INTEGER,
		[company_id] INTEGER,
		[broff_name] NVARCHAR(255),
		[broff_code] NVARCHAR(255),
		[broff_address] NVARCHAR(255),
		[broff_city] NVARCHAR(255),
		[broff_state] NVARCHAR(255),
		[broff_country] NVARCHAR(255),
		[broff_phone] NVARCHAR(255),
		[broff_email] NVARCHAR(255),
		[broff_active] BIT
	);
	INSERT INTO
		#ActualResult
	SELECT
		[bo].[id_broff],
		[bo].[company_id],
		[bo].[broff_name],
		[bo].[broff_code],
		[bo].[broff_address],
		[bo].[broff_city],
		[bo].[broff_state],
		[bo].[broff_country],
		[bo].[broff_phone],
		[bo].[broff_email],
		[bo].[broff_active]
	FROM
		[dbo].[BranchOffice] [bo];
	EXECUTE [tSQLt].[AssertEqualsTable]
		'#ExpectedResult',
		'#ActualResult';
	DROP TABLE #ExpectedResult;
	DROP TABLE #ActualResult;
END;
GO