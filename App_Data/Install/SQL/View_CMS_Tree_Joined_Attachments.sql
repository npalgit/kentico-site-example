CREATE VIEW [View_CMS_Tree_Joined_Attachments]
AS
SELECT     dbo.View_CMS_Tree_Joined.*, dbo.View_Document_Attachment.AttachmentID, 
                      dbo.View_Document_Attachment.AttachmentHistoryID, dbo.CMS_Attachment.AttachmentName, dbo.CMS_Attachment.AttachmentExtension, 
                      dbo.CMS_Attachment.AttachmentSize, dbo.CMS_Attachment.AttachmentMimeType, dbo.CMS_Attachment.AttachmentImageWidth, 
                      dbo.CMS_Attachment.AttachmentImageHeight, dbo.CMS_Attachment.AttachmentGUID, dbo.CMS_Attachment.AttachmentIsUnsorted, 
                      dbo.CMS_Attachment.AttachmentOrder, dbo.CMS_Attachment.AttachmentGroupGUID, dbo.CMS_Attachment.AttachmentTitle, dbo.CMS_Attachment.AttachmentDescription
FROM         dbo.View_CMS_Tree_Joined LEFT OUTER JOIN
                      dbo.View_Document_Attachment ON 
                      dbo.View_CMS_Tree_Joined.DocumentID = dbo.View_Document_Attachment.AttachmentDocumentID LEFT OUTER JOIN
                      dbo.CMS_Attachment ON dbo.View_Document_Attachment.AttachmentID = dbo.CMS_Attachment.AttachmentID
GO
