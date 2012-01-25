CREATE VIEW [View_Community_Friend_Friends]
AS
SELECT     dbo.Community_Friend.FriendID, dbo.Community_Friend.FriendRequestedUserID, dbo.Community_Friend.FriendUserID, 
                      dbo.Community_Friend.FriendRequestedWhen, dbo.Community_Friend.FriendComment, dbo.Community_Friend.FriendApprovedBy, 
                      dbo.Community_Friend.FriendApprovedWhen, dbo.Community_Friend.FriendRejectedBy, dbo.Community_Friend.FriendRejectedWhen, 
                      dbo.Community_Friend.FriendGUID, dbo.Community_Friend.FriendStatus, dbo.View_CMS_User.*
FROM         dbo.Community_Friend INNER JOIN
                      dbo.View_CMS_User ON dbo.Community_Friend.FriendUserID = dbo.View_CMS_User.UserID
GO
