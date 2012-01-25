CREATE TABLE [OM_Activity] (
		[ActivityID]                    [int] IDENTITY(1, 1) NOT NULL,
		[ActivityActiveContactID]       [int] NOT NULL,
		[ActivityOriginalContactID]     [int] NOT NULL,
		[ActivityCreated]               [datetime] NULL,
		[ActivityType]                  [nvarchar](250) NOT NULL,
		[ActivityItemID]                [int] NULL,
		[ActivityItemDetailID]          [int] NULL,
		[ActivityValue]                 [nvarchar](250) NULL,
		[ActivityURL]                   [nvarchar](max) NULL,
		[ActivityTitle]                 [nvarchar](250) NULL,
		[ActivitySiteID]                [int] NULL,
		[ActivityGUID]                  [uniqueidentifier] NOT NULL,
		[ActivityIPAddress]             [nvarchar](100) NULL,
		[ActivityComment]               [nvarchar](max) NULL,
		[ActivityCampaign]              [nvarchar](200) NULL,
		[ActivityURLReferrer]           [nvarchar](max) NULL,
		[ActivityCulture]               [nvarchar](10) NULL,
		[ActivityNodeID]                [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [OM_Activity]
	ADD
	CONSTRAINT [PK_OM_Activity]
	PRIMARY KEY
	CLUSTERED
	([ActivityID])
	ON [PRIMARY]
ALTER TABLE [OM_Activity]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_Activity_CMS_Site]
	FOREIGN KEY ([ActivitySiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [OM_Activity]
	CHECK CONSTRAINT [FK_OM_Activity_CMS_Site]
ALTER TABLE [OM_Activity]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_Activity_OM_Contact_Active]
	FOREIGN KEY ([ActivityActiveContactID]) REFERENCES [OM_Contact] ([ContactID])
ALTER TABLE [OM_Activity]
	CHECK CONSTRAINT [FK_OM_Activity_OM_Contact_Active]
ALTER TABLE [OM_Activity]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_Activity_OM_Contact_Original]
	FOREIGN KEY ([ActivityOriginalContactID]) REFERENCES [OM_Contact] ([ContactID])
ALTER TABLE [OM_Activity]
	CHECK CONSTRAINT [FK_OM_Activity_OM_Contact_Original]
