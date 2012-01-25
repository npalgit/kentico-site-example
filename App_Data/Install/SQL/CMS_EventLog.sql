CREATE TABLE [CMS_EventLog] (
		[EventID]              [int] IDENTITY(1, 1) NOT NULL,
		[EventType]            [nvarchar](5) NOT NULL,
		[EventTime]            [datetime] NOT NULL,
		[Source]               [nvarchar](100) NOT NULL,
		[EventCode]            [nvarchar](100) NOT NULL,
		[UserID]               [int] NULL,
		[UserName]             [nvarchar](250) NULL,
		[IPAddress]            [nvarchar](100) NULL,
		[NodeID]               [int] NULL,
		[DocumentName]         [nvarchar](100) NULL,
		[EventDescription]     [nvarchar](max) NULL,
		[SiteID]               [int] NULL,
		[EventUrl]             [nvarchar](2000) NULL,
		[EventMachineName]     [nvarchar](100) NULL,
		[EventUserAgent]       [nvarchar](max) NULL,
		[EventUrlReferrer]     [nvarchar](2000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_EventLog]
	ADD
	CONSTRAINT [PK_CMS_EventLog]
	PRIMARY KEY
	NONCLUSTERED
	([EventID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_EventLog_EventTime]
	ON [CMS_EventLog] ([EventTime] DESC)
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_EventLog_NodeID]
	ON [CMS_EventLog] ([NodeID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_EventLog_SiteID_EventType_Source_EventCode]
	ON [CMS_EventLog] ([SiteID], [EventType], [Source], [EventCode])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_EventLog_UserID]
	ON [CMS_EventLog] ([UserID])
	ON [PRIMARY]
ALTER TABLE [CMS_EventLog]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Event_NodeID_CMS_Tree]
	FOREIGN KEY ([NodeID]) REFERENCES [CMS_Tree] ([NodeID])
ALTER TABLE [CMS_EventLog]
	CHECK CONSTRAINT [FK_CMS_Event_NodeID_CMS_Tree]
ALTER TABLE [CMS_EventLog]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Event_SiteID_CMS_Site]
	FOREIGN KEY ([SiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [CMS_EventLog]
	CHECK CONSTRAINT [FK_CMS_Event_SiteID_CMS_Site]
ALTER TABLE [CMS_EventLog]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Event_UserID_CMS_User]
	FOREIGN KEY ([UserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [CMS_EventLog]
	CHECK CONSTRAINT [FK_CMS_Event_UserID_CMS_User]
