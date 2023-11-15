CREATE TABLE [dbo].[Transaction] (
    [Id]                      INT            IDENTITY (1, 1) NOT NULL,
    [TransactionId]           VARCHAR (255)  NULL,
    [AccountId]               NVARCHAR (255) NOT NULL,
    [Name]                    VARCHAR (255)  NOT NULL,
    [Amount]                  MONEY          NOT NULL,
    [IsoCurrencyCode]         VARCHAR (3)    NULL,
    [MerchantId]              INT            NULL,
    [Date]                    DATETIME2 (7)  NOT NULL,
    [PrimaryCategory]         VARCHAR (255)  NULL,
    [DetailedCategory]        VARCHAR (255)  NULL,
    [CategoryConfidenceLevel] VARCHAR (255)  NULL,
    [PaymentChannel]          NVARCHAR (255) NULL,
    [Deleted]                 BIT            DEFAULT ((0)) NOT NULL,
    [CreatedOn]               DATETIME2 (7)  NOT NULL,
    [CreatedBy]               VARCHAR (255)  NOT NULL,
    [LastUpdated]             DATETIME2 (7)  NOT NULL,
    [LastUpdatedBy]           VARCHAR (255)  NOT NULL,
    CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED ([Id] ASC)
);







