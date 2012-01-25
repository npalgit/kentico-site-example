CREATE VIEW [View_CMS_WidgetMetafile_Joined]
AS
SELECT     dbo.CMS_Widget.WidgetID, dbo.CMS_Widget.WidgetWebPartID, dbo.CMS_Widget.WidgetDisplayName, dbo.CMS_Widget.WidgetName, 
                      dbo.CMS_Widget.WidgetDescription, dbo.CMS_Widget.WidgetCategoryID, dbo.CMS_Widget.WidgetProperties, dbo.CMS_Widget.WidgetSecurity, 
                      dbo.CMS_Widget.WidgetForGroup,dbo.CMS_Widget.WidgetForInline, dbo.CMS_Widget.WidgetForEditor, dbo.CMS_Widget.WidgetForUser, dbo.CMS_Widget.WidgetForDashboard, dbo.CMS_Widget.WidgetGUID, 
                      dbo.CMS_Widget.WidgetLastModified, dbo.CMS_Widget.WidgetIsEnabled, WidgetsMetaFiles.MetaFileGUID
FROM         dbo.CMS_Widget LEFT OUTER JOIN
                          (SELECT     MetaFileGUID, MetaFileObjectID
                            FROM          dbo.CMS_MetaFile
                            WHERE      (MetaFileObjectType = 'cms.widget')) AS WidgetsMetaFiles ON dbo.CMS_Widget.WidgetID = WidgetsMetaFiles.MetaFileObjectID
GO
