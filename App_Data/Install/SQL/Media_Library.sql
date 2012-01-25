CREATE TABLE [Media_Library] (
		[LibraryID]               [int] IDENTITY(1, 1) NOT NULL,
		[LibraryName]             [nvarchar](250) NOT NULL,
		[LibraryDisplayName]      [nvarchar](250) NOT NULL,
		[LibraryDescription]      [nvarchar](max) NOT NULL,
		[LibraryFolder]           [nvarchar](250) NOT NULL,
		[LibraryAccess]           [int] NOT NULL,
		[LibraryGroupID]          [int] NULL,
		[LibrarySiteID]           [int] NOT NULL,
		[LibraryGUID]             [uniqueidentifier] NOT NULL,
		[LibraryLastModified]     [datetime] NOT NULL,
		[LibraryTeaserPath]       [nvarchar](450) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Media_Library]
	ADD
	CONSTRAINT [PK_Media_Library]
	PRIMARY KEY
	NONCLUSTERED
	([LibraryID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Media_Library_LibraryDisplayName]
	ON [Media_Library] ([LibrarySiteID], [LibraryDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Media_Library_LibraryGroupID]
	ON [Media_Library] ([LibraryGroupID])
	ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [IX_Media_Library_LibrarySiteID_LibraryName_LibraryGUID]
	ON [Media_Library] ([LibrarySiteID], [LibraryName], [LibraryGUID])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Media_Library]
	WITH CHECK
	ADD CONSTRAINT [FK_Media_Library_LibraryGroupID_Community_Group]
	FOREIGN KEY ([LibraryGroupID]) REFERENCES [Community_Group] ([GroupID])
ALTER TABLE [Media_Library]
	CHECK CONSTRAINT [FK_Media_Library_LibraryGroupID_Community_Group]
ALTER TABLE [Media_Library]
	WITH CHECK
	ADD CONSTRAINT [FK_Media_Library_LibrarySiteID_CMS_Site]
	FOREIGN KEY ([LibrarySiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Media_Library]
	CHECK CONSTRAINT [FK_Media_Library_LibrarySiteID_CMS_Site]
