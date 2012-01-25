CREATE VIEW [View_Poll_AnswerCount]
AS
SELECT     PollID, PollCodeName, PollDisplayName, PollTitle, PollOpenFrom, PollOpenTo, PollAllowMultipleAnswers, PollQuestion, PollAccess, PollResponseMessage, 
                      PollGUID, PollLastModified, PollGroupID, PollSiteID,
                          (SELECT     SUM(AnswerCount) AS AnswerCount
                            FROM          dbo.Polls_PollAnswer
                            WHERE      (AnswerPollID = dbo.Polls_Poll.PollID)) AS AnswerCount
FROM         dbo.Polls_Poll
GO
