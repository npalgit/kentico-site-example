CREATE VIEW [View_CMS_LayoutMetafile_Joined]
AS
SELECT     dbo.CMS_Layout.LayoutID, dbo.CMS_Layout.LayoutCodeName, dbo.CMS_Layout.LayoutDisplayName, dbo.CMS_Layout.LayoutDescription, 
                      LayoutFiles.MetaFileGUID
FROM         dbo.CMS_Layout LEFT OUTER JOIN
                          (SELECT     MetaFileGUID, MetaFileObjectID
                            FROM          dbo.CMS_MetaFile
                            WHERE      (MetaFileObjectType = 'cms.layout')) AS LayoutFiles ON dbo.CMS_Layout.LayoutID = LayoutFiles.MetaFileObjectID
GO
