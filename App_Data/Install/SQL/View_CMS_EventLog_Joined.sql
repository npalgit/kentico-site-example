CREATE VIEW [View_CMS_EventLog_Joined]
AS
SELECT     dbo.CMS_EventLog.EventID, dbo.CMS_EventLog.EventType, dbo.CMS_EventLog.EventTime, dbo.CMS_EventLog.Source, 
                      dbo.CMS_EventLog.EventCode, dbo.CMS_EventLog.UserID, dbo.CMS_EventLog.UserName, dbo.CMS_EventLog.IPAddress, 
                      dbo.CMS_EventLog.NodeID, dbo.CMS_EventLog.DocumentName, dbo.CMS_EventLog.EventDescription, dbo.CMS_EventLog.SiteID, 
                      dbo.CMS_EventLog.EventUrl, dbo.CMS_EventLog.EventMachineName, dbo.CMS_Site.SiteDisplayName, dbo.CMS_EventLog.EventUserAgent, 
                      dbo.CMS_EventLog.EventUrlReferrer
FROM         dbo.CMS_EventLog LEFT OUTER JOIN
                      dbo.CMS_Site ON dbo.CMS_EventLog.SiteID = dbo.CMS_Site.SiteID
GO
