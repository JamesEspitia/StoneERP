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
	N'Creando el desencadenador [dbo].[IIBranchOffice]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER TRIGGER [dbo].[IIBranchOffice]
ON [dbo].[BranchOffice]
INSTEAD OF INSERT AS
BEGIN
	SET NOCOUNT ON;
	IF [dbo].[CUDSecurity]
	(
		2, -- ID de la entidad BranchOffice
		'I'
	) = 0
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR(51002, 16, 1, 'insert', 'BranchOffice');
			RETURN;
		END;
	IF OBJECTPROPERTY(OBJECT_ID(N'[dbo].[BranchOffice]'), 'TableHasIdentity') = 1
		BEGIN
			INSERT INTO [dbo].[BranchOffice]
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
			SELECT
				[i].[id_broff],
				[i].[company_id],
				[i].[broff_name],
				[i].[broff_code],
				[i].[broff_address],
				[i].[broff_city],
				[i].[broff_state],
				[i].[broff_country],
				[i].[broff_phone],
				[i].[broff_email],
				[i].[broff_active]
			FROM
				[inserted] [i];
		END;
	ELSE
		BEGIN
			INSERT INTO [dbo].[BranchOffice]
			(
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
			SELECT
				[i].[company_id],
				[i].[broff_name],
				[i].[broff_code],
				[i].[broff_address],
				[i].[broff_city],
				[i].[broff_state],
				[i].[broff_country],
				[i].[broff_phone],
				[i].[broff_email],
				[i].[broff_active]
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
			N'BranchOffice',
			N'TRIGGER',
			N'IIBranchOffice'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones insert según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'BranchOffice',
			@level2type = N'TRIGGER',
			@level2name = N'IIBranchOffice';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones insert según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'BranchOffice',
			@level2type = N'TRIGGER',
			@level2name = N'IIBranchOffice';
	END;
GO