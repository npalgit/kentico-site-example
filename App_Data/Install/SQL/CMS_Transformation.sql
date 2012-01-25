CREATE TABLE [CMS_Transformation] (
		[TransformationID]                        [int] IDENTITY(1, 1) NOT NULL,
		[TransformationName]                      [nvarchar](100) NOT NULL,
		[TransformationCode]                      [nvarchar](max) NOT NULL,
		[TransformationType]                      [nvarchar](50) NOT NULL,
		[TransformationClassID]                   [int] NOT NULL,
		[TransformationCheckedOutByUserID]        [int] NULL,
		[TransformationCheckedOutMachineName]     [nvarchar](100) NULL,
		[TransformationCheckedOutFilename]        [nvarchar](450) NULL,
		[TransformationVersionGUID]               [nvarchar](50) NULL,
		[TransformationGUID]                      [uniqueidentifier] NOT NULL,
		[TransformationLastModified]              [datetime] NOT NULL,
		[TransformationIsHierarchical]            [bit] NULL,
		[TransformationHierarchicalXML]           [nvarchar](max) NULL,
		[TransformationCSS]                       [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_Transformation]
	ADD
	CONSTRAINT [PK_CMS_Transformation]
	PRIMARY KEY
	NONCLUSTERED
	([TransformationID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_Transformation]
	ADD
	CONSTRAINT [DEFAULT_CMS_Transformation_TransformationIsHierarchical]
	DEFAULT ((0)) FOR [TransformationIsHierarchical]
CREATE NONCLUSTERED INDEX [IX_CMS_Transformation_TransformationCheckedOutByUserID]
	ON [CMS_Transformation] ([TransformationCheckedOutByUserID])
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_Transformation_TransformationClassID_TransformationName]
	ON [CMS_Transformation] ([TransformationClassID], [TransformationName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [CMS_Transformation]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Transformation_TransformationCheckedOutByUserID_CMS_User]
	FOREIGN KEY ([TransformationCheckedOutByUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [CMS_Transformation]
	CHECK CONSTRAINT [FK_CMS_Transformation_TransformationCheckedOutByUserID_CMS_User]
ALTER TABLE [CMS_Transformation]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Transformation_TransformationClassID_CMS_Class]
	FOREIGN KEY ([TransformationClassID]) REFERENCES [CMS_Class] ([ClassID])
ALTER TABLE [CMS_Transformation]
	CHECK CONSTRAINT [FK_CMS_Transformation_TransformationClassID_CMS_Class]
