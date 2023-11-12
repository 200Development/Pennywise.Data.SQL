-- =============================================
-- Author:		Ryan Parsons
-- Create date: 10/23/2023
-- Description:	Get Plaid access token and latest cursor (NextCursor) for Plaid endpoint transactions/sync
-- =============================================
CREATE PROCEDURE usp_GetAccessTokenAndLatestCursor
	@ItemId INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT TOP 1
        i.ItemId, 
        i.AccessToken, 
        t.NextCursor
	FROM 
        Item i
    INNER JOIN 
        TransactionsSync t ON i.ItemId = t.ItemId
    WHERE 
        i.ItemId = @ItemId
    ORDER BY 
        t.LastSyncedOn DESC;
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_GetAccessTokenAndLatestCursor] TO [PennywiseAPI]
    AS [dbo];

