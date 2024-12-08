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
	N'Creando el desencadenador [dbo].[IUCostCenter]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER TRIGGER [dbo].[IUCostCenter]
ON [dbo].[CostCenter]
INSTEAD OF UPDATE AS
BEGIN
	SET NOCOUNT ON;
	IF [dbo].[CUDSecurity]
	(
		3, -- ID de la entidad CostCenter
		'U'
	) = 0
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR(51002, 16, 1, 'update', 'CostCenter');
			RETURN;
		END;
	UPDATE
		[dbo].[CostCenter]
	SET
		[company_id] = [i].[company_id],
		[cosce_parent_id] = [i].[cosce_parent_id],
		[cosce_code] = [i].[cosce_code],
		[cosce_name] = [i].[cosce_name],
		[cosce_description] = [i].[cosce_description],
		[cosce_budget] = [i].[cosce_budget],
		[cosce_level] = [i].[cosce_level],
		[cosce_active] = [i].[cosce_active]
	FROM
		[inserted] [i]
	WHERE
		[dbo].[CostCenter].[id_cosce] = [i].[id_cosce];
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
			N'IUCostCenter'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones update según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'CostCenter',
			@level2type = N'TRIGGER',
			@level2name = N'IUCostCenter';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones update según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'CostCenter',
			@level2type = N'TRIGGER',
			@level2name = N'IUCostCenter';
	END;
GO