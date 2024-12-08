RAISERROR
(
	N'Creando el desencadenador [dbo].[IDBranchOffice]...',
	0,
	1
)
WITH NOWAIT;
GO

CREATE OR ALTER TRIGGER [dbo].[IDBranchOffice]
ON [dbo].[BranchOffice]
INSTEAD OF DELETE AS
BEGIN
	SET NOCOUNT ON;
	IF [dbo].[CUDSecurity]
	(
		2, -- ID de la entidad BranchOffice
		'D'
	) = 0
	BEGIN
		ROLLBACK TRANSACTION;
		RAISERROR(51002, 16, 1, 'delete', 'BranchOffice');
		RETURN;
	END;
	DELETE FROM
		[dbo].[BranchOffice]
	WHERE
		[id_broff] IN
		(
			SELECT
				[d].[id_broff]
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
			N'BranchOffice',
			N'TRIGGER',
			N'IDBranchOffice'
		) AS "f"
)
	BEGIN
		EXECUTE "sys"."sp_updateextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones delete según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'BranchOffice',
			@level2type = N'TRIGGER',
			@level2name = N'IDBranchOffice';
	END;
ELSE
	BEGIN
		EXECUTE "sys"."sp_addextendedproperty"
			@name = N'MS_Description',
			@value = N'Desencadenador que permite o deniega operaciones delete según los permisos.',
			@level0type = N'SCHEMA',
			@level0name = N'dbo',
			@level1type = N'TABLE',
			@level1name = N'BranchOffice',
			@level2type = N'TRIGGER',
			@level2name = N'IDBranchOffice';
	END;
GO