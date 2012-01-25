CREATE TABLE [Analytics_Index] (
		[IndexID]            [int] IDENTITY(1, 1) NOT NULL,
		[IndexZero]          [int] NULL,
		[IndexMonthName]     [nvarchar](50) NULL,
		[IndexDayName]       [nvarchar](50) NULL
) ON [PRIMARY]
ALTER TABLE [Analytics_Index]
	ADD
	CONSTRAINT [PK_Analytics_Index]
	PRIMARY KEY
	NONCLUSTERED
	([IndexID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_Analytics_Index_All]
	ON [Analytics_Index] ([IndexID], [IndexZero], [IndexMonthName], [IndexDayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
