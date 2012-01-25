CREATE VIEW [View_Integration_Task_Joined]
AS
SELECT     dbo.Integration_Synchronization.SynchronizationID, dbo.Integration_Synchronization.SynchronizationTaskID, 
                      dbo.Integration_Synchronization.SynchronizationConnectorID, dbo.Integration_Synchronization.SynchronizationLastRun, 
                      dbo.Integration_Synchronization.SynchronizationErrorMessage, dbo.Integration_Synchronization.SynchronizationIsRunning, dbo.Integration_Connector.ConnectorID, dbo.Integration_Connector.ConnectorName, 
                      dbo.Integration_Connector.ConnectorDisplayName, dbo.Integration_Connector.ConnectorAssemblyName, dbo.Integration_Connector.ConnectorClassName, 
                      dbo.Integration_Connector.ConnectorEnabled, dbo.Integration_Connector.ConnectorLastModified, dbo.Integration_Task.*
FROM         dbo.Integration_Synchronization RIGHT OUTER JOIN
                      dbo.Integration_Task ON dbo.Integration_Synchronization.SynchronizationTaskID = dbo.Integration_Task.TaskID INNER JOIN
                      dbo.Integration_Connector ON dbo.Integration_Synchronization.SynchronizationConnectorID = dbo.Integration_Connector.ConnectorID
GO
