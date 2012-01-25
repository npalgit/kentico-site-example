CREATE TABLE [Staging_SyncLog] (
		[SyncLogID]           [int] IDENTITY(1, 1) NOT NULL,
		[SyncLogTaskID]       [int] NOT NULL,
		[SyncLogServerID]     [int] NOT NULL,
		[SyncLogTime]         [datetime] NOT NULL,
		[SyncLogError]        [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Staging_SyncLog]
	ADD
	CONSTRAINT [PK_Staging_SyncLog]
	PRIMARY KEY
	CLUSTERED
	([SyncLogID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_SyncLog_SyncLogServerID]
	ON [Staging_SyncLog] ([SyncLogServerID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_SyncLog_SyncLogTaskID]
	ON [Staging_SyncLog] ([SyncLogTaskID])
	ON [PRIMARY]
ALTER TABLE [Staging_SyncLog]
	WITH CHECK
	ADD CONSTRAINT [FK_Staging_SyncLog_SyncLogServerID_Staging_Server]
	FOREIGN KEY ([SyncLogServerID]) REFERENCES [Staging_Server] ([ServerID])
ALTER TABLE [Staging_SyncLog]
	CHECK CONSTRAINT [FK_Staging_SyncLog_SyncLogServerID_Staging_Server]
ALTER TABLE [Staging_SyncLog]
	WITH CHECK
	ADD CONSTRAINT [FK_Staging_SyncLog_SyncLogTaskID_Staging_Task]
	FOREIGN KEY ([SyncLogTaskID]) REFERENCES [Staging_Task] ([TaskID])
ALTER TABLE [Staging_SyncLog]
	CHECK CONSTRAINT [FK_Staging_SyncLog_SyncLogTaskID_Staging_Task]
