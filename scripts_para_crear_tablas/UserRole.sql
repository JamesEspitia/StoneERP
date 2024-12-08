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
 N'Creando la tabla [dbo].[UserRole]...',
 0,
 1
)
WITH NOWAIT;
GO

CREATE TABLE [dbo].[UserRole]
(
	[id_usro] BIGINT IDENTITY(1,1) NOT NULL,
	[user_id] BIGINT NOT NULL
		CONSTRAINT [FK_UserRole_User]
		FOREIGN KEY REFERENCES [dbo].[User]
		(
			[id_user]
		),
	[role_id] BIGINT NOT NULL
		CONSTRAINT [FK_UserRole_Role]
		FOREIGN KEY REFERENCES [dbo].[Role]
		(
			[id_role]
		),
	[connection_user] NVARCHAR(255) NOT NULL
		CONSTRAINT [DF_UserRole_ConnectionUser]
		DEFAULT
		(
			SUSER_SNAME()
		),
	[context_user] BIGINT NOT NULL
		CONSTRAINT [DF_UserRole_ContextUser]
		DEFAULT
		(
			CAST(SESSION_CONTEXT(N'CurrentUserID') AS BIGINT)
		),
	[start_time] DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[end_time] DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	CONSTRAINT [UQ_UserRole_user_id_role_id] UNIQUE
	(
		[user_id],
		[role_id]
	),
	PERIOD FOR SYSTEM_TIME
	(
		[start_time],
		[end_time]
	),
	CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED
	(
		[id_usro] ASC
	)
	WITH
	(
		PAD_INDEX = OFF,
		STATISTICS_NORECOMPUTE = OFF,
		IGNORE_DUP_KEY = OFF,
		ALLOW_ROW_LOCKS = ON,
		ALLOW_PAGE_LOCKS = ON
	) ON [PRIMARY]
) WITH
(
	SYSTEM_VERSIONING = ON
	(
		HISTORY_TABLE = [History].[UserRole]
	)
);
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'This table tracks user-role associations with versioning. It records the user of the connection and the context user for auditing purposes.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Unique identifier for the UserRole record.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'id_usro';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'References the user assigned to the role.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'user_id';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'References the role assigned to the user.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'role_id';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The user of the connection performing the operation.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'connection_user';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The user in the session context performing the operation.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'context_user';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The start time for the record in the system versioning history.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'start_time';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The end time for the record in the system versioning history.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'end_time';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The primary key constraint for the UserRole table.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'PK_UserRole';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Restricción única para la combinación de rol, usuario.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'UQ_UserRole_user_id_role_id';
GO

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The constraint that enforces user foreign key.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_UserRole_User';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The constraint that enforces role foreign key.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'FK_UserRole_Role';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The default value for the connection user.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_UserRole_ConnectionUser';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'The default value for the context user.',
	@level0type = N'SCHEMA',
	@level0name = N'dbo',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'CONSTRAINT',
	@level2name = N'DF_UserRole_ContextUser';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'This table retains historical versions of the [UserRole] table.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical value for the UserRole record identifier.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'id_usro';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical reference to the user assigned to the role.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'user_id';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical reference to the role assigned to the user.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'role_id';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical value for the user of the connection.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'connection_user';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical value for the user in the session context.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'context_user';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical value for the start time of the record.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'start_time';

EXECUTE [sys].[sp_addextendedproperty]
	@name = N'MS_Description',
	@value = N'Historical value for the end time of the record.',
	@level0type = N'SCHEMA',
	@level0name = N'History',
	@level1type = N'TABLE',
	@level1name = N'UserRole',
	@level2type = N'COLUMN',
	@level2name = N'end_time';
GO