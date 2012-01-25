CREATE TABLE [COM_OrderStatusUser] (
		[OrderStatusUserID]     [int] IDENTITY(1, 1) NOT NULL,
		[OrderID]               [int] NOT NULL,
		[FromStatusID]          [int] NULL,
		[ToStatusID]            [int] NOT NULL,
		[ChangedByUserID]       [int] NULL,
		[Date]                  [datetime] NOT NULL,
		[Note]                  [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
ALTER TABLE [COM_OrderStatusUser]
	ADD
	CONSTRAINT [PK_COM_OrderStatusUser]
	PRIMARY KEY
	NONCLUSTERED
	([OrderStatusUserID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatusUser_ChangedByUserID]
	ON [COM_OrderStatusUser] ([ChangedByUserID])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatusUser_FromStatusID]
	ON [COM_OrderStatusUser] ([FromStatusID])
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_COM_OrderStatusUser_OrderID_Date]
	ON [COM_OrderStatusUser] ([OrderID], [Date] DESC)
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatusUser_ToStatusID]
	ON [COM_OrderStatusUser] ([ToStatusID])
	ON [PRIMARY]
ALTER TABLE [COM_OrderStatusUser]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_OrderStatusUser_ChangedByUserID_CMS_User]
	FOREIGN KEY ([ChangedByUserID]) REFERENCES [CMS_User] ([UserID])
ALTER TABLE [COM_OrderStatusUser]
	CHECK CONSTRAINT [FK_COM_OrderStatusUser_ChangedByUserID_CMS_User]
ALTER TABLE [COM_OrderStatusUser]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_OrderStatusUser_FromStatusID_COM_Status]
	FOREIGN KEY ([FromStatusID]) REFERENCES [COM_OrderStatus] ([StatusID])
ALTER TABLE [COM_OrderStatusUser]
	CHECK CONSTRAINT [FK_COM_OrderStatusUser_FromStatusID_COM_Status]
ALTER TABLE [COM_OrderStatusUser]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_OrderStatusUser_OrderID_COM_Order]
	FOREIGN KEY ([OrderID]) REFERENCES [COM_Order] ([OrderID])
ALTER TABLE [COM_OrderStatusUser]
	CHECK CONSTRAINT [FK_COM_OrderStatusUser_OrderID_COM_Order]
ALTER TABLE [COM_OrderStatusUser]
	WITH CHECK
	ADD CONSTRAINT [FK_COM_OrderStatusUser_ToStatusID_COM_Status]
	FOREIGN KEY ([ToStatusID]) REFERENCES [COM_OrderStatus] ([StatusID])
ALTER TABLE [COM_OrderStatusUser]
	CHECK CONSTRAINT [FK_COM_OrderStatusUser_ToStatusID_COM_Status]
