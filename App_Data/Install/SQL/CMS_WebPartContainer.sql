CREATE TABLE [CMS_WebPartContainer] (
		[ContainerID]               [int] IDENTITY(1, 1) NOT NULL,
		[ContainerDisplayName]      [nvarchar](200) NOT NULL,
		[ContainerName]             [nvarchar](200) NOT NULL,
		[ContainerTextBefore]       [nvarchar](max) NULL,
		[ContainerTextAfter]        [nvarchar](max) NULL,
		[ContainerGUID]             [uniqueidentifier] NOT NULL,
		[ContainerLastModified]     [datetime] NOT NULL,
		[ContainerCSS]              [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_WebPartContainer]
	ADD
	CONSTRAINT [PK_CMS_WebPartContainer]
	PRIMARY KEY
	NONCLUSTERED
	([ContainerID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_WebPartContainer_ContainerDisplayName]
	ON [CMS_WebPartContainer] ([ContainerDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_WebPartContainer_ContainerName]
	ON [CMS_WebPartContainer] ([ContainerName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
