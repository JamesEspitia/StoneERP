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
	N'Creando el desencadenador [dbo].[IUBranchOffice]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER TRIGGER [dbo].[IUBranchOffice]
ON [dbo].[BranchOffice]
INSTEAD OF UPDATE AS
BEGIN
	SET NOCOUNT ON;
	IF [dbo].[CUDSecurity]
	(
		2, -- ID de la entidad BranchOffice
		'U'
	) = 0
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR(51002, 16, 1, 'update', 'BranchOffice');
			RETURN;
		END;
	UPDATE
		[dbo].[BranchOffice]
	SET
		[company_id] = [i].[company_id],
		[broff_name] = [i].[broff_name],
		[broff_code] = [i].[broff_code],
		[broff_address] = [i].[broff_address],
		[broff_city] = [i].[broff_city],
		[broff_state] = [i].[broff_state],
		[broff_country] = [i].[broff_country],
		[broff_phone] = [i].[broff_phone],
		[broff_email] = [i].[broff_email],
		[broff_active] = [i].[broff_active]
	FROM
		[inserted] [i]
	WHERE
		[dbo].[BranchOffice].[id_broff] = [i].[id_broff];
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
			N'IUBranchOffice'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones update según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'BranchOffice',
			@level2type = N'TRIGGER',
			@level2name = N'IUBranchOffice';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones update según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'BranchOffice',
			@level2type = N'TRIGGER',
			@level2name = N'IUBranchOffice';
	END;
GO