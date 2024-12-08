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
	N'Creando la función [dbo].[RowLevelSecurity]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER FUNCTION [dbo].[RowLevelSecurity]
(
	@record_id BIGINT,
	@entit_id INT,
	@active_status BIT
)
RETURNS TABLE
WITH SCHEMABINDING
AS RETURN
(
	SELECT
		1 AS [AccessAllowed]
	WHERE EXISTS
	(
		SELECT
			1
		WHERE
			IS_SRVROLEMEMBER('sysadmin') = 1
	) OR EXISTS
	(
		SELECT
			1
		FROM
			[dbo].[User] [u]
		WHERE
			[u].[id_user] = CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT) AND
			[u].[user_is_admin] = 1 AND
			(
				@active_status = [u].[user_is_active] OR
				@active_status IS NULL
			)
	) OR EXISTS
	(
		SELECT
			1
		FROM
			[dbo].[PermiUserRecord] [pur] INNER JOIN
			[dbo].[UserCompany] [uc] ON
				[uc].[id_useco] = [pur].[usercompany_id] AND
				[uc].[user_id] = CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT) AND
				(
					@active_status = [uc].[useco_active] OR
					@active_status IS NULL
				) AND
				[pur].[entitycatalog_id] = @entit_id AND
				(
					(
						[pur].[peusr_include] = 1 AND
						[pur].[peusr_record] = @record_id
					) OR
					(
						[pur].[peusr_include] = 0 AND
						[pur].[peusr_record] <> @record_id
					)
				) INNER JOIN
			[dbo].[Permission] [p] ON
				[pur].[permission_id] = [p].[id_permi] AND
				[p].[can_read] = 1 INNER JOIN
			[dbo].[EntityCatalog] [ec] ON
				[pur].[entitycatalog_id] = [ec].[id_entit] AND
				(
					@active_status = [ec].[entit_active] OR
					@active_status IS NULL
				)
	) OR EXISTS
	(
		SELECT
			1
		FROM
			[dbo].[PermiRoleRecord] [prr] INNER JOIN
			[dbo].[Role] [r] ON
				[prr].[role_id] = [r].[id_role] AND
				(
					@active_status = [r].[role_active] OR
					@active_status IS NULL
				) AND
				[prr].[entitycatalog_id] = @entit_id AND
				(
					(
						[prr].[perrc_include] = 1 AND
						[prr].[perrc_record] = @record_id
					) OR
					(
						[prr].[perrc_include] = 0 AND
						[prr].[perrc_record] <> @record_id
					)
				) INNER JOIN
			[dbo].[Permission] [p] ON
				[prr].[permission_id] = [p].[id_permi] AND
				[p].[can_read] = 1 INNER JOIN
			[dbo].[UserRole] [ur] ON
				[ur].[role_id] = [r].[id_role] AND
				[ur].[user_id] = CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT) INNER JOIN
			[dbo].[EntityCatalog] [ec] ON
				[prr].[entitycatalog_id] = [ec].[id_entit] AND
				(
					@active_status = [ec].[entit_active] OR
					@active_status IS NULL
				)
	)
);
GO

IF EXISTS
(
	SELECT
		"f"."objname"
	FROM
		"sys"."fn_listextendedproperty"
		(
			N'MS_Description',
			N'SCHEMA',
			N'dbo',
			N'FUNCTION',
			N'RowLevelSecurity',
			NULL,
			NULL
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Esta función aplica reglas de seguridad a nivel de filas considerando permisos de usuario y de rol, con soporte para inclusiones y exclusiones, y la opción de filtrar registros activos, inactivos o ambos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Esta función aplica reglas de seguridad a nivel de filas considerando permisos de usuario y de rol, con soporte para inclusiones y exclusiones, y la opción de filtrar registros activos, inactivos o ambos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity';
	END;
GO

IF EXISTS
(
	SELECT
		"f"."objname"
	FROM
		"sys"."fn_listextendedproperty"
		(
			N'MS_Description',
			N'SCHEMA',
			N'dbo',
			N'FUNCTION',
			N'RowLevelSecurity',
			N'PARAMETER',
			N'@record_id'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Identificador único del registro al que se aplica la regla de seguridad.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@record_id';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Identificador único del registro al que se aplica la regla de seguridad.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@record_id';
	END;
GO

IF EXISTS
(
	SELECT
		"f"."objname"
	FROM
		"sys"."fn_listextendedproperty"
		(
			N'MS_Description',
			N'SCHEMA',
			N'dbo',
			N'FUNCTION',
			N'RowLevelSecurity',
			N'PARAMETER',
			N'@entit_id'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Identificador de la entidad para la que se aplica la regla de seguridad.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@entit_id';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Identificador de la entidad para la que se aplica la regla de seguridad.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@entit_id';
	END;
GO

IF EXISTS
(
	SELECT
		"f"."objname"
	FROM
		"sys"."fn_listextendedproperty"
		(
			N'MS_Description',
			N'SCHEMA',
			N'dbo',
			N'FUNCTION',
			N'RowLevelSecurity',
			N'PARAMETER',
			N'@active_status'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Estado de actividad de los registros: 1 para activos, 0 para inactivos, NULL para ambos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@active_status';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Estado de actividad de los registros: 1 para activos, 0 para inactivos, NULL para ambos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'RowLevelSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@active_status';
	END;
GO