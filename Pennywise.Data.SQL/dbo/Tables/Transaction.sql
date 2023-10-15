CREATE TABLE [dbo].[Transaction] (
    [TransactionId] INT            NOT NULL,
    [AccountId]     INT            NOT NULL,
    [Name]          VARCHAR (255)  NOT NULL,
    [Amount]        MONEY          NOT NULL,
    [Date]          DATETIME2 (7)  NOT NULL,
    [Category]      VARCHAR (128)  NULL,
    [Location]      NVARCHAR (255) NULL,
    [CreatedOn]     DATETIME2 (7)  NOT NULL,
    [CreatedBy]     VARCHAR (50)   NOT NULL,
    [LastUpdated]   DATETIME2 (7)  NOT NULL,
    [LastUpdatedBy] VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED ([TransactionId] ASC)
);



