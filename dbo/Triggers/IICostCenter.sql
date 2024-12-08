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
	N'Creando el desencadenador [dbo].[IICostCenter]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER TRIGGER [dbo].[IICostCenter]
ON [dbo].[CostCenter]
INSTEAD OF INSERT AS
BEGIN
	SET NOCOUNT ON;
	IF [dbo].[CUDSecurity]
	(
		3, -- ID de la entidad CostCenter
		'I'
	) = 0
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR(51002, 16, 1, 'insert', 'CostCenter');
			RETURN;
		END;
	IF OBJECTPROPERTY(OBJECT_ID(N'[dbo].[CostCenter]'), 'TableHasIdentity') = 1
		BEGIN
			INSERT INTO [dbo].[CostCenter]
			(
				[id_cosce],
				[company_id],
				[cosce_parent_id],
				[cosce_code],
				[cosce_name],
				[cosce_description],
				[cosce_budget],
				[cosce_level],
				[cosce_active]
			)
			SELECT
				[i].[id_cosce],
				[i].[company_id],
				[i].[cosce_parent_id],
				[i].[cosce_code],
				[i].[cosce_name],
				[i].[cosce_description],
				[i].[cosce_budget],
				[i].[cosce_level],
				[i].[cosce_active]
			FROM
				[inserted] [i];
		END;
	ELSE
		BEGIN
			INSERT INTO [dbo].[CostCenter]
			(
				[company_id],
				[cosce_parent_id],
				[cosce_code],
				[cosce_name],
				[cosce_description],
				[cosce_budget],
				[cosce_level],
				[cosce_active]
			)
			SELECT
				[i].[company_id],
				[i].[cosce_parent_id],
				[i].[cosce_code],
				[i].[cosce_name],
				[i].[cosce_description],
				[i].[cosce_budget],
				[i].[cosce_level],
				[i].[cosce_active]
			FROM
				[inserted] [i];
		END;
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
			N'TABLE',
			N'CostCenter',
			N'TRIGGER',
			N'IICostCenter'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones insert según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'CostCenter',
			@level2type = N'TRIGGER',
			@level2name = N'IICostCenter';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones insert según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'CostCenter',
			@level2type = N'TRIGGER',
			@level2name = N'IICostCenter';
	END;
GO