CREATE TABLE [Staging_Synchronization] (
		[SynchronizationID]               [int] IDENTITY(1, 1) NOT NULL,
		[SynchronizationTaskID]           [int] NOT NULL,
		[SynchronizationServerID]         [int] NOT NULL,
		[SynchronizationLastRun]          [datetime] NULL,
		[SynchronizationErrorMessage]     [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Staging_Synchronization]
	ADD
	CONSTRAINT [PK_Staging_Synchronization]
	PRIMARY KEY
	CLUSTERED
	([SynchronizationID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_Synchronization_SynchronizationServerID]
	ON [Staging_Synchronization] ([SynchronizationServerID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_Synchronization_SynchronizationTaskID]
	ON [Staging_Synchronization] ([SynchronizationTaskID])
	ON [PRIMARY]
ALTER TABLE [Staging_Synchronization]
	WITH CHECK
	ADD CONSTRAINT [FK_Staging_Synchronization_SynchronizationServerID_Staging_Server]
	FOREIGN KEY ([SynchronizationServerID]) REFERENCES [Staging_Server] ([ServerID])
ALTER TABLE [Staging_Synchronization]
	CHECK CONSTRAINT [FK_Staging_Synchronization_SynchronizationServerID_Staging_Server]
ALTER TABLE [Staging_Synchronization]
	WITH CHECK
	ADD CONSTRAINT [FK_Staging_Synchronization_SynchronizationTaskID_Staging_Task]
	FOREIGN KEY ([SynchronizationTaskID]) REFERENCES [Staging_Task] ([TaskID])
ALTER TABLE [Staging_Synchronization]
	CHECK CONSTRAINT [FK_Staging_Synchronization_SynchronizationTaskID_Staging_Task]
