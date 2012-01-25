CREATE VIEW [View_CMS_Tree_Joined_Versions_Attachments]
AS
SELECT     dbo.View_CMS_Tree_Joined_Versions.*, dbo.View_Document_Attachment.AttachmentID, 
                      dbo.View_Document_Attachment.AttachmentHistoryID, dbo.CMS_Attachment.AttachmentName, dbo.CMS_Attachment.AttachmentExtension, 
                      dbo.CMS_Attachment.AttachmentSize, dbo.CMS_Attachment.AttachmentMimeType, dbo.CMS_Attachment.AttachmentImageWidth, 
                      dbo.CMS_Attachment.AttachmentImageHeight, dbo.CMS_Attachment.AttachmentGUID, dbo.CMS_Attachment.AttachmentIsUnsorted, 
                      dbo.CMS_Attachment.AttachmentOrder, dbo.CMS_Attachment.AttachmentGroupGUID, dbo.CMS_Attachment.AttachmentTitle, dbo.CMS_Attachment.AttachmentDescription
FROM         dbo.View_CMS_Tree_Joined_Versions LEFT OUTER JOIN
                      dbo.View_Document_Attachment ON 
                      dbo.View_CMS_Tree_Joined_Versions.DocumentID = dbo.View_Document_Attachment.AttachmentDocumentID LEFT OUTER JOIN
                      dbo.CMS_Attachment ON dbo.View_Document_Attachment.AttachmentID = dbo.CMS_Attachment.AttachmentID
WHERE     (dbo.View_Document_Attachment.AttachmentHistoryID IS NULL)
UNION ALL
SELECT     View_CMS_Tree_Joined_Versions_1.*, View_Document_Attachment_1.AttachmentID, View_Document_Attachment_1.AttachmentHistoryID, 
                      dbo.CMS_AttachmentHistory.AttachmentName, dbo.CMS_AttachmentHistory.AttachmentExtension, dbo.CMS_AttachmentHistory.AttachmentSize, 
                      dbo.CMS_AttachmentHistory.AttachmentMimeType, dbo.CMS_AttachmentHistory.AttachmentImageWidth, 
                      dbo.CMS_AttachmentHistory.AttachmentImageHeight, dbo.CMS_AttachmentHistory.AttachmentGUID, 
                      dbo.CMS_AttachmentHistory.AttachmentIsUnsorted, dbo.CMS_AttachmentHistory.AttachmentOrder, 
                      dbo.CMS_AttachmentHistory.AttachmentGroupGUID, dbo.CMS_AttachmentHistory.AttachmentTitle, dbo.CMS_AttachmentHistory.AttachmentDescription
FROM         dbo.View_CMS_Tree_Joined_Versions AS View_CMS_Tree_Joined_Versions_1 LEFT OUTER JOIN
                      dbo.View_Document_Attachment AS View_Document_Attachment_1 ON 
                      View_CMS_Tree_Joined_Versions_1.DocumentID = View_Document_Attachment_1.AttachmentDocumentID LEFT OUTER JOIN
                      dbo.CMS_AttachmentHistory ON View_Document_Attachment_1.AttachmentHistoryID = dbo.CMS_AttachmentHistory.AttachmentHistoryID
WHERE     (View_Document_Attachment_1.AttachmentHistoryID IS NOT NULL)
GO
