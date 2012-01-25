CREATE VIEW [View_CMS_PageTemplateMetafile_Joined]
AS
SELECT     dbo.CMS_PageTemplate.PageTemplateID, dbo.CMS_PageTemplate.PageTemplateDisplayName, dbo.CMS_PageTemplate.PageTemplateCodeName, 
                      dbo.CMS_PageTemplate.PageTemplateDescription, dbo.CMS_PageTemplate.PageTemplateFile, dbo.CMS_PageTemplate.PageTemplateIsPortal, 
                      dbo.CMS_PageTemplate.PageTemplateCategoryID, dbo.CMS_PageTemplate.PageTemplateLayoutID, dbo.CMS_PageTemplate.PageTemplateWebParts, 
                      dbo.CMS_PageTemplate.PageTemplateIsReusable, dbo.CMS_PageTemplate.PageTemplateShowAsMasterTemplate, 
                      dbo.CMS_PageTemplate.PageTemplateInheritPageLevels, dbo.CMS_PageTemplate.PageTemplateLayout, 
                      dbo.CMS_PageTemplate.PageTemplateLayoutCheckedOutFileName, dbo.CMS_PageTemplate.PageTemplateLayoutCheckedOutByUserID, 
                      dbo.CMS_PageTemplate.PageTemplateLayoutCheckedOutMachineName, dbo.CMS_PageTemplate.PageTemplateVersionGUID, 
                      dbo.CMS_PageTemplate.PageTemplateHeader, dbo.CMS_PageTemplate.PageTemplateGUID, dbo.CMS_PageTemplate.PageTemplateLastModified, 
                      dbo.CMS_PageTemplate.PageTemplateSiteID, dbo.CMS_PageTemplate.PageTemplateForAllPages, TemplatesMetaFiles.MetaFileGUID, 
                      dbo.CMS_PageTemplate.PageTemplateType, dbo.CMS_PageTemplate.PageTemplateLayoutType
FROM         dbo.CMS_PageTemplate LEFT OUTER JOIN
                          (SELECT     MetaFileGUID, MetaFileObjectID
                            FROM          dbo.CMS_MetaFile
                            WHERE      (MetaFileObjectType = 'cms.pagetemplate')) AS TemplatesMetaFiles ON 
                      dbo.CMS_PageTemplate.PageTemplateID = TemplatesMetaFiles.MetaFileObjectID
GO
