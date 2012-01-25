CREATE VIEW [View_CMS_Site_DocumentCount]
AS
SELECT     SiteID, SiteName, SiteDisplayName, SiteDescription, SiteStatus, SiteDomainName, SiteDefaultStylesheetID, SiteDefaultVisitorCulture, SiteDefaultEditorStylesheet, 
                      SiteGUID, SiteLastModified,
                          (SELECT     COUNT(*) AS Documents
                            FROM          dbo.CMS_Tree
                            WHERE      (NodeSiteID = dbo.CMS_Site.SiteID)) AS Documents, SiteIsOffline
FROM         dbo.CMS_Site
GO
