CREATE TYPE [dbo].[AccountDtoType] AS TABLE (
    [AccountId]        NVARCHAR (255)  NULL,
    [AvailableBalance] DECIMAL (14, 2) NULL,
    [CurrentBalance]   DECIMAL (14, 2) NULL,
    [Limit]            DECIMAL (14, 2) NULL,
    [IsoCurrencyCode]  VARCHAR (12)    NULL,
    [Name]             NVARCHAR (255)  NULL,
    [Type]             NVARCHAR (255)  NULL,
    [Subtype]          NVARCHAR (255)  NULL);



