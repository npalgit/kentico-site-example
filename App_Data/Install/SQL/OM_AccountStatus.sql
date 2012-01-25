CREATE TABLE [OM_AccountStatus] (
		[AccountStatusID]              [int] IDENTITY(1, 1) NOT NULL,
		[AccountStatusName]            [nvarchar](200) NOT NULL,
		[AccountStatusDisplayName]     [nvarchar](200) NOT NULL,
		[AccountStatusDescription]     [nvarchar](max) NULL,
		[AccountStatusSiteID]          [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [OM_AccountStatus]
	ADD
	CONSTRAINT [PK_OM_AccountStatus]
	PRIMARY KEY
	CLUSTERED
	([AccountStatusID])
	ON [PRIMARY]
ALTER TABLE [OM_AccountStatus]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_AccountStatus_CMS_Site]
	FOREIGN KEY ([AccountStatusSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [OM_AccountStatus]
	CHECK CONSTRAINT [FK_OM_AccountStatus_CMS_Site]
