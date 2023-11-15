CREATE TABLE [dbo].[Merchant] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [MerchantEntityId] NVARCHAR (255) NOT NULL,
    [MerchantName]     VARCHAR (255)  NOT NULL,
    [Website]          VARCHAR (255)  NULL,
    [LogoUrl]          VARCHAR (255)  NULL,
    CONSTRAINT [PK_Merchant] PRIMARY KEY CLUSTERED ([Id] ASC)
);

