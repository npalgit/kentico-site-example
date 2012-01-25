CREATE TABLE [Integration_Task] (
		[TaskID]                [int] IDENTITY(1, 1) NOT NULL,
		[TaskNodeID]            [int] NULL,
		[TaskDocumentID]        [int] NULL,
		[TaskNodeAliasPath]     [nvarchar](450) NULL,
		[TaskTitle]             [nvarchar](450) NOT NULL,
		[TaskTime]              [datetime] NOT NULL,
		[TaskType]              [nvarchar](50) NOT NULL,
		[TaskObjectType]        [nvarchar](100) NULL,
		[TaskObjectID]          [int] NULL,
		[TaskIsInbound]         [bit] NOT NULL,
		[TaskProcessType]       [nvarchar](50) NULL,
		[TaskData]              [nvarchar](max) NOT NULL,
		[TaskSiteID]            [int] NULL,
		[TaskDataType]          [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Integration_Task]
	ADD
	CONSTRAINT [PK_Integration_Task]
	PRIMARY KEY
	NONCLUSTERED
	([TaskID])
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Integration_Task_TaskNodeAliasPath]
	ON [Integration_Task] ([TaskNodeAliasPath])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Integration_Task_TaskSiteID]
	ON [Integration_Task] ([TaskSiteID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Integration_Task_TaskType]
	ON [Integration_Task] ([TaskType])
	ON [PRIMARY]
ALTER TABLE [Integration_Task]
	WITH CHECK
	ADD CONSTRAINT [FK_IntegrationTask_TaskSiteID_CMS_Site]
	FOREIGN KEY ([TaskSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Integration_Task]
	CHECK CONSTRAINT [FK_IntegrationTask_TaskSiteID_CMS_Site]
