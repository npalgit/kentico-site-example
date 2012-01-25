CREATE TABLE [CMS_AllowedChildClasses] (
		[ParentClassID]     [int] NOT NULL,
		[ChildClassID]      [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_AllowedChildClasses]
	ADD
	CONSTRAINT [PK_CMS_AllowedChildClasses]
	PRIMARY KEY
	CLUSTERED
	([ParentClassID], [ChildClassID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_AllowedChildClasses]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_AllowedChildClasses_ChildClassID_CMS_Class]
	FOREIGN KEY ([ChildClassID]) REFERENCES [CMS_Class] ([ClassID])
ALTER TABLE [CMS_AllowedChildClasses]
	CHECK CONSTRAINT [FK_CMS_AllowedChildClasses_ChildClassID_CMS_Class]
ALTER TABLE [CMS_AllowedChildClasses]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_AllowedChildClasses_ParentClassID_CMS_Class]
	FOREIGN KEY ([ParentClassID]) REFERENCES [CMS_Class] ([ClassID])
ALTER TABLE [CMS_AllowedChildClasses]
	CHECK CONSTRAINT [FK_CMS_AllowedChildClasses_ParentClassID_CMS_Class]
