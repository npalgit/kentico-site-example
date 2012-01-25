CREATE TABLE [COM_Currency] (
		[CurrencyID]               [int] IDENTITY(1, 1) NOT NULL,
		[CurrencyName]             [nvarchar](200) NOT NULL,
		[CurrencyDisplayName]      [nvarchar](200) NOT NULL,
		[CurrencyCode]             [nvarchar](50) NOT NULL,
		[CurrencyRoundTo]          [int] NULL,
		[CurrencyEnabled]          [bit] NOT NULL,
		[CurrencyFormatString]     [nvarchar](100) NOT NULL,
		[CurrencyIsMain]           [bit] NOT NULL,
		[CurrencyGUID]             [uniqueidentifier] NULL,
		[CurrencyLastModified]     [datetime] NOT NULL,
		[CurrencySiteID]           [int] NULL
) ON [PRIMARY]
ALTER TABLE [COM_Currency]
	ADD
	CONSTRAINT [PK_COM_Currency]
	PRIMARY KEY
	NONCLUSTERED
	([CurrencyID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_COM_Currency_CurrencyDisplayName]
	ON [COM_Currency] ([CurrencyDisplayName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_COM_Currency_CurrencyEnabled_CurrencyIsMain]
	ON [COM_Currency] ([CurrencyEnabled], [CurrencyIsMain])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
ALTER TABLE [COM_Currency]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_Currency_CurrencySiteID_CMS_Site]
	FOREIGN KEY ([CurrencySiteID]) REFERENCES [CMS_Site] ([SiteID])
ALTER TABLE [COM_Currency]
	CHECK CONSTRAINT [FK_COM_Currency_CurrencySiteID_CMS_Site]
