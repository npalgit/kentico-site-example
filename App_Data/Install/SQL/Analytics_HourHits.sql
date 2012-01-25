CREATE TABLE [Analytics_HourHits] (
		[HitsID]               [int] IDENTITY(1, 1) NOT NULL,
		[HitsStatisticsID]     [int] NOT NULL,
		[HitsStartTime]        [datetime] NOT NULL,
		[HitsEndTime]          [datetime] NOT NULL,
		[HitsCount]            [int] NOT NULL,
		[HitsValue]            [float] NULL
) ON [PRIMARY]
ALTER TABLE [Analytics_HourHits]
	ADD
	CONSTRAINT [PK_Analytics_HourHits]
	PRIMARY KEY
	NONCLUSTERED
	([HitsID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Analytics_HourHits_HitsStartTime_HitsEndTime]
	ON [Analytics_HourHits] ([HitsStartTime] DESC, [HitsEndTime] DESC)
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Analytics_HourHits_HitsStatisticsID]
	ON [Analytics_HourHits] ([HitsStatisticsID])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Analytics_HourHits]
	WITH CHECK
	ADD CONSTRAINT [FK_Analytics_HourHits_HitsStatisticsID_Analytics_Statistics]
	FOREIGN KEY ([HitsStatisticsID]) REFERENCES [Analytics_Statistics] ([StatisticsID])
ALTER TABLE [Analytics_HourHits]
	CHECK CONSTRAINT [FK_Analytics_HourHits_HitsStatisticsID_Analytics_Statistics]
