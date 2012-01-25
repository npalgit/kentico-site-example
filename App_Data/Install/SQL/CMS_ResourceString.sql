CREATE TABLE [CMS_ResourceString] (
		[StringID]                 [int] IDENTITY(1, 1) NOT NULL,
		[StringKey]                [nvarchar](200) NOT NULL,
		[StringIsCustom]           [bit] NOT NULL,
		[StringLoadGeneration]     [int] NOT NULL
) ON [PRIMARY]
ALTER TABLE [CMS_ResourceString]
	ADD
	CONSTRAINT [PK_CMS_ResourceString]
	PRIMARY KEY
	NONCLUSTERED
	([StringID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [CMS_ResourceString]
	ADD
	CONSTRAINT [DEFAULT_CMS_ResourceString_StringLoadGeneration]
	DEFAULT ((0)) FOR [StringLoadGeneration]
CREATE NONCLUSTERED INDEX [IX_CMS_ResourceString_StringKey]
	ON [CMS_ResourceString] ([StringKey])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
CREATE CLUSTERED INDEX [IX_CMS_ResourceString_StringLoadGeneration]
	ON [CMS_ResourceString] ([StringLoadGeneration])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
