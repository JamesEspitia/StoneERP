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
	N'Creando el desencadenador [dbo].[IDCostCenter]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER TRIGGER [dbo].[IDCostCenter]
ON [dbo].[CostCenter]
INSTEAD OF DELETE AS
BEGIN
	SET NOCOUNT ON;
	IF [dbo].[CUDSecurity]
	(
		3, -- ID de la entidad CostCenter
		'D'
	) = 0
	BEGIN
		ROLLBACK TRANSACTION;
		RAISERROR(51002, 16, 1, 'delete', 'CostCenter');
		RETURN;
	END;
	DELETE FROM
		[dbo].[CostCenter]
	WHERE
		[id_cosce] IN
		(
			SELECT
				[d].[id_cosce]
			FROM
				[deleted] [d]
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
			N'TABLE',
			N'CostCenter',
			N'TRIGGER',
			N'IDCostCenter'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones delete según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'CostCenter',
			@level2type = N'TRIGGER',
			@level2name = N'IDCostCenter';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones delete según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'CostCenter',
			@level2type = N'TRIGGER',
			@level2name = N'IDCostCenter';
	END;
GO