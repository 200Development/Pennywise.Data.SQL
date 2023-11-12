CREATE TABLE [dbo].[Transaction] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [TransactionId]        VARCHAR (128)  NULL,
    [LogoUrl]              VARCHAR (128)  NULL,
    [Website]              VARCHAR (128)  NULL,
    [AccountId]            NVARCHAR (255) NOT NULL,
    [Name]                 VARCHAR (255)  NOT NULL,
    [Amount]               MONEY          NOT NULL,
    [IsoCurrencyCode]      VARCHAR (12)   NULL,
    [MerchantName]         VARCHAR (128)  NULL,
    [OriginalDescription]  VARCHAR (255)  NULL,
    [Payee]                VARCHAR (128)  NULL,
    [Payer]                VARCHAR (128)  NULL,
    [PaymentMethod]        VARCHAR (128)  NULL,
    [PendingTransactionId] VARCHAR (128)  NULL,
    [Date]                 DATETIME2 (7)  NOT NULL,
    [AuthorizedDateTime]   DATETIME2 (7)  NULL,
    [Category]             VARCHAR (128)  NULL,
    [Location]             NVARCHAR (255) NULL,
    [CreatedOn]            DATETIME2 (7)  NOT NULL,
    [CreatedBy]            VARCHAR (50)   NOT NULL,
    [LastUpdated]          DATETIME2 (7)  NOT NULL,
    [LastUpdatedBy]        VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED ([Id] ASC)
);





