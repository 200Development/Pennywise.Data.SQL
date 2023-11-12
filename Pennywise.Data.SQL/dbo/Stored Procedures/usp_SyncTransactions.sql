-- =============================================
-- Author:		RParsons
-- Create date: Nov 11, 2023
-- Description:	Insert new transactions, Update transactions that were modified, and Remove deleted transactions.  Log Transaction in TransactionSync table to track latest NextCursor
-- =============================================
CREATE PROCEDURE [dbo].[usp_SyncTransactions]
	@AccountId NVARCHAR(255),
	@NextCursor NVARCHAR(255),
	@AddedTransactions TransactionDtoType READONLY,
	@ModifiedTransactions TransactionDtoType READONLY,
	@RemovedTransactions TransactionDtoType READONLY
AS
BEGIN
	SET NOCOUNT ON;
	 
	BEGIN TRY
	BEGIN TRANSACTION

	INSERT INTO [Transaction] (TransactionId, AccountId, [Name], MerchantName, Amount, Payee, Payer, OriginalDescription, PaymentMethod, [Date], AuthorizedDateTime, IsoCurrencyCode, PendingTransactionId, LogoUrl, Website, CreatedBy, CreatedOn, LastUpdatedBy, LastUpdated)
	SELECT TransactionId, @AccountId, [Name], MerchantName, Amount, Payee, Payer, OriginalDescription, PaymentMethod, [Date], AuthorizedDateTime, IsoCurrencyCode, PendingTransactionId, LogoUrl, Website, SYSTEM_USER, GETDATE(),SYSTEM_USER,GETDATE()
	FROM @AddedTransactions

	UPDATE t 
    SET  t.[Name] = mt.[Name]
        ,t.MerchantName = mt.MerchantName
		,t.Amount = mt.Amount
		,t.Payee = mt.Payee
		,t.Payer = mt.Payer
		,t.OriginalDescription = mt.OriginalDescription
		,t.PaymentMethod = mt.PaymentMethod
		,t.[Date] = mt.[Date]
		,t.AuthorizedDateTime = mt.AuthorizedDateTime
		,t.IsoCurrencyCode = mt.IsoCurrencyCode
		,t.PendingTransactionId = mt.PendingTransactionId
		,t.LogoUrl = mt.LogoUrl
		,t.Website = mt.Website		
		,t.LastUpdated = GETDATE()
		,t.LastUpdatedBy = SYSTEM_USER
    FROM [Transaction] t
    INNER JOIN @ModifiedTransactions mt
        ON t.TransactionID = mt.TransactionID;


	DELETE t
    FROM [Transaction] t
    INNER JOIN @RemovedTransactions rt
        ON t.TransactionID = rt.TransactionID;

	INSERT INTO [TransactionsSync] (ItemId,LastSyncedOn,NextCursor,[Status],CreatedOn,CreatedBy,LastUpdated,LastUpdatedBy)
	SELECT (SELECT ItemId FROM Account WHERE AccountId = @AccountId),GETDATE(),@NextCursor,'Good',GETDATE(),SYSTEM_USER,GETDATE(),SYSTEM_USER

	COMMIT TRANSACTION
END TRY
 BEGIN CATCH
        -- Rollback the transaction if there's an error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        
        -- Log the error to the SqlErrorLog table
        INSERT INTO SqlErrorLog (ErrorTime, ErrorMessage, ErrorSeverity, ErrorState)
        VALUES (GETDATE(), ERROR_MESSAGE(), ERROR_SEVERITY(), ERROR_STATE())
		       
    END CATCH
END