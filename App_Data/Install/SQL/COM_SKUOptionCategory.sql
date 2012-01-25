CREATE TABLE [COM_SKUOptionCategory] (
		[SKUID]          [int] NOT NULL,
		[CategoryID]     [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [COM_SKUOptionCategory]
	ADD
	CONSTRAINT [PK_COM_SKUOptionCategory]
	PRIMARY KEY
	CLUSTERED
	([SKUID], [CategoryID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [COM_SKUOptionCategory]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_SKUOptionCategory_CategoryID_COM_OptionCategory]
	FOREIGN KEY ([CategoryID]) REFERENCES [COM_OptionCategory] ([CategoryID])
ALTER TABLE [COM_SKUOptionCategory]
	CHECK CONSTRAINT [FK_COM_SKUOptionCategory_CategoryID_COM_OptionCategory]
ALTER TABLE [COM_SKUOptionCategory]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_SKUOptionCategory_SKUID_COM_SKU]
	FOREIGN KEY ([SKUID]) REFERENCES [COM_SKU] ([SKUID])
ALTER TABLE [COM_SKUOptionCategory]
	CHECK CONSTRAINT [FK_COM_SKUOptionCategory_SKUID_COM_SKU]
