CREATE VIEW [View_PM_ProjectTaskStatus_Joined]
AS
SELECT     dbo.PM_ProjectTask.ProjectTaskID, dbo.PM_ProjectTask.ProjectTaskDisplayName, tblAssignee.FullName AS AssigneeFullName, 
                      tblAssignee.UserName AS AssigneeUserName, tblOwner.FullName AS OwnerFullName, tblOwner.UserName AS OwnerUserName, 
                      dbo.PM_ProjectTaskPriority.TaskPriorityDisplayName, dbo.PM_ProjectTaskStatus.TaskStatusDisplayName, dbo.PM_ProjectTask.ProjectTaskHours, 
                      dbo.PM_ProjectTask.ProjectTaskProgress, dbo.PM_ProjectTask.ProjectTaskProjectID, dbo.PM_ProjectTaskStatus.TaskStatusColor, 
                      dbo.PM_ProjectTask.ProjectTaskProjectOrder, dbo.PM_ProjectTask.ProjectTaskUserOrder, dbo.PM_ProjectTaskStatus.TaskStatusIcon, 
                      dbo.PM_ProjectTask.ProjectTaskAssignedToUserID, dbo.PM_ProjectTask.ProjectTaskOwnerID, dbo.PM_ProjectTask.ProjectTaskDeadline, 
                      dbo.PM_ProjectTask.ProjectTaskIsPrivate, dbo.PM_Project.ProjectDisplayName, dbo.PM_ProjectTaskStatus.TaskStatusIsFinished, 
                      dbo.PM_ProjectTaskPriority.TaskPriorityOrder, dbo.PM_Project.ProjectSiteID, dbo.PM_Project.ProjectOwner, dbo.PM_Project.ProjectGroupID, 
                      dbo.PM_Project.ProjectAccess, dbo.PM_Project.ProjectID
FROM         dbo.PM_ProjectTask LEFT OUTER JOIN
                      dbo.PM_ProjectTaskStatus ON dbo.PM_ProjectTaskStatus.TaskStatusID = dbo.PM_ProjectTask.ProjectTaskStatusID LEFT OUTER JOIN
                      dbo.PM_ProjectTaskPriority ON dbo.PM_ProjectTask.ProjectTaskPriorityID = dbo.PM_ProjectTaskPriority.TaskPriorityID LEFT OUTER JOIN
                      dbo.PM_Project ON dbo.PM_ProjectTask.ProjectTaskProjectID = dbo.PM_Project.ProjectID LEFT OUTER JOIN
                      dbo.CMS_User AS tblAssignee ON dbo.PM_ProjectTask.ProjectTaskAssignedToUserID = tblAssignee.UserID LEFT OUTER JOIN
                      dbo.CMS_User AS tblOwner ON dbo.PM_ProjectTask.ProjectTaskOwnerID = tblOwner.UserID
GO
