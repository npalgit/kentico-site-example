CREATE VIEW [View_PageInfo_Blank]
AS
SELECT     dbo.CMS_Tree.NodeID, dbo.CMS_Tree.NodeAliasPath, dbo.CMS_Tree.NodeName, dbo.CMS_Tree.NodeAlias, dbo.CMS_Tree.NodeClassID, 
                      dbo.CMS_Tree.NodeParentID, dbo.CMS_Tree.NodeLevel, dbo.CMS_Tree.NodeACLID, dbo.CMS_Tree.NodeSiteID, dbo.CMS_Tree.NodeGUID, 
                      dbo.CMS_Tree.NodeOrder, dbo.CMS_Document.DocumentID, dbo.CMS_Document.DocumentName, dbo.CMS_Document.DocumentNamePath, 
                      dbo.CMS_Document.DocumentPublishFrom, dbo.CMS_Document.DocumentPublishTo, dbo.CMS_Document.DocumentUrlPath, 
                      dbo.CMS_Document.DocumentCulture, dbo.CMS_Document.DocumentPageTitle, dbo.CMS_Document.DocumentPageKeyWords, 
                      dbo.CMS_Document.DocumentPageDescription, dbo.CMS_Document.DocumentMenuCaption, dbo.CMS_Document.DocumentPageTemplateID, 
                      dbo.CMS_Class.ClassName, dbo.CMS_Document.DocumentContent, dbo.CMS_Document.DocumentStylesheetID, dbo.CMS_Tree.IsSecuredNode, 
                      dbo.CMS_Document.DocumentMenuRedirectUrl, dbo.CMS_Document.DocumentMenuJavascript, dbo.CMS_Tree.NodeCacheMinutes, 
                      dbo.CMS_Tree.NodeSKUID, dbo.CMS_Tree.NodeDocType, dbo.CMS_Tree.NodeHeadTags, dbo.CMS_Tree.NodeInheritPageLevels, 
                      dbo.CMS_Document.DocumentMenuItemInactive, dbo.CMS_Document.DocumentMenuClass, dbo.CMS_Document.DocumentMenuStyle, 
                      dbo.CMS_Document.DocumentMenuItemHideInNavigation, dbo.CMS_Tree.NodeChildNodesCount, dbo.CMS_Tree.NodeBodyElementAttributes, 
                      dbo.CMS_Tree.RequiresSSL, dbo.CMS_Tree.NodeLinkedNodeID, dbo.CMS_Tree.NodeOwner, 
                      dbo.CMS_Document.DocumentCheckedOutVersionHistoryID, dbo.CMS_Document.DocumentPublishedVersionHistoryID, 
                      dbo.CMS_Document.DocumentWorkflowStepID, dbo.CMS_WorkflowStep.StepName, dbo.CMS_Document.DocumentExtensions, 
                      dbo.CMS_Document.DocumentCampaign, dbo.CMS_Tree.NodeGroupID, dbo.CMS_Document.DocumentWebParts, 
                      dbo.CMS_Document.DocumentGroupWebParts,CMS_Document.DocumentTrackConversionName,CMS_Document.DocumentConversionValue, CMS_Tree.NodeLinkedNodeSiteID, CMS_Document.DocumentWorkflowCycleGUID, CMS_Document.DocumentGUID
FROM         dbo.CMS_WorkflowStep INNER JOIN
                      dbo.CMS_Document ON dbo.CMS_WorkflowStep.StepID = dbo.CMS_Document.DocumentWorkflowStepID RIGHT OUTER JOIN
                      dbo.CMS_Tree INNER JOIN
                      dbo.CMS_Class ON dbo.CMS_Tree.NodeClassID = dbo.CMS_Class.ClassID ON 1 = 0
GO
