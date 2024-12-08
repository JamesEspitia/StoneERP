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
	N'Agregando registros a la tabla [dbo].[User]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[User] ON;
GO

INSERT INTO [dbo].[User]
(
	[id_user],
	[user_username],
	[user_password],
	[user_email],
	[user_phone],
	[user_is_admin],
	[user_is_active]
)
VALUES
	(1, N'admin', N'$2a$12$encrypted_password1', N'admin@example.com', N'+57 300 1234567', 1, 1),
	(2, N'jdoe', N'$2a$12$encrypted_password2', N'jdoe@example.com', NULL, 0, 1),
	(3, N'ssmith', N'$2a$12$encrypted_password3', N'ssmith@example.com', N'+57 301 7654321', 0, 1),
	(4, N'mjones', N'$2a$12$encrypted_password4', N'mjones@example.com', N'+57 302 8765432', 0, 1),
	(5, N'ktaylor', N'$2a$12$encrypted_password5', N'ktaylor@example.com', NULL, 0, 1),
	(6, N'alewis', N'$2a$12$encrypted_password6', N'alewis@example.com', N'+57 304 1234567', 0, 1),
	(7, N'bwilliams', N'$2a$12$encrypted_password7', N'bwilliams@example.com', NULL, 0, 0);
GO

DBCC CHECKIDENT ('[dbo].[User]', RESEED, 7);
GO

SET IDENTITY_INSERT [dbo].[User] OFF;
GO