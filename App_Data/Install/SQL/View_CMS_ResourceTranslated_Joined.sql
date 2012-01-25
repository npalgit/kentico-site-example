CREATE VIEW [View_CMS_ResourceTranslated_Joined]
AS
SELECT     dbo.CMS_ResourceString.StringID, dbo.CMS_ResourceString.StringKey, dbo.CMS_ResourceTranslation.TranslationText, dbo.CMS_UICulture.UICultureID, 
                      dbo.CMS_UICulture.UICultureName, dbo.CMS_UICulture.UICultureCode
FROM         dbo.CMS_ResourceString CROSS JOIN
                      dbo.CMS_UICulture LEFT OUTER JOIN
                      dbo.CMS_ResourceTranslation ON dbo.CMS_ResourceString.StringID = dbo.CMS_ResourceTranslation.TranslationStringID AND 
                      dbo.CMS_ResourceTranslation.TranslationUICultureID = dbo.CMS_UICulture.UICultureID
GO
