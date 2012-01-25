CREATE VIEW [View_Document_Attachment]
AS
SELECT     AttachmentDocumentID, MAX(AttachmentID) AS AttachmentID, MAX(AttachmentHistoryID) AS AttachmentHistoryID
FROM         (SELECT     AttachmentDocumentID, NULL AS AttachmentID, MAX(AttachmentHistoryID) AS AttachmentHistoryID
                       FROM          dbo.CMS_AttachmentHistory
                       WHERE      (AttachmentDocumentID IS NOT NULL)
                       GROUP BY AttachmentDocumentID
                       UNION ALL
                       SELECT     AttachmentDocumentID, MAX(AttachmentID) AS AttachmentID, NULL AS AttachmentHistoryID
                       FROM         dbo.CMS_Attachment
                       WHERE     (AttachmentDocumentID IS NOT NULL)
                       GROUP BY AttachmentDocumentID) AS AllDocuments
GROUP BY AttachmentDocumentID
GO
