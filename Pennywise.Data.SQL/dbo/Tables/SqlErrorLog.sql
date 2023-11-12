CREATE TABLE [dbo].[SqlErrorLog] (
    [ErrorTime]     DATETIME       NULL,
    [ErrorMessage]  NVARCHAR (MAX) NULL,
    [ErrorSeverity] INT            NULL,
    [ErrorState]    INT            NULL
);

