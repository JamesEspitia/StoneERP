USE [master];
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
	N'Creando el mensaje 51001...',
	0,
	1
)
WITH NOWAIT;
GO

IF EXISTS
(
	SELECT 1
	FROM "sys"."messages"
	WHERE "message_id" = 51001
)
	BEGIN
		EXECUTE [sys].[sp_addmessage]
			@msgnum = 51001,
			@severity = 16,
			@msgtext = N'You do not have permission to insert records into the BranchOffice table.',
			@with_log = 'TRUE',
			@replace = 'replace';
	END
ELSE
	BEGIN
		EXECUTE "sys"."sp_addmessage"
			@msgnum = 51001,
			@severity = 16,
			@msgtext = N'You do not have permission to insert records into the BranchOffice table.',
			@lang = N'us_english',
			@with_log = 'TRUE';
	END;
GO

IF EXISTS
(
	SELECT 1
	FROM "sys"."messages"
	WHERE "message_id" = 51001
)
	BEGIN
		EXECUTE "sys"."sp_addmessage"
			@msgnum = 51001,
			@severity = 16,
			@msgtext = N'No tiene permiso para insertar registros en la tabla BranchOffice.',
			@lang = N'Español',
			@replace = 'replace';
	END
ELSE
	BEGIN
		EXECUTE "sys"."sp_addmessage"
			@msgnum = 51001,
			@severity = 16,
			@msgtext = N'No tiene permiso para insertar registros en la tabla BranchOffice.',
			@lang = N'Español';
	END;
GO