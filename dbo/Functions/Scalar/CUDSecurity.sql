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
	N'Creando la función [dbo].[CUDSecurity]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER FUNCTION [dbo].[CUDSecurity]
(
	@entity_id INT,
	@operation CHAR(1)
)
RETURNS BIT
WITH SCHEMABINDING AS
BEGIN
	RETURN 
	(
		SELECT
			CASE
				WHEN EXISTS 
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
						[u].[user_is_active] = 1
				) OR EXISTS
				(
					SELECT
						1
					FROM
						[dbo].[PermiUser] [pu] INNER JOIN
						[dbo].[Permission] [p] ON
							[pu].[permission_id] = [p].[id_permi] AND
							[pu].[entitycatalog_id] = @entity_id AND
							[pu].[id_peusr] = CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT) AND
							(
								(
									[pu].[peusr_include] = 1 AND
									(
										(
											@operation = 'C' AND
											[p].[can_create] = 1
										) OR
										(
											@operation = 'U' AND
											[p].[can_update] = 1
										) OR
										(
											@operation = 'D' AND
											[p].[can_delete] = 1
										) OR
										(
											@operation = 'I' AND
											[p].[can_import] = 1
										) OR
										(
											@operation = 'E' AND
											[p].[can_export] = 1
										)
									)
								) OR
								(
									[pu].[peusr_include] = 0 AND
									(
										(
											@operation = 'C' AND
											[p].[can_create] = 0
										) AND
										(
											@operation = 'U' AND
											[p].[can_update] = 0
										) AND
										(
											@operation = 'D' AND
											[p].[can_delete] = 0
										) OR
										(
											@operation = 'I' AND
											[p].[can_import] = 1
										) OR
										(
											@operation = 'E' AND
											[p].[can_export] = 1
										)
									)
								)
							) INNER JOIN
						[dbo].[User] [u] ON
							[u].[id_user] = [pu].[id_peusr] AND
							[u].[user_is_active] = 1
				) OR EXISTS
				(
					SELECT
						1
					FROM
						[dbo].[PermiRole] [pr] INNER JOIN
						[dbo].[Role] [r] ON
							[pr].[role_id] = [r].[id_role] AND
							[r].[role_active] = 1 INNER JOIN
						[dbo].[Permission] [p] ON
							[pr].[permission_id] = [p].[id_permi] AND
							[pr].[entitycatalog_id] = @entity_id AND
							(
								(
									[pr].[perol_include] = 1 AND
									(
										(
											@operation = 'C' AND
											[p].[can_create] = 1
										) OR
										(
											@operation = 'U' AND
											[p].[can_update] = 1
										) OR
										(
											@operation = 'D' AND
											[p].[can_delete] = 1
										) OR
										(
											@operation = 'I' AND
											[p].[can_import] = 1
										) OR
										(
											@operation = 'E' AND
											[p].[can_export] = 1
										)
									)
								) OR
								(
									[pr].[perol_include] = 0 AND
									(
										(
											@operation = 'C' AND
											[p].[can_create] = 0
										) AND
										(
											@operation = 'U' AND
											[p].[can_update] = 0
										) AND
										(
											@operation = 'D' AND
											[p].[can_delete] = 0
										) OR
										(
											@operation = 'I' AND
											[p].[can_import] = 1
										) OR
										(
											@operation = 'E' AND
											[p].[can_export] = 1
										)
									)
								)
							) INNER JOIN
						[dbo].[UserRole] [ur] ON
							[ur].[role_id] = [r].[id_role] AND 
							[ur].[user_id] = CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT) INNER JOIN
						[dbo].[User] [u] ON
							[u].[id_user] = [ur].[user_id] AND
							[u].[user_is_active] = 1
				) THEN 1
				ELSE 0
			END
	);
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
			N'CUDSecurity',
			NULL,
			NULL
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Valida si un usuario tiene permisos CRUD (INSERT, UPDATE, DELETE) sobre una entidad activa.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'CUDSecurity';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Valida si un usuario tiene permisos CRUD (INSERT, UPDATE, DELETE) sobre una entidad activa.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'CUDSecurity';
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
			N'CUDSecurity',
			N'PARAMETER',
			N'@entity_id'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'ID de la entidad sobre la cual se valida la operación.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'CUDSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@entity_id';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'ID de la entidad sobre la cual se valida la operación.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'CUDSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@entity_id';
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
			N'CUDSecurity',
			N'PARAMETER',
			N'@operation'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Operación CRUD a validar: C (INSERT), U (UPDATE), D (DELETE), I (IMPORT), E (EXPORT).',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'CUDSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@operation';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Operación CRUD a validar: C (INSERT), U (UPDATE), D (DELETE), I (IMPORT), E (EXPORT).',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'FUNCTION',
			@level1name = N'CUDSecurity',
			@level2type = N'PARAMETER',
			@level2name = N'@operation';
	END;
GO