CREATE TABLE [OM_UserAgent] (
		[UserAgentID]                    [int] IDENTITY(1, 1) NOT NULL,
		[UserAgentString]                [nvarchar](250) NOT NULL,
		[UserAgentActiveContactID]       [int] NOT NULL,
		[UserAgentOriginalContactID]     [int] NOT NULL,
		[UserAgentCreated]               [datetime] NOT NULL
) ON [PRIMARY]
ALTER TABLE [OM_UserAgent]
	ADD
	CONSTRAINT [PK_OM_UserAgent]
	PRIMARY KEY
	CLUSTERED
	([UserAgentID])
	ON [PRIMARY]
ALTER TABLE [OM_UserAgent]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_UserAgent_OM_Contact_Active]
	FOREIGN KEY ([UserAgentActiveContactID]) REFERENCES [OM_Contact] ([ContactID])
ALTER TABLE [OM_UserAgent]
	CHECK CONSTRAINT [FK_OM_UserAgent_OM_Contact_Active]
ALTER TABLE [OM_UserAgent]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_UserAgent_OM_Contact_Original]
	FOREIGN KEY ([UserAgentOriginalContactID]) REFERENCES [OM_Contact] ([ContactID])
ALTER TABLE [OM_UserAgent]
	CHECK CONSTRAINT [FK_OM_UserAgent_OM_Contact_Original]
