CREATE TABLE [dbo].[TransactionsSync] (
    [Id]            INT            IDENTITY (1, 1) NOT NULL,
    [ItemId]        INT            NOT NULL,
    [LastSyncedOn]  DATETIME2 (7)  NOT NULL,
    [NextCursor]    NVARCHAR (MAX) NOT NULL,
    [Status]        VARCHAR (50)   NULL,
    [ErrorMessage]  NVARCHAR (MAX) NULL,
    [CreatedOn]     DATETIME2 (7)  NOT NULL,
    [CreatedBy]     VARCHAR (50)   NOT NULL,
    [LastUpdated]   DATETIME2 (7)  NOT NULL,
    [LastUpdatedBy] VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_TransactionsSync] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[TransactionsSync] TO [PennywiseAPI]
    AS [dbo];

