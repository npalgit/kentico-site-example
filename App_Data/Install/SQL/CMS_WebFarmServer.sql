CREATE TABLE [CMS_WebFarmServer] (
		[ServerID]               [int] IDENTITY(1, 1) NOT NULL,
		[ServerDisplayName]      [nvarchar](200) NOT NULL,
		[ServerName]             [nvarchar](200) NOT NULL,
		[ServerURL]              [nvarchar](2000) NOT NULL,
		[ServerGUID]             [uniqueidentifier] NOT NULL,
		[ServerLastModified]     [datetime] NOT NULL,
		[ServerEnabled]          [bit] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_WebFarmServer]
	ADD
	CONSTRAINT [PK_CMS_WebFarmServer]
	PRIMARY KEY
	NONCLUSTERED
	([ServerID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_WebFarmServer_ServerDisplayName]
	ON [CMS_WebFarmServer] ([ServerDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_WebFarmServer_ServerName]
	ON [CMS_WebFarmServer] ([ServerName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
