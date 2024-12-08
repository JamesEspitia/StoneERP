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
	N'Agregando registros a la tabla [dbo].[UserCompany]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[UserCompany] ON;
GO

INSERT INTO [dbo].[UserCompany]
(
	[id_useco],
	[user_id],
	[company_id],
	[useco_active]
)
VALUES
	(1, 1, 1, 1),
	(2, 2, 1, 1),
	(3, 3, 1, 1),
	(4, 4, 1, 1),
	(5, 5, 1, 1),
	(6, 6, 1, 1),
	(7, 7, 1, 1);
GO

DBCC CHECKIDENT ('[dbo].[UserCompany]', RESEED, 7);
GO

SET IDENTITY_INSERT [dbo].[UserCompany] OFF;
GO