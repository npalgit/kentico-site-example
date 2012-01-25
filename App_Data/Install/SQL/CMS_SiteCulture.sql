CREATE TABLE [CMS_SiteCulture] (
		[SiteID]        [int] NOT NULL,
		[CultureID]     [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_SiteCulture]
	ADD
	CONSTRAINT [PK_CMS_SiteCulture]
	PRIMARY KEY
	CLUSTERED
	([SiteID], [CultureID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_SiteCulture]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_SiteCulture_CultureID_CMS_Culture]
	FOREIGN KEY ([CultureID]) REFERENCES [CMS_Culture] ([CultureID])
ALTER TABLE [CMS_SiteCulture]
	CHECK CONSTRAINT [FK_CMS_SiteCulture_CultureID_CMS_Culture]
ALTER TABLE [CMS_SiteCulture]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_SiteCulture_SiteID_CMS_Site]
	FOREIGN KEY ([SiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [CMS_SiteCulture]
	CHECK CONSTRAINT [FK_CMS_SiteCulture_SiteID_CMS_Site]
