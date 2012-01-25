CREATE VIEW [View_Forums_GroupForumPost_Joined]
AS
SELECT     dbo.Forums_Forum.ForumID, dbo.Forums_Forum.ForumGroupID, dbo.Forums_Forum.ForumName, dbo.Forums_Forum.ForumDisplayName, 
                      dbo.Forums_Forum.ForumDescription, dbo.Forums_Forum.ForumOrder, dbo.Forums_Forum.ForumDocumentID, dbo.Forums_Forum.ForumOpen, 
                      dbo.Forums_Forum.ForumModerated, dbo.Forums_Forum.ForumDisplayEmails, dbo.Forums_Forum.ForumRequireEmail, dbo.Forums_Forum.ForumAccess, 
                      dbo.Forums_Forum.ForumThreads, dbo.Forums_Forum.ForumPosts, dbo.Forums_Forum.ForumLastPostTime, dbo.Forums_Forum.ForumLastPostUserName, 
                      dbo.Forums_Forum.ForumBaseUrl, dbo.Forums_Forum.ForumAllowChangeName, dbo.Forums_Forum.ForumHTMLEditor, dbo.Forums_Forum.ForumUseCAPTCHA, 
                      dbo.Forums_Forum.ForumGUID, dbo.Forums_Forum.ForumLastModified, dbo.Forums_Forum.ForumUnsubscriptionUrl, dbo.Forums_Forum.ForumIsLocked, 
                      dbo.Forums_Forum.ForumSettings, dbo.Forums_Forum.ForumAuthorEdit, dbo.Forums_Forum.ForumAuthorDelete, dbo.Forums_Forum.ForumType, 
                      dbo.Forums_Forum.ForumIsAnswerLimit, dbo.Forums_Forum.ForumImageMaxSideSize, dbo.Forums_Forum.ForumLastPostTimeAbsolute, 
                      dbo.Forums_Forum.ForumLastPostUserNameAbsolute, dbo.Forums_Forum.ForumPostsAbsolute, dbo.Forums_Forum.ForumThreadsAbsolute, 
                      dbo.Forums_Forum.ForumAttachmentMaxFileSize, dbo.Forums_Forum.ForumDiscussionActions, dbo.Forums_Forum.ForumSiteID, dbo.Forums_ForumGroup.GroupID, 
                      dbo.Forums_ForumGroup.GroupSiteID, dbo.Forums_ForumGroup.GroupName, dbo.Forums_ForumGroup.GroupDisplayName, dbo.Forums_ForumGroup.GroupOrder, 
                      dbo.Forums_ForumGroup.GroupDescription, dbo.Forums_ForumGroup.GroupGUID, dbo.Forums_ForumGroup.GroupLastModified, 
                      dbo.Forums_ForumGroup.GroupBaseUrl, dbo.Forums_ForumGroup.GroupUnsubscriptionUrl, dbo.Forums_ForumGroup.GroupGroupID, 
                      dbo.Forums_ForumGroup.GroupAuthorEdit, dbo.Forums_ForumGroup.GroupAuthorDelete, dbo.Forums_ForumGroup.GroupType, 
                      dbo.Forums_ForumGroup.GroupIsAnswerLimit, dbo.Forums_ForumGroup.GroupImageMaxSideSize, dbo.Forums_ForumGroup.GroupDisplayEmails, 
                      dbo.Forums_ForumGroup.GroupRequireEmail, dbo.Forums_ForumGroup.GroupHTMLEditor, dbo.Forums_ForumGroup.GroupUseCAPTCHA, 
                      dbo.Forums_ForumGroup.GroupAttachmentMaxFileSize, dbo.Forums_ForumGroup.GroupDiscussionActions, dbo.Forums_ForumPost.PostId, 
                      dbo.Forums_ForumPost.PostForumID, dbo.Forums_ForumPost.PostParentID, dbo.Forums_ForumPost.PostIDPath, dbo.Forums_ForumPost.PostLevel, 
                      dbo.Forums_ForumPost.PostSubject, dbo.Forums_ForumPost.PostUserID, dbo.Forums_ForumPost.PostUserName, dbo.Forums_ForumPost.PostUserMail, 
                      dbo.Forums_ForumPost.PostText, dbo.Forums_ForumPost.PostTime, dbo.Forums_ForumPost.PostApprovedByUserID, dbo.Forums_ForumPost.PostThreadPosts, 
                      dbo.Forums_ForumPost.PostThreadLastPostUserName, dbo.Forums_ForumPost.PostThreadLastPostTime, dbo.Forums_ForumPost.PostUserSignature, 
                      dbo.Forums_ForumPost.PostGUID, dbo.Forums_ForumPost.PostLastModified, dbo.Forums_ForumPost.PostApproved, dbo.Forums_ForumPost.PostIsLocked, 
                      dbo.Forums_ForumPost.PostIsAnswer, dbo.Forums_ForumPost.PostStickOrder, dbo.Forums_ForumPost.PostViews, dbo.Forums_ForumPost.PostLastEdit, 
                      dbo.Forums_ForumPost.PostInfo, dbo.Forums_ForumPost.PostAttachmentCount, dbo.Forums_ForumPost.PostType, 
                      dbo.Forums_ForumPost.PostThreadPostsAbsolute, dbo.Forums_ForumPost.PostThreadLastPostUserNameAbsolute, 
                      dbo.Forums_ForumPost.PostThreadLastPostTimeAbsolute, dbo.Forums_ForumPost.PostQuestionSolved, dbo.Forums_ForumPost.PostIsNotAnswer
FROM         dbo.Forums_ForumPost LEFT OUTER JOIN
                      dbo.Forums_Forum ON dbo.Forums_ForumPost.PostForumID = dbo.Forums_Forum.ForumID LEFT OUTER JOIN
                      dbo.Forums_ForumGroup ON dbo.Forums_Forum.ForumGroupID = dbo.Forums_ForumGroup.GroupID
GO
