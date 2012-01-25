CREATE TABLE [Notification_Template] (
		[TemplateID]               [int] IDENTITY(1, 1) NOT NULL,
		[TemplateName]             [nvarchar](250) NOT NULL,
		[TemplateDisplayName]      [nvarchar](250) NOT NULL,
		[TemplateSiteID]           [int] NULL,
		[TemplateLastModified]     [datetime] NOT NULL,
		[TemplateGUID]             [uniqueidentifier] NOT NULL
) ON [PRIMARY]
ALTER TABLE [Notification_Template]
	ADD
	CONSTRAINT [PK_Notification_Template]
	PRIMARY KEY
	NONCLUSTERED
	([TemplateID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Notification_Template_TemplateSiteID_TemplateDisplayName]
	ON [Notification_Template] ([TemplateSiteID], [TemplateDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Notification_Template]
	WITH CHECK
	ADD CONSTRAINT [FK_Notification_Template_TemplateSiteID_CMS_Site]
	FOREIGN KEY ([TemplateSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Notification_Template]
	CHECK CONSTRAINT [FK_Notification_Template_TemplateSiteID_CMS_Site]
