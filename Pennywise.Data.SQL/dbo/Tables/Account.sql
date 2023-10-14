CREATE TABLE [dbo].[Account] (
    [AccountId]        INT            NOT NULL,
    [Name]             NVARCHAR (255) NOT NULL,
    [OfficialName]     NVARCHAR (255) NULL,
    [ItemId]           INT            NULL,
    [Type]             VARCHAR (50)   NOT NULL,
    [SubType]          VARCHAR (50)   NOT NULL,
    [Mask]             VARCHAR (50)   NOT NULL,
    [CurrentBalance]   MONEY          NOT NULL,
    [AvailableBalance] MONEY          NOT NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED ([AccountId] ASC)
);

