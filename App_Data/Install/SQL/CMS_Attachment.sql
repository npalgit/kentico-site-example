CREATE TABLE [CMS_Attachment] (
		[AttachmentID]                [int] IDENTITY(1, 1) NOT NULL,
		[AttachmentName]              [nvarchar](255) NOT NULL,
		[AttachmentExtension]         [nvarchar](50) NOT NULL,
		[AttachmentSize]              [int] NOT NULL,
		[AttachmentMimeType]          [nvarchar](100) NOT NULL,
		[AttachmentBinary]            [varbinary](max) NULL,
		[AttachmentImageWidth]        [int] NULL,
		[AttachmentImageHeight]       [int] NULL,
		[AttachmentDocumentID]        [int] NULL,
		[AttachmentGUID]              [uniqueidentifier] NOT NULL,
		[AttachmentLastHistoryID]     [int] NULL,
		[AttachmentSiteID]            [int] NULL,
		[AttachmentLastModified]      [datetime] NOT NULL,
		[AttachmentIsUnsorted]        [bit] NULL,
		[AttachmentOrder]             [int] NULL,
		[AttachmentGroupGUID]         [uniqueidentifier] NULL,
		[AttachmentFormGUID]          [uniqueidentifier] NULL,
		[AttachmentHash]              [nvarchar](32) NULL,
		[AttachmentTitle]             [nvarchar](250) NULL,
		[AttachmentDescription]       [nvarchar](max) NULL,
		[AttachmentCustomData]        [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [CMS_Attachment]
	ADD
	CONSTRAINT [PK_CMS_Attachment]
	PRIMARY KEY
	NONCLUSTERED
	([AttachmentID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_Attachment_AttachmentDocumentID_AttachmentIsUnsorted_AttachmentName_AttachmentOrder]
	ON [CMS_Attachment] ([AttachmentDocumentID], [AttachmentName], [AttachmentIsUnsorted], [AttachmentOrder])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Attachment_AttachmentGUID_AttachmentSiteID]
	ON [CMS_Attachment] ([AttachmentGUID], [AttachmentSiteID])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Attachment_AttachmentIsUnsorted_AttachmentGroupGUID_AttachmentFormGUID_AttachmentOrder]
	ON [CMS_Attachment] ([AttachmentIsUnsorted], [AttachmentGroupGUID], [AttachmentFormGUID], [AttachmentOrder])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [CMS_Attachment]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Attachment_AttachmentDocumentID_CMS_Document]
	FOREIGN KEY ([AttachmentDocumentID]) REFERENCES [CMS_Document] ([DocumentID])
ALTER TABLE [CMS_Attachment]
	CHECK CONSTRAINT [FK_CMS_Attachment_AttachmentDocumentID_CMS_Document]
ALTER TABLE [CMS_Attachment]
	WITH CHECK
	ADD CONSTRAINT [FK_CMS_Attachment_AttachmentSiteID_CMS_Site]
	FOREIGN KEY ([AttachmentSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [CMS_Attachment]
	CHECK CONSTRAINT [FK_CMS_Attachment_AttachmentSiteID_CMS_Site]
