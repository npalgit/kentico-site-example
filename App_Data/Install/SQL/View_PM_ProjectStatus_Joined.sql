CREATE VIEW [View_PM_ProjectStatus_Joined]
AS
SELECT     dbo.PM_Project.ProjectID, dbo.PM_Project.ProjectDisplayName, dbo.PM_Project.ProjectDeadline, dbo.CMS_User.FullName AS ProjectOwnerFullName, 
                      dbo.CMS_User.UserName AS ProjectOwnerUserName, dbo.PM_ProjectStatus.StatusDisplayName AS ProjectStatus, 
                      dbo.PM_ProjectStatus.StatusColor AS ProjectStatusColor, dbo.PM_Project.ProjectDescription, dbo.PM_ProjectStatus.StatusIcon AS ProjectStatusIcon, 
                      dbo.PM_Project.ProjectNodeID, dbo.PM_Project.ProjectGroupID, dbo.PM_ProjectStatus.StatusIsFinished, dbo.PM_Project.ProjectOwner, dbo.PM_Project.ProjectSiteID, 
                      dbo.PM_Project.ProjectAccess, dbo.CMS_Tree.NodeAliasPath, COALESCE (tasks.ProjectProgress, 0) AS ProjectProgress, dbo.PM_Project.ProjectCreatedByID, 
                      ProjectCreator.FullName AS ProjectCreatedFullName, ProjectCreator.UserName AS ProjectCreatedUserName
FROM         dbo.PM_Project LEFT OUTER JOIN
                      dbo.PM_ProjectStatus ON dbo.PM_Project.ProjectStatusID = dbo.PM_ProjectStatus.StatusID LEFT OUTER JOIN
                      dbo.CMS_User ON dbo.PM_Project.ProjectOwner = dbo.CMS_User.UserID LEFT OUTER JOIN
                      dbo.CMS_User AS ProjectCreator ON dbo.PM_Project.ProjectCreatedByID = ProjectCreator.UserID LEFT OUTER JOIN
                      dbo.CMS_Tree ON dbo.PM_Project.ProjectNodeID = dbo.CMS_Tree.NodeID LEFT OUTER JOIN
                          (SELECT     ProjectTaskProjectID, ROUND(SUM(ProjectTaskHours * ProjectTaskProgress) / SUM(ProjectTaskHours), 0, 1) AS ProjectProgress
                            FROM          (SELECT     ProjectTaskProjectID, ProjectTaskProgress, 
                                                                           CASE WHEN ProjectTaskHours = 0 THEN 1 ELSE ProjectTaskHours END AS ProjectTaskHours
                                                    FROM          dbo.PM_ProjectTask) AS modifiedTasks
                            GROUP BY ProjectTaskProjectID) AS tasks ON dbo.PM_Project.ProjectID = tasks.ProjectTaskProjectID
GO
