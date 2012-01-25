CREATE TABLE [CMS_CssStylesheetSite] (
		[StylesheetID]     [int] NOT NULL,
		[SiteID]           [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_CssStylesheetSite]
	ADD
	CONSTRAINT [PK_CMS_CssStylesheetSite]
	PRIMARY KEY
	CLUSTERED
	([StylesheetID], [SiteID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_CssStylesheetSite]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_CssStylesheetSite_SiteID_CMS_Site]
	FOREIGN KEY ([SiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [CMS_CssStylesheetSite]
	CHECK CONSTRAINT [FK_CMS_CssStylesheetSite_SiteID_CMS_Site]
ALTER TABLE [CMS_CssStylesheetSite]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_CssStylesheetSite_StylesheetID_CMS_CssStylesheet]
	FOREIGN KEY ([StylesheetID]) REFERENCES [CMS_CssStylesheet] ([StylesheetID])
ALTER TABLE [CMS_CssStylesheetSite]
	CHECK CONSTRAINT [FK_CMS_CssStylesheetSite_StylesheetID_CMS_CssStylesheet]
