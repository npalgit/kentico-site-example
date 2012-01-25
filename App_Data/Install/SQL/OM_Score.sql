CREATE TABLE [OM_Score] (
		[ScoreID]                    [int] IDENTITY(1, 1) NOT NULL,
		[ScoreName]                  [nvarchar](200) NOT NULL,
		[ScoreDisplayName]           [nvarchar](200) NOT NULL,
		[ScoreDescription]           [nvarchar](max) NULL,
		[ScoreSiteID]                [int] NOT NULL,
		[ScoreEnabled]               [bit] NOT NULL,
		[ScoreEmailAtScore]          [int] NULL,
		[ScoreNotificationEmail]     [nvarchar](250) NULL,
		[ScoreLastModified]          [datetime] NOT NULL,
		[ScoreGUID]                  [uniqueidentifier] NOT NULL,
		[ScoreStatus]                [int] NULL,
		[ScoreScheduledTaskID]       [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [OM_Score]
	ADD
	CONSTRAINT [PK_OM_Score]
	PRIMARY KEY
	CLUSTERED
	([ScoreID])
	ON [PRIMARY]
ALTER TABLE [OM_Score]
	WITH CHECK
	ADD CONSTRAINT [FK_OM_Score_CMS_Site]
	FOREIGN KEY ([ScoreSiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [OM_Score]
	CHECK CONSTRAINT [FK_OM_Score_CMS_Site]
