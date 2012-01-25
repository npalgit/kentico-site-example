CREATE TABLE [Integration_SyncLog] (
		[SyncLogID]                    [int] IDENTITY(1, 1) NOT NULL,
		[SyncLogSynchronizationID]     [int] NOT NULL,
		[SyncLogTime]                  [datetime] NOT NULL,
		[SyncLogErrorMessage]          [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Integration_SyncLog]
	ADD
	CONSTRAINT [PK_Integration_SyncLog]
	PRIMARY KEY
	CLUSTERED
	([SyncLogID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Integration_SyncLog_SyncLogTaskID]
	ON [Integration_SyncLog] ([SyncLogSynchronizationID])
	ON [PRIMARY]
ALTER TABLE [Integration_SyncLog]
	WITH CHECK
	ADD CONSTRAINT [FK_Integration_SyncLog_SyncLogSynchronizationID_Integration_Synchronization]
	FOREIGN KEY ([SyncLogSynchronizationID]) REFERENCES [Integration_Synchronization] ([SynchronizationID])
ALTER TABLE [Integration_SyncLog]
	CHECK CONSTRAINT [FK_Integration_SyncLog_SyncLogSynchronizationID_Integration_Synchronization]
