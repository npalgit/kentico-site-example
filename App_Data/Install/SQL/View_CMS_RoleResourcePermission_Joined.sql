CREATE VIEW [View_CMS_RoleResourcePermission_Joined]
AS
SELECT     dbo.CMS_RolePermission.RoleID, dbo.CMS_Resource.ResourceName, dbo.CMS_Permission.PermissionName
FROM         dbo.CMS_RolePermission INNER JOIN
                      dbo.CMS_Permission ON dbo.CMS_Permission.PermissionID = dbo.CMS_RolePermission.PermissionID INNER JOIN
                      dbo.CMS_Resource ON dbo.CMS_Permission.ResourceID = dbo.CMS_Resource.ResourceID
GO
