CREATE TABLE [dbo].[Transaction] (
    [TransactionId] INT            NOT NULL,
    [AccountId]     INT            NOT NULL,
    [Name]          VARCHAR (255)  NOT NULL,
    [Amount]        MONEY          NOT NULL,
    [Date]          DATETIME2 (7)  NOT NULL,
    [Category]      VARCHAR (128)  NULL,
    [Location]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED ([TransactionId] ASC)
);

