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
	N'Agregando registros a la tabla [dbo].[Company]...',
	0,
	1
)
WITH NOWAIT;
GO

SET IDENTITY_INSERT [dbo].[Company] ON;
GO

INSERT INTO [dbo].[Company]
(
	[id_compa],
	[compa_name],
	[compa_tradename],
	[compa_doctype],
	[compa_docnum],
	[compa_address],
	[compa_city],
	[compa_state],
	[compa_country],
	[compa_industry],
	[compa_phone],
	[compa_email],
	[compa_website],
	[compa_logo],
	[compa_active]
)
VALUES
(
	1,
	N'Compañía XYZ',
	N'XYZ Comercial',
	N'NI',
	N'1234567890',
	N'Calle 123, Edificio ABC',
	N'Bogotá',
	N'Cundinamarca',
	N'Colombia',
	N'Tecnología',
	N'+57 300 1234567',
	N'contacto@companiaxyz.com',
	N'www.companiaxyz.com',
	NULL,
	1
);

DBCC CHECKIDENT ('[dbo].[Company]', RESEED, 1);
GO

SET IDENTITY_INSERT [dbo].[Company] OFF;
GO