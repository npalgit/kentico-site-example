CREATE TABLE [CMS_Culture] (
		[CultureID]               [int] IDENTITY(1, 1) NOT NULL,
		[CultureName]             [nvarchar](200) NOT NULL,
		[CultureCode]             [nvarchar](50) NOT NULL,
		[CultureShortName]        [nvarchar](200) NOT NULL,
		[CultureGUID]             [uniqueidentifier] NOT NULL,
		[CultureLastModified]     [datetime] NOT NULL,
		[CultureAlias]            [nvarchar](100) NULL
) ON [PRIMARY]
ALTER TABLE [CMS_Culture]
	ADD
	CONSTRAINT [PK_CMS_Culture]
	PRIMARY KEY
	NONCLUSTERED
	([CultureID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_CulturAlias]
	ON [CMS_Culture] ([CultureAlias])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_CMS_Culture_CultureCode]
	ON [CMS_Culture] ([CultureCode])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_Culture_CultureName]
	ON [CMS_Culture] ([CultureName])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
