CREATE TABLE [COM_ShoppingCartSKU] (
		[CartItemID]             [int] IDENTITY(1, 1) NOT NULL,
		[ShoppingCartID]         [int] NOT NULL,
		[SKUID]                  [int] NOT NULL,
		[SKUUnits]               [int] NOT NULL,
		[CartItemCustomData]     [nvarchar](max) NULL,
		[CartItemGuid]           [uniqueidentifier] NULL,
		[CartItemParentGuid]     [uniqueidentifier] NULL,
		[CartItemPrice]          [float] NULL,
		[CartItemIsPrivate]      [bit] NULL,
		[CartItemValidTo]        [datetime] NULL,
		[CartItemBundleGUID]     [uniqueidentifier] NULL,
		[CartItemText]           [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [COM_ShoppingCartSKU]
	ADD
	CONSTRAINT [PK_COM_ShoppingCartSKU]
	PRIMARY KEY
	CLUSTERED
	([CartItemID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCartSKU_ShoppingCartID]
	ON [COM_ShoppingCartSKU] ([ShoppingCartID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_COM_ShoppingCartSKU_SKUID]
	ON [COM_ShoppingCartSKU] ([SKUID])
	ON [PRIMARY]
ALTER TABLE [COM_ShoppingCartSKU]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_ShoppingCartSKU_ShoppingCartID_COM_ShoppingCart]
	FOREIGN KEY ([ShoppingCartID]) REFERENCES [COM_ShoppingCart] ([ShoppingCartID])
ALTER TABLE [COM_ShoppingCartSKU]
	CHECK CONSTRAINT [FK_COM_ShoppingCartSKU_ShoppingCartID_COM_ShoppingCart]
ALTER TABLE [COM_ShoppingCartSKU]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_ShoppingCartSKU_SKUID_COM_SKU]
	FOREIGN KEY ([SKUID]) REFERENCES [COM_SKU] ([SKUID])
ALTER TABLE [COM_ShoppingCartSKU]
	CHECK CONSTRAINT [FK_COM_ShoppingCartSKU_SKUID_COM_SKU]
