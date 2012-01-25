CREATE TABLE [CMS_SearchIndexCulture] (
		[IndexID]            [int] NOT NULL,
		[IndexCultureID]     [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_SearchIndexCulture]
	ADD
	CONSTRAINT [PK_CMS_SearchIndexCulture]
	PRIMARY KEY
	CLUSTERED
	([IndexID], [IndexCultureID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_SearchIndexCulture]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_SearchIndexCulture_IndexCultureID_CMS_Culture]
	FOREIGN KEY ([IndexCultureID]) REFERENCES [CMS_Culture] ([CultureID])
ALTER TABLE [CMS_SearchIndexCulture]
	CHECK CONSTRAINT [FK_CMS_SearchIndexCulture_IndexCultureID_CMS_Culture]
ALTER TABLE [CMS_SearchIndexCulture]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_SearchIndexCulture_IndexID_CMS_SearchIndex]
	FOREIGN KEY ([IndexID]) REFERENCES [CMS_SearchIndex] ([IndexID])
ALTER TABLE [CMS_SearchIndexCulture]
	CHECK CONSTRAINT [FK_CMS_SearchIndexCulture_IndexID_CMS_SearchIndex]
