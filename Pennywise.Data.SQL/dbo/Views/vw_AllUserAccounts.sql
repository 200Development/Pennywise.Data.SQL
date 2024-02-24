
CREATE VIEW [dbo].[vw_AllUserAccounts] AS
SELECT [Name], [Type], Subtype, CurrentBalance, AvailableBalance, A.Limit, A.IsoCurrencyCode, U.UserId
FROM dbo.Account A
JOIN Item I on i.ItemId = A.ItemId
JOIN [User] U on U.UserId = I.UserId;
GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_AllUserAccounts] TO [dr_PennywiseAPI]
    AS [dbo];

