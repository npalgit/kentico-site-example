CREATE TABLE [Reporting_ReportGraph] (
		[GraphID]                         [int] IDENTITY(1, 1) NOT NULL,
		[GraphName]                       [nvarchar](100) NOT NULL,
		[GraphDisplayName]                [nvarchar](450) NOT NULL,
		[GraphQuery]                      [nvarchar](max) NOT NULL,
		[GraphQueryIsStoredProcedure]     [bit] NOT NULL,
		[GraphType]                       [nvarchar](50) NOT NULL,
		[GraphReportID]                   [int] NOT NULL,
		[GraphTitle]                      [nvarchar](200) NULL,
		[GraphXAxisTitle]                 [nvarchar](200) NULL,
		[GraphYAxisTitle]                 [nvarchar](200) NULL,
		[GraphWidth]                      [int] NULL,
		[GraphHeight]                     [int] NULL,
		[GraphLegendPosition]             [int] NULL,
		[GraphSettings]                   [nvarchar](max) NULL,
		[GraphGUID]                       [uniqueidentifier] NOT NULL,
		[GraphLastModified]               [datetime] NOT NULL,
		[GraphIsHtml]                     [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [Reporting_ReportGraph]
	ADD
	CONSTRAINT [PK_Reporting_ReportGraph]
	PRIMARY KEY
	CLUSTERED
	([GraphID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reporting_ReportGraph_GraphGUID]
	ON [Reporting_ReportGraph] ([GraphGUID])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reporting_ReportGraph_GraphReportID_GraphName]
	ON [Reporting_ReportGraph] ([GraphReportID], [GraphName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [Reporting_ReportGraph]
	WITH CHECK
	ADD CONSTRAINT [FK_Reporting_ReportGraph_GraphReportID_Reporting_Report]
	FOREIGN KEY ([GraphReportID]) REFERENCES [Reporting_Report] ([ReportID])
ALTER TABLE [Reporting_ReportGraph]
	CHECK CONSTRAINT [FK_Reporting_ReportGraph_GraphReportID_Reporting_Report]
