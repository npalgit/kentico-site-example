CREATE TABLE [CMS_WebFarmServerTask] (
		[ServerID]         [int] NOT NULL,
		[TaskID]           [int] NOT NULL,
		[ErrorMessage]     [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_WebFarmServerTask]
	ADD
	CONSTRAINT [PK_CMS_WebFarmServerTask]
	PRIMARY KEY
	CLUSTERED
	([ServerID], [TaskID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_WebFarmServerTask_ServerID_TaskID]
	ON [CMS_WebFarmServerTask] ([ServerID], [TaskID])
	ON [PRIMARY]
ALTER TABLE [CMS_WebFarmServerTask]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_WebFarmServerTask_ServerID_CMS_WebFarmServer]
	FOREIGN KEY ([ServerID]) REFERENCES [CMS_WebFarmServer] ([ServerID])
ALTER TABLE [CMS_WebFarmServerTask]
	CHECK CONSTRAINT [FK_CMS_WebFarmServerTask_ServerID_CMS_WebFarmServer]
ALTER TABLE [CMS_WebFarmServerTask]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_WebFarmServerTask_TaskID_CMS_WebFarmTask]
	FOREIGN KEY ([TaskID]) REFERENCES [CMS_WebFarmTask] ([TaskID])
ALTER TABLE [CMS_WebFarmServerTask]
	CHECK CONSTRAINT [FK_CMS_WebFarmServerTask_TaskID_CMS_WebFarmTask]
