CREATE TABLE [Messaging_IgnoreList] (
		[IgnoreListUserID]            [int] NOT NULL,
		[IgnoreListIgnoredUserID]     [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [Messaging_IgnoreList]
	ADD
	CONSTRAINT [PK_Messaging_IgnoreList]
	PRIMARY KEY
	CLUSTERED
	([IgnoreListUserID], [IgnoreListIgnoredUserID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [Messaging_IgnoreList]
	WITH CHECK
	ADD CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListIgnoredUserID_CMS_User]
	FOREIGN KEY ([IgnoreListIgnoredUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [Messaging_IgnoreList]
	CHECK CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListIgnoredUserID_CMS_User]
ALTER TABLE [Messaging_IgnoreList]
	WITH CHECK
	ADD CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListUserID_CMS_User]
	FOREIGN KEY ([IgnoreListUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [Messaging_IgnoreList]
	CHECK CONSTRAINT [FK_Messaging_IgnoreList_IgnoreListUserID_CMS_User]
