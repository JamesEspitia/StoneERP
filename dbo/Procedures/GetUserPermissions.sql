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
	N'Creando el procedimiento almacenado [dbo].[GetUserPermissions]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER PROCEDURE [dbo].[GetUserPermissions]
(
	@entity_id INT,
	@id_user BIGINT = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @can_create BIT;
	DECLARE @can_delete BIT;
	DECLARE @can_update BIT;
	DECLARE @primary_key NVARCHAR(128);
	DECLARE @schema_name NVARCHAR(128);
	DECLARE @sql NVARCHAR(MAX);
	DECLARE @table_name NVARCHAR(128);
	DECLARE @user_id BIGINT;
	SET @user_id = CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT);
	IF @user_id IS NULL
		BEGIN
			RAISERROR(51001, 16, 1);
			RETURN;
		END;
	SELECT
		@table_name = [ec].[entit_name],
		@schema_name = OBJECT_SCHEMA_NAME(OBJECT_ID([ec].[entit_name])),
		@primary_key = [col].[name]
	FROM
		[dbo].[EntityCatalog] [ec] INNER JOIN
		[sys].[indexes] [idx] ON
			[idx].[object_id] = OBJECT_ID([ec].[entit_name]) AND
			[idx].[is_primary_key] = 1 AND
			[ec].[id_entit] = @entity_id INNER JOIN
		[sys].[index_columns] [ic] ON
			[ic].[object_id] = [idx].[object_id] AND
			[ic].[index_id] = [idx].[index_id] INNER JOIN
		[sys].[columns] [col] ON
			[col].[object_id] = [ic].[object_id] AND
			[col].[column_id] = [ic].[column_id];
	IF @table_name IS NULL OR @schema_name IS NULL OR @primary_key IS NULL
	BEGIN
		RAISERROR(51003, 16, 1);
		RETURN;
	END;
	CREATE TABLE #UserPermissions
	(
		[permission_level] NVARCHAR(50),
		[record_id] BIGINT,
		[can_create] BIT,
		[can_read] BIT,
		[can_update] BIT,
		[can_delete] BIT
	);
	SET @can_create = [dbo].[CUDSecurity](@entity_id, 'I');
	SET @can_update = [dbo].[CUDSecurity](@entity_id, 'U');
	SET @can_delete = [dbo].[CUDSecurity](@entity_id, 'D');
	INSERT INTO #UserPermissions
	(
		[permission_level],
		[record_id],
		[can_create],
		[can_read],
		[can_update],
		[can_delete]
	)
	VALUES
	(
		'Entity',
		NULL,
		@can_create,
		NULL,
		@can_update,
		@can_delete
	);
	SET @sql = N'
		INSERT INTO #UserPermissions
		(
			[permission_level],
			[record_id],
			[can_create],
			[can_read],
			[can_update],
			[can_delete]
		)
		SELECT
			''Record'',
			[t].[' + @primary_key + N'],
			NULL,
			1,
			NULL,
			NULL
		FROM
			' + QUOTENAME(@schema_name, N'[') + N'.' + QUOTENAME(@table_name, N'[') + N' [t]
		WHERE EXISTS
		(
			SELECT
				1
			FROM
				[dbo].[RowLevelSecurity]([t].' + QUOTENAME(@primary_key, N'[') + N', @entity_id, 1)
		);
	';
	EXECUTE [sys].[sp_executesql]
		@sql,
		N'@entity_id INT',
		@entity_id;
	SELECT
		[up].[permission_level],
		[up].[record_id],
		[up].[can_create],
		[up].[can_read],
		[up].[can_update],
		[up].[can_delete]
	FROM
		#UserPermissions [up];
	DROP TABLE #UserPermissions;
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
			N'PROCEDURE',
			N'GetUserPermissions',
			NULL,
			NULL
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Procedimiento que devuelve los permisos asignados a un usuario a nivel de entidad y registro.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'PROCEDURE',
			@level1name = N'GetUserPermissions';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Procedimiento que devuelve los permisos asignados a un usuario a nivel de entidad y registro.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'PROCEDURE',
			@level1name = N'GetUserPermissions';
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
			N'PROCEDURE',
			N'GetUserPermissions',
			N'PARAMETER',
			N'@entity_id'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'ID de la entidad dentro del catálogo de entidades.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'PROCEDURE',
			@level1name = N'GetUserPermissions',
			@level2type = N'PARAMETER',
			@level2name = N'@entity_id';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'ID de la entidad dentro del catálogo de entidades.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'PROCEDURE',
			@level1name = N'GetUserPermissions',
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
			N'PROCEDURE',
			N'GetUserPermissions',
			N'PARAMETER',
			N'@id_user'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Este parámetro no se utiliza solo se deja por compatibilidad del requerimiento.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'PROCEDURE',
			@level1name = N'GetUserPermissions',
			@level2type = N'PARAMETER',
			@level2name = N'@id_user';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Este parámetro no se utiliza solo se deja por compatibilidad del requerimiento.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'PROCEDURE',
			@level1name = N'GetUserPermissions',
			@level2type = N'PARAMETER',
			@level2name = N'@id_user';
	END;
GO