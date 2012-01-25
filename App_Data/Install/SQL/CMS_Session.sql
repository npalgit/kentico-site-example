CREATE TABLE [CMS_Session] (
		[SessionIdentificator]     [nvarchar](200) NOT NULL,
		[SessionUserID]            [int] NULL,
		[SessionLocation]          [nvarchar](450) NULL,
		[SessionLastActive]        [datetime] NOT NULL,
		[SessionLastLogon]         [datetime] NULL,
		[SessionExpires]           [datetime] NOT NULL,
		[SessionExpired]           [bit] NOT NULL,
		[SessionSiteID]            [int] NULL,
		[SessionUserIsHidden]      [bit] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_Session]
	ADD
	CONSTRAINT [PK_CMS_Session]
	PRIMARY KEY
	NONCLUSTERED
	([SessionIdentificator])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_Session]
	ADD
	CONSTRAINT [DEFAULT_CMS_Session_SessionExpired]
	DEFAULT ((0)) FOR [SessionExpired]
ALTER TABLE [CMS_Session]
	ADD
	CONSTRAINT [DEFAULT_CMS_Session_SessionExpires]
	DEFAULT ('9/9/2008 3:45:44 PM') FOR [SessionExpires]
ALTER TABLE [CMS_Session]
	ADD
	CONSTRAINT [DEFAULT_CMS_Session_SessionLastActive]
	DEFAULT ('9/9/2008 3:44:26 PM') FOR [SessionLastActive]
CREATE CLUSTERED INDEX [IX_CMS_Session_SessionLocation]
	ON [CMS_Session] ([SessionLocation])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Session_SessionSiteID]
	ON [CMS_Session] ([SessionSiteID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Session_SessionUserID]
	ON [CMS_Session] ([SessionUserID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Session_SessionUserIsHidden]
	ON [CMS_Session] ([SessionUserIsHidden])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [CMS_Session]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Session_SessionSiteID_CMS_Site]
	FOREIGN KEY ([SessionSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [CMS_Session]
	CHECK CONSTRAINT [FK_CMS_Session_SessionSiteID_CMS_Site]
ALTER TABLE [CMS_Session]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Session_SessionUserID_CMS_User]
	FOREIGN KEY ([SessionUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [CMS_Session]
	CHECK CONSTRAINT [FK_CMS_Session_SessionUserID_CMS_User]
