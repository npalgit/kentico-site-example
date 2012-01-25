CREATE TABLE [CMS_MetaFile] (
		[MetaFileID]               [int] IDENTITY(1, 1) NOT NULL,
		[MetaFileObjectID]         [int] NOT NULL,
		[MetaFileObjectType]       [nvarchar](100) NOT NULL,
		[MetaFileGroupName]        [nvarchar](100) NULL,
		[MetaFileName]             [nvarchar](250) NOT NULL,
		[MetaFileExtension]        [nvarchar](50) NOT NULL,
		[MetaFileSize]             [int] NOT NULL,
		[MetaFileMimeType]         [nvarchar](100) NOT NULL,
		[MetaFileBinary]           [varbinary](max) NULL,
		[MetaFileImageWidth]       [int] NULL,
		[MetaFileImageHeight]      [int] NULL,
		[MetaFileGUID]             [uniqueidentifier] NOT NULL,
		[MetaFileLastModified]     [datetime] NOT NULL,
		[MetaFileSiteID]           [int] NULL,
		[MetaFileTitle]            [nvarchar](250) NULL,
		[MetaFileDescription]      [nvarchar](max) NULL,
		[MetaFileCustomData]       [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_MetaFile]
	ADD
	CONSTRAINT [PK_CMS_MetaFile]
	PRIMARY KEY
	NONCLUSTERED
	([MetaFileID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_MetaFile_MetaFileGUID_MetaFileSiteID_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName]
	ON [CMS_MetaFile] ([MetaFileGUID], [MetaFileSiteID], [MetaFileObjectType], [MetaFileObjectID], [MetaFileGroupName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_Metafile_MetaFileObjectType_MetaFileObjectID_MetaFileGroupName]
	ON [CMS_MetaFile] ([MetaFileObjectType], [MetaFileObjectID], [MetaFileGroupName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [CMS_MetaFile]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_MetaFile_MetaFileSiteID_CMS_Site]
	FOREIGN KEY ([MetaFileSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [CMS_MetaFile]
	CHECK CONSTRAINT [FK_CMS_MetaFile_MetaFileSiteID_CMS_Site]
