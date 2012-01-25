CREATE TABLE [Analytics_DayHits] (
		[HitsID]               [int] IDENTITY(1, 1) NOT NULL,
		[HitsStatisticsID]     [int] NOT NULL,
		[HitsStartTime]        [datetime] NOT NULL,
		[HitsEndTime]          [datetime] NOT NULL,
		[HitsCount]            [int] NOT NULL,
		[HitsValue]            [float] NULL
) ON [PRIMARY]
ALTER TABLE [Analytics_DayHits]
	ADD
	CONSTRAINT [PK_Analytics_DayHits]
	PRIMARY KEY
	NONCLUSTERED
	([HitsID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Analytics_DayHits_HitsStartTime_HitsEndTime]
	ON [Analytics_DayHits] ([HitsStartTime] DESC, [HitsEndTime] DESC)
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Analytics_DayHits_HitsStatisticsID]
	ON [Analytics_DayHits] ([HitsStatisticsID])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Analytics_DayHits]
	WITH CHECK
	ADD CONSTRAINT [FK_Analytics_DayHits_HitsStatisticsID_Analytics_Statistics]
	FOREIGN KEY ([HitsStatisticsID]) REFERENCES [Analytics_Statistics] ([StatisticsID])
ALTER TABLE [Analytics_DayHits]
	CHECK CONSTRAINT [FK_Analytics_DayHits_HitsStatisticsID_Analytics_Statistics]
