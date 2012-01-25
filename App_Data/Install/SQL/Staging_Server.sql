CREATE TABLE [Staging_Server] (
		[ServerID]                  [int] IDENTITY(1, 1) NOT NULL,
		[ServerName]                [nvarchar](100) NOT NULL,
		[ServerDisplayName]         [nvarchar](440) NOT NULL,
		[ServerSiteID]              [int] NOT NULL,
		[ServerURL]                 [nvarchar](450) NOT NULL,
		[ServerEnabled]             [bit] NOT NULL,
		[ServerAuthentication]      [nvarchar](20) NOT NULL,
		[ServerUsername]            [nvarchar](100) NULL,
		[ServerPassword]            [nvarchar](100) NULL,
		[ServerX509ClientKeyID]     [nvarchar](200) NULL,
		[ServerX509ServerKeyID]     [nvarchar](200) NULL,
		[ServerGUID]                [uniqueidentifier] NOT NULL,
		[ServerLastModified]        [datetime] NOT NULL
) ON [PRIMARY]
ALTER TABLE [Staging_Server]
	ADD
	CONSTRAINT [PK_Staging_Server]
	PRIMARY KEY
	NONCLUSTERED
	([ServerID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [Staging_Server]
	ADD
	CONSTRAINT [DEFAULT_staging_server_ServerDisplayName]
	DEFAULT ('') FOR [ServerDisplayName]
CREATE NONCLUSTERED INDEX [IX_Staging_Server_ServerEnabled]
	ON [Staging_Server] ([ServerEnabled])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Staging_Server_ServerSiteID_ServerDisplayName]
	ON [Staging_Server] ([ServerSiteID], [ServerDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Staging_Server]
	WITH CHECK
	ADD CONSTRAINT [FK_Staging_Server_ServerSiteID_CMS_Site]
	FOREIGN KEY ([ServerSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Staging_Server]
	CHECK CONSTRAINT [FK_Staging_Server_ServerSiteID_CMS_Site]
