CREATE TABLE [CMS_User] (
		[UserID]                        [int] IDENTITY(1, 1) NOT NULL,
		[UserName]                      [nvarchar](100) NOT NULL,
		[FirstName]                     [nvarchar](100) NULL,
		[MiddleName]                    [nvarchar](100) NULL,
		[LastName]                      [nvarchar](100) NULL,
		[FullName]                      [nvarchar](450) NULL,
		[Email]                         [nvarchar](100) NULL,
		[UserPassword]                  [nvarchar](100) NOT NULL,
		[PreferredCultureCode]          [nvarchar](10) NULL,
		[PreferredUICultureCode]        [nvarchar](10) NULL,
		[UserEnabled]                   [bit] NOT NULL,
		[UserIsEditor]                  [bit] NOT NULL,
		[UserIsGlobalAdministrator]     [bit] NOT NULL,
		[UserIsExternal]                [bit] NULL,
		[UserPasswordFormat]            [nvarchar](10) NULL,
		[UserCreated]                   [datetime] NULL,
		[LastLogon]                     [datetime] NULL,
		[UserStartingAliasPath]         [nvarchar](200) NULL,
		[UserGUID]                      [uniqueidentifier] NOT NULL,
		[UserLastModified]              [datetime] NOT NULL,
		[UserLastLogonInfo]             [nvarchar](max) NULL,
		[UserIsHidden]                  [bit] NULL,
		[UserVisibility]                [nvarchar](max) NULL,
		[UserIsDomain]                  [bit] NULL,
		[UserHasAllowedCultures]        [bit] NULL,
		[UserSiteManagerDisabled]       [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [PK_CMS_User]
	PRIMARY KEY
	NONCLUSTERED
	([UserID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserEnabled]
	DEFAULT ((0)) FOR [UserEnabled]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserIsEditor]
	DEFAULT ((0)) FOR [UserIsEditor]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserIsExternal]
	DEFAULT ((0)) FOR [UserIsExternal]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserIsGlobalAdministrator]
	DEFAULT ((0)) FOR [UserIsGlobalAdministrator]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserIsHidden]
	DEFAULT ((0)) FOR [UserIsHidden]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserName]
	DEFAULT ('') FOR [UserName]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserPassword]
	DEFAULT ('') FOR [UserPassword]
ALTER TABLE [CMS_User]
	ADD
	CONSTRAINT [DEFAULT_CMS_User_UserSiteManagerDisabled]
	DEFAULT ((0)) FOR [UserSiteManagerDisabled]
CREATE NONCLUSTERED INDEX [IX_CMS_User_FullName]
	ON [CMS_User] ([FullName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_User_UserEnabled_UserIsHidden]
	ON [CMS_User] ([UserEnabled], [UserIsHidden])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_User_UserGUID]
	ON [CMS_User] ([UserGUID])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_User_UserID_UserName_Email_FullName]
	ON [CMS_User] ([UserID], [UserName], [Email])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_User_UserIsEditor]
	ON [CMS_User] ([UserIsEditor])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_User_UserIsGlobalAdministrator]
	ON [CMS_User] ([UserIsGlobalAdministrator])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_User_UserName]
	ON [CMS_User] ([UserName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
