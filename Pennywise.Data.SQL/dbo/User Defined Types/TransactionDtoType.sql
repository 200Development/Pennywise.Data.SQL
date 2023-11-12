CREATE TYPE [dbo].[TransactionDtoType] AS TABLE (
    [AccountId]            NVARCHAR (255) NOT NULL,
    [Amount]               MONEY          NULL,
    [IsoCurrencyCode]      VARCHAR (12)   NULL,
    [Date]                 DATETIME2 (7)  NULL,
    [Name]                 VARCHAR (128)  NULL,
    [MerchantName]         VARCHAR (128)  NULL,
    [OriginalDescription]  VARCHAR (255)  NULL,
    [Payee]                VARCHAR (128)  NULL,
    [Payer]                VARCHAR (128)  NULL,
    [PaymentMethod]        VARCHAR (128)  NULL,
    [PendingTransactionId] VARCHAR (128)  NULL,
    [TransactionId]        VARCHAR (128)  NULL,
    [LogoUrl]              VARCHAR (128)  NULL,
    [Website]              VARCHAR (128)  NULL,
    [AuthorizedDateTime]   DATETIME2 (7)  NULL);

