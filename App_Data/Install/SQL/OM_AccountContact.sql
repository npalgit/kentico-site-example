CREATE TABLE [OM_AccountContact] (
		[AccountContactID]     [int] IDENTITY(1, 1) NOT NULL,
		[ContactRoleID]        [int] NULL,
		[AccountID]            [int] NOT NULL,
		[ContactID]            [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [OM_AccountContact]
	ADD
	CONSTRAINT [PK_OM_AccountContact]
	PRIMARY KEY
	CLUSTERED
	([AccountContactID])
	ON [PRIMARY]
ALTER TABLE [OM_AccountContact]
	ADD
	CONSTRAINT [DEFAULT_OM_AccountContact_OriginalAccountID]
	DEFAULT ((0)) FOR [AccountID]
ALTER TABLE [OM_AccountContact]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_AccountContact_OM_Account]
	FOREIGN KEY ([AccountID]) REFERENCES [OM_Account] ([AccountID])
ALTER TABLE [OM_AccountContact]
	CHECK CONSTRAINT [FK_OM_AccountContact_OM_Account]
ALTER TABLE [OM_AccountContact]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_AccountContact_OM_Contact]
	FOREIGN KEY ([ContactID]) REFERENCES [OM_Contact] ([ContactID])
ALTER TABLE [OM_AccountContact]
	CHECK CONSTRAINT [FK_OM_AccountContact_OM_Contact]
ALTER TABLE [OM_AccountContact]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_AccountContact_OM_ContactRole]
	FOREIGN KEY ([ContactRoleID]) REFERENCES [OM_ContactRole] ([ContactRoleID])
ALTER TABLE [OM_AccountContact]
	CHECK CONSTRAINT [FK_OM_AccountContact_OM_ContactRole]
