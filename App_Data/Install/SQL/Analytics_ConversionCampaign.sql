CREATE TABLE [Analytics_ConversionCampaign] (
		[CampaignID]       [int] NOT NULL,
		[ConversionID]     [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [Analytics_ConversionCampaign]
	ADD
	CONSTRAINT [PK_Analytics_ConversionCampaign]
	PRIMARY KEY
	NONCLUSTERED
	([CampaignID], [ConversionID])
	ON [PRIMARY]
CREATE UNIQUE CLUSTERED INDEX [IX_Analytics_ConversionCampaign]
	ON [Analytics_ConversionCampaign] ([CampaignID], [ConversionID])
	ON [PRIMARY]
