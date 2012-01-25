CREATE VIEW [View_CMS_SiteRoleResourceUIElement_Joined]
AS
SELECT     dbo.CMS_Role.RoleName, dbo.CMS_Role.RoleID, dbo.CMS_UIElement.ElementName, dbo.CMS_Site.SiteName, 
                      dbo.CMS_Resource.ResourceName, dbo.CMS_Role.SiteID AS 'RoleSiteID'
FROM         dbo.CMS_Role INNER JOIN
                      dbo.CMS_RoleUIElement ON dbo.CMS_Role.RoleID = dbo.CMS_RoleUIElement.RoleID LEFT JOIN
                      dbo.CMS_Site ON (dbo.CMS_Role.SiteID = dbo.CMS_Site.SiteID) INNER JOIN
                      dbo.CMS_UIElement ON dbo.CMS_RoleUIElement.ElementID = dbo.CMS_UIElement.ElementID INNER JOIN
                      dbo.CMS_Resource ON dbo.CMS_UIElement.ElementResourceID = dbo.CMS_Resource.ResourceID
GO
