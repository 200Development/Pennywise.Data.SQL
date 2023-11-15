CREATE TYPE [dbo].[TransactionDtoType] AS TABLE (
    [TransactionId]           VARCHAR (255)  NULL,
    [AccountId]               NVARCHAR (255) NOT NULL,
    [Amount]                  NVARCHAR (255) NULL,
    [IsoCurrencyCode]         VARCHAR (3)    NULL,
    [Name]                    VARCHAR (255)  NULL,
    [MerchantEntityId]        VARCHAR (255)  NULL,
    [MerchantName]            VARCHAR (255)  NULL,
    [LogoUrl]                 VARCHAR (255)  NULL,
    [Website]                 VARCHAR (255)  NULL,
    [Date]                    DATETIME2 (7)  NULL,
    [PrimaryCategory]         VARCHAR (255)  NULL,
    [DetailedCategory]        VARCHAR (255)  NULL,
    [CategoryConfidenceLevel] VARCHAR (255)  NULL,
    [PaymentChannel]          NVARCHAR (255) NULL);



