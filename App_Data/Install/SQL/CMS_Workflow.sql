CREATE TABLE [CMS_Workflow] (
		[WorkflowID]                     [int] IDENTITY(1, 1) NOT NULL,
		[WorkflowDisplayName]            [nvarchar](450) NOT NULL,
		[WorkflowName]                   [nvarchar](450) NOT NULL,
		[WorkflowGUID]                   [uniqueidentifier] NOT NULL,
		[WorkflowLastModified]           [datetime] NOT NULL,
		[WorkflowAutoPublishChanges]     [bit] NULL,
		[WorkflowUseCheckinCheckout]     [bit] NULL
) ON [PRIMARY]
ALTER TABLE [CMS_Workflow]
	ADD
	CONSTRAINT [PK_CMS_Workflow]
	PRIMARY KEY
	NONCLUSTERED
	([WorkflowID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_Workflow]
	ADD
	CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowAutoPublishChanges]
	DEFAULT ((0)) FOR [WorkflowAutoPublishChanges]
ALTER TABLE [CMS_Workflow]
	ADD
	CONSTRAINT [DEFAULT_CMS_Workflow_WorkflowUseCheckinCheckout]
	DEFAULT ((0)) FOR [WorkflowUseCheckinCheckout]
CREATE CLUSTERED INDEX [IX_CMS_Workflow_WorkflowDisplayName]
	ON [CMS_Workflow] ([WorkflowDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
