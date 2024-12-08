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
	N'Creando el mensaje 51003...',
	0,
	1
)
WITH NOWAIT;
GO

IF EXISTS
(
	SELECT 1
	FROM "sys"."messages"
	WHERE "message_id" = 51003
)
	BEGIN
		EXECUTE [sys].[sp_addmessage]
			@msgnum = 51003,
			@severity = 16,
			@msgtext = N'Entity not found or invalid primary key.',
			@with_log = 'TRUE',
			@replace = 'replace';
	END
ELSE
	BEGIN
		EXECUTE "sys"."sp_addmessage"
			@msgnum = 51003,
			@severity = 16,
			@msgtext = N'Entity not found or invalid primary key.',
			@lang = N'us_english',
			@with_log = 'TRUE';
	END;
GO

IF EXISTS
(
	SELECT 1
	FROM "sys"."messages"
	WHERE "message_id" = 51003
)
	BEGIN
		EXECUTE "sys"."sp_addmessage"
			@msgnum = 51003,
			@severity = 16,
			@msgtext = N'Entidad no encontrada o clave principal no válida.',
			@lang = N'Español',
			@replace = 'replace';
	END
ELSE
	BEGIN
		EXECUTE "sys"."sp_addmessage"
			@msgnum = 51003,
			@severity = 16,
			@msgtext = N'Entidad no encontrada o clave principal no válida.',
			@lang = N'Español';
	END;
GO