CREATE VIEW [View_CMS_DocumentAlias_Joined]
AS
SELECT     dbo.CMS_Tree.NodeAliasPath, dbo.CMS_DocumentAlias.AliasNodeID, dbo.CMS_DocumentAlias.AliasCulture, dbo.CMS_DocumentAlias.AliasURLPath, 
                      dbo.CMS_DocumentAlias.AliasSiteID
FROM         dbo.CMS_DocumentAlias INNER JOIN
                      dbo.CMS_Tree ON dbo.CMS_DocumentAlias.AliasNodeID = dbo.CMS_Tree.NodeID
GO
