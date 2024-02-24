-- =============================================
-- Author:		RParsons
-- Create date: Nov 11, 2023
-- Description:	Insert new transactions, Update transactions that were modified, and Remove deleted transactions.  Log Transaction in TransactionSync table to track latest NextCursor
-- =============================================
CREATE PROCEDURE [dbo].[usp_SyncTransactions]	
	@NextCursor NVARCHAR(255),
	@AddedTransactions TransactionDtoType READONLY,
	@ModifiedTransactions TransactionDtoType READONLY,
	@RemovedTransactions TransactionDtoType READONLY
AS
BEGIN
	SET NOCOUNT ON;
	    
	BEGIN TRY
	BEGIN TRANSACTION
	
		-- Insert new Merchants 
		INSERT INTO Merchant (MerchantEntityId, MerchantName, Website, LogoUrl)	
		SELECT DISTINCT MerchantEntityId, MerchantName, Website, LogoUrl
		FROM @AddedTransactions t
		WHERE MerchantEntityId IS NOT NULL
		AND NOT EXISTS (
			SELECT 1 
			FROM Merchant m
			WHERE m.MerchantEntityId = t.MerchantEntityId 
		)
		
		-- Update existing Merchants
		UPDATE m
		SET m.MerchantEntityId = udt.MerchantEntityId,
			m.MerchantName = udt.MerchantName,
		    m.Website = udt.Website,
			m.LogoUrl = udt.LogoUrl
		FROM Merchant m
		INNER JOIN @ModifiedTransactions udt ON m.MerchantEntityId = udt.MerchantEntityId

		-- Insert new Transactions
		INSERT INTO [Transaction] (TransactionId, AccountId, [Name], Amount, IsoCurrencyCode, MerchantId, [Date], PrimaryCategory, DetailedCategory, CategoryConfidenceLevel, PaymentChannel, CreatedBy, CreatedOn, LastUpdatedBy, LastUpdated)
		SELECT TransactionId, AccountId, [Name], CONVERT(money,REPLACE(Amount,',','')), IsoCurrencyCode, (SELECT Id FROM Merchant WHERE MerchantEntityId = t.MerchantEntityId), [Date], PrimaryCategory, DetailedCategory, CategoryConfidenceLevel, PaymentChannel, SYSTEM_USER, GETDATE(), SYSTEM_USER, GETDATE()
		FROM @AddedTransactions t

		-- Update existing Transactions
		UPDATE t 
		SET  t.[Name] = mt.[Name]	   
			,t.Amount = CONVERT(money,REPLACE(mt.Amount,',',''))
			,t.IsoCurrencyCode = mt.IsoCurrencyCode		    
			,t.[Date] = mt.[Date]	  
			,t.PrimaryCategory = mt.PrimaryCategory
			,t.DetailedCategory = mt.DetailedCategory
			,t.CategoryConfidenceLevel = mt.CategoryConfidenceLevel		
			,t.PaymentChannel = mt.PaymentChannel
			,t.LastUpdated = GETDATE()
			,t.LastUpdatedBy = SYSTEM_USER
		FROM [Transaction] t
		INNER JOIN @ModifiedTransactions mt
		    ON t.TransactionID = mt.TransactionID;

		-- Set "Deleted" column in Transactions table to true for removed Transactions
		UPDATE t
		SET t.Deleted = 1
		FROM [Transaction] t
		INNER JOIN @RemovedTransactions rt
		ON t.TransactionID = rt.TransactionID;

		INSERT INTO [TransactionsSync] (ItemId,LastSyncedOn,NextCursor,[Status],CreatedOn,CreatedBy,LastUpdated,LastUpdatedBy)
		SELECT (SELECT TOP 1 ItemId FROM Account WHERE AccountId = AccountId),GETDATE(),@NextCursor,'Good',GETDATE(),SYSTEM_USER,GETDATE(),SYSTEM_USER

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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_SyncTransactions] TO [dr_PennywiseAPI]
    AS [dbo];

