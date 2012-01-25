CREATE TABLE [Staging_Task] (
		[TaskID]                [int] IDENTITY(1, 1) NOT NULL,
		[TaskSiteID]            [int] NULL,
		[TaskDocumentID]        [int] NULL,
		[TaskNodeAliasPath]     [nvarchar](450) NULL,
		[TaskTitle]             [nvarchar](450) NOT NULL,
		[TaskData]              [nvarchar](max) NOT NULL,
		[TaskTime]              [datetime] NOT NULL,
		[TaskType]              [nvarchar](50) NOT NULL,
		[TaskObjectType]        [nvarchar](100) NULL,
		[TaskObjectID]          [int] NULL,
		[TaskRunning]           [bit] NULL,
		[TaskNodeID]            [int] NULL,
		[TaskServers]           [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Staging_Task]
	ADD
	CONSTRAINT [PK_Staging_Task]
	PRIMARY KEY
	NONCLUSTERED
	([TaskID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [Staging_Task]
	ADD
	CONSTRAINT [DEFAULT_Staging_Task_TaskServers]
	DEFAULT ('null') FOR [TaskServers]
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskDocumentID_TaskNodeID_TaskRunning]
	ON [Staging_Task] ([TaskDocumentID], [TaskNodeID], [TaskRunning])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Staging_Task_TaskNodeAliasPath]
	ON [Staging_Task] ([TaskNodeAliasPath])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskObjectType_TaskObjectID_TaskRunning]
	ON [Staging_Task] ([TaskObjectType], [TaskObjectID], [TaskRunning])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskSiteID]
	ON [Staging_Task] ([TaskSiteID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Staging_Task_TaskType]
	ON [Staging_Task] ([TaskType])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Staging_Task]
	WITH CHECK
	ADD CONSTRAINT [FK_Staging_Task_TaskSiteID_CMS_Site]
	FOREIGN KEY ([TaskSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Staging_Task]
	CHECK CONSTRAINT [FK_Staging_Task_TaskSiteID_CMS_Site]
