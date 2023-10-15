CREATE TABLE [dbo].[Institution] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [PlaidInstitutionId] NVARCHAR (255) NOT NULL,
    [InstitutionName]    NVARCHAR (255) NULL,
    [InstitutionLogo]    NVARCHAR (255) NULL,
    [CreatedOn]          DATETIME2 (7)  NOT NULL,
    [CreatedBy]          VARCHAR (50)   NOT NULL,
    [LastUpdated]        DATETIME2 (7)  NOT NULL,
    [LastUpdatedBy]      VARCHAR (50)   NOT NULL,
    CONSTRAINT [PK_Institution] PRIMARY KEY CLUSTERED ([Id] ASC)
);



