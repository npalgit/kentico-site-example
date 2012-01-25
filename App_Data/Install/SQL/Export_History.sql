CREATE TABLE [Export_History] (
		[ExportID]           [int] IDENTITY(1, 1) NOT NULL,
		[ExportDateTime]     [datetime] NOT NULL,
		[ExportFileName]     [nvarchar](450) NOT NULL,
		[ExportSiteID]       [int] NULL,
		[ExportUserID]       [int] NULL,
		[ExportSettings]     [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Export_History]
	ADD
	CONSTRAINT [PK_Export_History]
	PRIMARY KEY
	NONCLUSTERED
	([ExportID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Export_History_ExportDateTime]
	ON [Export_History] ([ExportDateTime] DESC)
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Export_History_ExportSiteID]
	ON [Export_History] ([ExportSiteID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Export_History_ExportUserID]
	ON [Export_History] ([ExportUserID])
	ON [PRIMARY]
ALTER TABLE [Export_History]
	WITH CHECK
	ADD CONSTRAINT [FK_Export_History_ExportSiteID_CMS_Site]
	FOREIGN KEY ([ExportSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Export_History]
	CHECK CONSTRAINT [FK_Export_History_ExportSiteID_CMS_Site]
ALTER TABLE [Export_History]
	WITH CHECK
	ADD CONSTRAINT [FK_Export_History_ExportUserID_CMS_User]
	FOREIGN KEY ([ExportUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [Export_History]
	CHECK CONSTRAINT [FK_Export_History_ExportUserID_CMS_User]
