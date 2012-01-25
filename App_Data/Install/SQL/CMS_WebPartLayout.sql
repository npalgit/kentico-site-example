CREATE TABLE [CMS_WebPartLayout] (
		[WebPartLayoutID]                        [int] IDENTITY(1, 1) NOT NULL,
		[WebPartLayoutCodeName]                  [nvarchar](200) NOT NULL,
		[WebPartLayoutDisplayName]               [nvarchar](200) NOT NULL,
		[WebPartLayoutDescription]               [nvarchar](max) NULL,
		[WebPartLayoutCode]                      [nvarchar](max) NULL,
		[WebPartLayoutCheckedOutFilename]        [nvarchar](450) NULL,
		[WebPartLayoutCheckedOutByUserID]        [int] NULL,
		[WebPartLayoutCheckedOutMachineName]     [nvarchar](50) NULL,
		[WebPartLayoutVersionGUID]               [nvarchar](50) NULL,
		[WebPartLayoutWebPartID]                 [int] NOT NULL,
		[WebPartLayoutGUID]                      [uniqueidentifier] NOT NULL,
		[WebPartLayoutLastModified]              [datetime] NOT NULL,
		[WebPartLayoutCSS]                       [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_WebPartLayout]
	ADD
	CONSTRAINT [PK_CMS_WebPartLayout]
	PRIMARY KEY
	NONCLUSTERED
	([WebPartLayoutID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_WebPartLayout_WebPartLayoutCheckedOutByUserID]
	ON [CMS_WebPartLayout] ([WebPartLayoutCheckedOutByUserID])
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_WebPartLayout_WebPartLayoutWebPartID_WebPartLayoutCodeName]
	ON [CMS_WebPartLayout] ([WebPartLayoutWebPartID], [WebPartLayoutCodeName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [CMS_WebPartLayout]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_WebPartLayout_WebPartLayoutCheckedOutByUserID_CMS_User]
	FOREIGN KEY ([WebPartLayoutCheckedOutByUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [CMS_WebPartLayout]
	CHECK CONSTRAINT [FK_CMS_WebPartLayout_WebPartLayoutCheckedOutByUserID_CMS_User]
ALTER TABLE [CMS_WebPartLayout]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_WebPartLayout_WebPartLayoutWebPartID_CMS_WebPart]
	FOREIGN KEY ([WebPartLayoutWebPartID]) REFERENCES [CMS_WebPart] ([WebPartID])
ALTER TABLE [CMS_WebPartLayout]
	CHECK CONSTRAINT [FK_CMS_WebPartLayout_WebPartLayoutWebPartID_CMS_WebPart]
