CREATE VIEW [View_CMS_ACLItem_ItemsAndOperators]
AS
SELECT     dbo.CMS_ACL.ACLOwnerNodeID, dbo.CMS_ACLItem.ACLItemID, dbo.CMS_ACLItem.Allowed, dbo.CMS_ACLItem.Denied, 
                      CASE WHEN CMS_ACLItem.UserID IS NULL THEN 'R' + CAST(CMS_ACLItem.RoleID AS nvarchar(50)) 
                      ELSE 'U' + CAST(CMS_ACLItem.UserID AS nvarchar(50)) END AS Operator, CASE WHEN CMS_ACLItem.UserID IS NULL 
                      THEN CMS_Role.RoleDisplayName ELSE CMS_User.UserName END AS OperatorName, dbo.CMS_ACLItem.ACLID, 
                      CASE WHEN CMS_ACLItem.UserID IS NULL THEN NULL ELSE CMS_User.FullName END AS OperatorFullName,
                      CMS_ACLItem.UserID,CMS_ACLItem.RoleID, CASE WHEN CMS_ACLItem.RoleID IS NULL THEN NULL ELSE CMS_Role.RoleGroupID END AS RoleGroupID, 
                      CASE WHEN CMS_ACLItem.RoleID IS NULL THEN NULL ELSE CMS_Role.SiteID END AS SiteID
FROM         dbo.CMS_ACL INNER JOIN
                      dbo.CMS_ACLItem ON dbo.CMS_ACLItem.ACLID = dbo.CMS_ACL.ACLID LEFT OUTER JOIN
                      dbo.CMS_User ON dbo.CMS_ACLItem.UserID = dbo.CMS_User.UserID LEFT OUTER JOIN
                      dbo.CMS_Role ON dbo.CMS_ACLItem.RoleID = dbo.CMS_Role.RoleID
GO
