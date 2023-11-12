CREATE TABLE [dbo].[Item] (
    [ItemId]        INT           IDENTITY (1, 1) NOT NULL,
    [InstitutionId] INT           NOT NULL,
    [AccessToken]   VARCHAR (255) NULL,
    [UserId]        INT           NOT NULL,
    [CreatedOn]     DATETIME2 (7) NOT NULL,
    [CreatedBy]     VARCHAR (50)  NOT NULL,
    [LastUpdated]   DATETIME2 (7) NOT NULL,
    [LastUpdatedBy] VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED ([ItemId] ASC)
);






GO
GRANT SELECT
    ON OBJECT::[dbo].[Item] TO [PennywiseAPI]
    AS [dbo];

