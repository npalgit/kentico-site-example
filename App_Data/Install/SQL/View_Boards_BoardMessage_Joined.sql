CREATE VIEW [View_Boards_BoardMessage_Joined]
AS
SELECT     dbo.Board_Board.BoardID, dbo.Board_Board.BoardName, dbo.Board_Board.BoardDisplayName, dbo.Board_Board.BoardDescription, 
                      dbo.Board_Board.BoardOpenedFrom, dbo.Board_Board.BoardOpened, dbo.Board_Board.BoardOpenedTo, dbo.Board_Board.BoardEnabled, 
                      dbo.Board_Board.BoardModerated, dbo.Board_Board.BoardAccess, dbo.Board_Board.BoardUseCaptcha, dbo.Board_Board.BoardLastModified, 
                      dbo.Board_Board.BoardMessages, dbo.Board_Board.BoardDocumentID, dbo.Board_Board.BoardGUID, dbo.Board_Board.BoardUserID, 
                      dbo.Board_Board.BoardGroupID, dbo.Board_Board.BoardLastMessageTime, dbo.Board_Board.BoardLastMessageUserName, 
                      dbo.Board_Board.BoardUnsubscriptionURL, dbo.Board_Board.BoardRequireEmails, dbo.Board_Board.BoardSiteID, 
                      dbo.Board_Board.BoardEnableSubscriptions, dbo.Board_Board.BoardBaseURL, dbo.Board_Message.MessageID, 
                      dbo.Board_Message.MessageUserName, dbo.Board_Message.MessageText, dbo.Board_Message.MessageEmail, 
                      dbo.Board_Message.MessageURL, dbo.Board_Message.MessageIsSpam, dbo.Board_Message.MessageBoardID, 
                      dbo.Board_Message.MessageApproved, dbo.Board_Message.MessageUserID, dbo.Board_Message.MessageApprovedByUserID, 
                      dbo.Board_Message.MessageUserInfo, dbo.Board_Message.MessageAvatarGUID, dbo.Board_Message.MessageInserted, 
                      dbo.Board_Message.MessageLastModified, dbo.Board_Message.MessageGUID, dbo.Board_Message.MessageRatingValue, 
                      dbo.Community_Group.GroupID, dbo.Community_Group.GroupGUID, dbo.Community_Group.GroupLastModified, dbo.Community_Group.GroupSiteID, 
                      dbo.Community_Group.GroupDisplayName, dbo.Community_Group.GroupName, dbo.Community_Group.GroupDescription, 
                      dbo.Community_Group.GroupNodeGUID, dbo.Community_Group.GroupApproveMembers, dbo.Community_Group.GroupAccess, 
                      dbo.Community_Group.GroupCreatedByUserID, dbo.Community_Group.GroupApprovedByUserID, dbo.Community_Group.GroupAvatarID, 
                      dbo.Community_Group.GroupApproved, dbo.Community_Group.GroupCreatedWhen, dbo.Community_Group.GroupSendJoinLeaveNotification, 
                      dbo.Community_Group.GroupSendWaitingForApprovalNotification, dbo.Community_Group.GroupSecurity
FROM         dbo.Board_Board INNER JOIN
                      dbo.Board_Message ON dbo.Board_Board.BoardID = dbo.Board_Message.MessageBoardID LEFT OUTER JOIN
                      dbo.Community_Group ON dbo.Board_Board.BoardGroupID = dbo.Community_Group.GroupID
GO
