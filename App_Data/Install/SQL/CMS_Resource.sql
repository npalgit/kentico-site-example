CREATE TABLE [CMS_Resource] (
		[ResourceID]               [int] IDENTITY(1, 1) NOT NULL,
		[ResourceDisplayName]      [nvarchar](100) NOT NULL,
		[ResourceName]             [nvarchar](100) NOT NULL,
		[ResourceDescription]      [nvarchar](max) NULL,
		[ShowInDevelopment]        [bit] NULL,
		[ResourceURL]              [nvarchar](1000) NULL,
		[ResourceGUID]             [uniqueidentifier] NOT NULL,
		[ResourceLastModified]     [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_Resource]
	ADD
	CONSTRAINT [PK_CMS_Resource]
	PRIMARY KEY
	NONCLUSTERED
	([ResourceID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_Resource_ResourceDisplayName]
	ON [CMS_Resource] ([ResourceDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Resource_ResourceName]
	ON [CMS_Resource] ([ResourceName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
