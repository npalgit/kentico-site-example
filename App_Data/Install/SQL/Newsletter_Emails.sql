CREATE TABLE [Newsletter_Emails] (
		[EmailID]                    [int] IDENTITY(1, 1) NOT NULL,
		[EmailNewsletterIssueID]     [int] NOT NULL,
		[EmailSubscriberID]          [int] NOT NULL,
		[EmailSiteID]                [int] NOT NULL,
		[EmailLastSendResult]        [nvarchar](max) NULL,
		[EmailLastSendAttempt]       [datetime] NULL,
		[EmailSending]               [bit] NULL,
		[EmailGUID]                  [uniqueidentifier] NOT NULL,
		[EmailLastModified]          [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Newsletter_Emails]
	ADD
	CONSTRAINT [PK_Newsletter_Emails]
	PRIMARY KEY
	CLUSTERED
	([EmailID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [Newsletter_Emails]
	ADD
	CONSTRAINT [DEFAULT_Newsletter_Emails_EmailSiteID]
	DEFAULT ((0)) FOR [EmailSiteID]
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailNewsletterIssueID]
	ON [Newsletter_Emails] ([EmailNewsletterIssueID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailSending]
	ON [Newsletter_Emails] ([EmailSending])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailSiteID]
	ON [Newsletter_Emails] ([EmailSiteID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Newsletter_Emails_EmailSubscriberID]
	ON [Newsletter_Emails] ([EmailSubscriberID])
	ON [PRIMARY]
ALTER TABLE [Newsletter_Emails]
	WITH CHECK
	ADD CONSTRAINT [FK_Newsletter_Emails_EmailNewsletterIssueID_Newsletter_NewsletterIssue]
	FOREIGN KEY ([EmailNewsletterIssueID]) REFERENCES [Newsletter_NewsletterIssue] ([IssueID])
ALTER TABLE [Newsletter_Emails]
	CHECK CONSTRAINT [FK_Newsletter_Emails_EmailNewsletterIssueID_Newsletter_NewsletterIssue]
ALTER TABLE [Newsletter_Emails]
	WITH CHECK
	ADD CONSTRAINT [FK_Newsletter_Emails_EmailSiteID_CMS_Site]
	FOREIGN KEY ([EmailSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [Newsletter_Emails]
	CHECK CONSTRAINT [FK_Newsletter_Emails_EmailSiteID_CMS_Site]
ALTER TABLE [Newsletter_Emails]
	WITH CHECK
	ADD CONSTRAINT [FK_Newsletter_Emails_EmailSubscriberID_Newsletter_Subscriber]
	FOREIGN KEY ([EmailSubscriberID]) REFERENCES [Newsletter_Subscriber] ([SubscriberID])
ALTER TABLE [Newsletter_Emails]
	CHECK CONSTRAINT [FK_Newsletter_Emails_EmailSubscriberID_Newsletter_Subscriber]
