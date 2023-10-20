CREATE TABLE [dbo].[Account] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [AccountId]        NVARCHAR (255) NOT NULL,
    [Name]             NVARCHAR (255) NULL,
    [OfficialName]     NVARCHAR (255) NULL,
    [ItemId]           INT            NOT NULL,
    [Type]             VARCHAR (50)   NULL,
    [Subtype]          VARCHAR (50)   NULL,
    [Mask]             VARCHAR (50)   NULL,
    [CurrentBalance]   MONEY          NULL,
    [AvailableBalance] MONEY          NULL,
    [CreatedOn]        DATETIME2 (7)  NOT NULL,
    [CreatedBy]        VARCHAR (50)   NOT NULL,
    [LastUpdated]      DATETIME2 (7)  NOT NULL,
    [LastUpdatedBy]    VARCHAR (50)   NOT NULL,
    [Limit]            MONEY          NULL,
    [IsoCurrencyCode]  VARCHAR (12)   NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED ([Id] ASC)
);





