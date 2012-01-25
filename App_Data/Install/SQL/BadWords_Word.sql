CREATE TABLE [BadWords_Word] (
		[WordID]                      [int] IDENTITY(1, 1) NOT NULL,
		[WordGUID]                    [uniqueidentifier] NOT NULL,
		[WordLastModified]            [datetime] NOT NULL,
		[WordExpression]              [nvarchar](200) NOT NULL,
		[WordReplacement]             [nvarchar](200) NULL,
		[WordAction]                  [int] NULL,
		[WordIsGlobal]                [bit] NOT NULL,
		[WordIsRegularExpression]     [bit] NOT NULL,
		[WordMatchWholeWord]          [bit] NULL
) ON [PRIMARY]
ALTER TABLE [BadWords_Word]
	ADD
	CONSTRAINT [PK_BadWords_Word]
	PRIMARY KEY
	NONCLUSTERED
	([WordID])
	WITH FILLFACTOR=80
	ON [PRIMARY]
ALTER TABLE [BadWords_Word]
	ADD
	CONSTRAINT [DEFAULT_BadWords_Word_WordExpression]
	DEFAULT ('') FOR [WordExpression]
ALTER TABLE [BadWords_Word]
	ADD
	CONSTRAINT [DEFAULT_BadWords_Word_WordIsGlobal]
	DEFAULT ((0)) FOR [WordIsGlobal]
ALTER TABLE [BadWords_Word]
	ADD
	CONSTRAINT [DEFAULT_BadWords_Word_WordIsRegularExpression]
	DEFAULT ((0)) FOR [WordIsRegularExpression]
CREATE CLUSTERED INDEX [IX_BadWords_Word_WordExpression]
	ON [BadWords_Word] ([WordExpression])
	ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_BadWords_Word_WordIsGlobal]
	ON [BadWords_Word] ([WordIsGlobal])
	WITH ( FILLFACTOR = 80)
	ON [PRIMARY]
