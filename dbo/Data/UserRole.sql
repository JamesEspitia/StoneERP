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
	N'Agregando registros a la tabla [dbo].[UserRole]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[UserRole] ON;
GO

INSERT INTO [dbo].[UserRole]
(
    [id_usro],
    [user_id],
    [role_id],
	[context_user]
)
VALUES
    (1, 1, 1, 1),
    (2, 2, 2, 1),
    (3, 3, 3, 1),
    (4, 4, 4, 1),
    (5, 5, 5, 1),
    (6, 6, 6, 1),
    (7, 7, 7, 1);

DBCC CHECKIDENT ('[dbo].[UserRole]', RESEED, 7);
GO

SET IDENTITY_INSERT [dbo].[UserRole] OFF;
GO