CREATE TABLE [dbo].[User] (
    [UserId]        INT           NOT NULL,
    [Username]      VARCHAR (20)  NOT NULL,
    [PasswordHash]  VARCHAR (128) NOT NULL,
    [FirstName]     NVARCHAR (50) NULL,
    [LastName]      NVARCHAR (50) NULL,
    [NickName]      NVARCHAR (50) NULL,
    [Salutations]   NVARCHAR (50) NULL,
    [Suffix]        NVARCHAR (50) NULL,
    [Email]         VARCHAR (255) NOT NULL,
    [CreatedOn]     DATETIME2 (7) NOT NULL,
    [CreatedBy]     VARCHAR (50)  NOT NULL,
    [LastUpdated]   DATETIME2 (7) NOT NULL,
    [LastUpdatedBy] VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([UserId] ASC)
);

