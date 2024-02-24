/*=============================================
  Author:		Ryan Parsons
  Create date:  10/15/2023
  Description:	Save Plaid access token and update Account and Institution entities
  Modified:     
	10/18/2023  Adds AvailableBalance, CurrentBalance, Limit, & IsoCurrencyCode to Account table (rparsons)
  =============================================*/
CREATE PROCEDURE [dbo].[usp_UpdateTokenAndSyncEntities]
    @UserId INT,
    @AccessToken NVARCHAR(MAX),
    @Institution NVARCHAR(MAX), --JSON string for Institution
    @Accounts dbo.AccountDtoType READONLY -- Passing array as TVP
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

	-- Parse Institution JSON
	DECLARE @InstitutionName NVARCHAR(255)
    DECLARE @InstitutionId NVARCHAR(255)
	SELECT  
		@InstitutionName = JSON_VALUE(@Institution, '$.name'),
		@InstitutionId = JSON_VALUE(@Institution, '$.institution_id')

	-- Declare a table variable to capture the new Id output of the insert into Institution statement
	DECLARE @OutputInstitutionTable TABLE (Id INT);
			
	 -- Check and Insert Institution if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM Institution WHERE PlaidInstitutionId = @InstitutionId)
    BEGIN
        INSERT INTO Institution (PlaidInstitutionId, [InstitutionName], CreatedOn, CreatedBy, LastUpdated, LastUpdatedBy)
        OUTPUT INSERTED.Id INTO @OutputInstitutionTable
	    VALUES (@InstitutionId, @InstitutionName, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER)

		-- Assign the captured value to the scalar variable
		SELECT TOP 1 @InstitutionId = Id FROM @OutputInstitutionTable;
	END
	ELSE
	BEGIN
		SELECT @InstitutionId = (
			SELECT TOP 1 Id 
			FROM Institution 
			WHERE PlaidInstitutionId = @InstitutionId
		)			
	END

	-- Declare a table variable to capture the new ItemId output of the insert into Item statement
	DECLARE @OutputItemTable TABLE (ItemId INT);
	-- Declare variable to hold the new ItemId
	DECLARE @NewItemId INT;
	
	-- Insert and capture the new ItemId into the table variable
	INSERT INTO Item (InstitutionId, AccessToken, UserId, CreatedOn, CreatedBy, LastUpdated, LastUpdatedBy)
	OUTPUT INSERTED.ItemId INTO @OutputItemTable
	SELECT @InstitutionId, @AccessToken, @UserId, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER
	WHERE NOT EXISTS (SELECT 1 FROM Item WHERE AccessToken = @AccessToken AND InstitutionId = @InstitutionId)
	-- Assign the captured value to the scalar variable
	SELECT TOP 1 @NewItemId = ItemId FROM @OutputItemTable;
	
	INSERT INTO Account (AccountId, AvailableBalance, CurrentBalance, Limit, IsoCurrencyCode, [Name], ItemId, [Type], Subtype, CreatedOn, CreatedBy, LastUpdated, LastUpdatedBy)
    SELECT AccountId, AvailableBalance, CurrentBalance, Limit, IsoCurrencyCode, [Name], @NewItemId, [Type], Subtype, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER
    FROM @Accounts
    WHERE AccountId NOT IN (SELECT AccountId FROM Account)
	   
    COMMIT TRANSACTION;
END


/* =================== TEST ==========================


USE [Pennywise]
GO

-- Sample parameters
DECLARE @UserIdTest INT = 12345 
DECLARE @AccessTokenTest NVARCHAR(MAX) = 'SomeAccessToken' 

-- Sample JSON for Institution
DECLARE @InstitutionTest NVARCHAR(MAX) = '{"name":"SomeInstitutionName", "institution_id":"SomeInstitutionId"}' -- Replace with a suitable test value

-- Sample AccountDtoType table data
DECLARE @AccountsTest dbo.AccountDtoType

-- Insert sample account data into table-valued parameter
INSERT INTO @AccountsTest (AccountId, Name, Type, Subtype)
VALUES ('Acc1', 'Account 1', 'Type1', 'Subtype1'), 
       ('Acc2', 'Account 2', 'Type2', 'Subtype2')  

-- Execute the stored procedure
EXEC [dbo].[usp_UpdateTokenAndSyncEntities] @UserIdTest, @AccessTokenTest, @InstitutionTest, @AccountsTest


====================================================*/
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_UpdateTokenAndSyncEntities] TO [dr_PennywiseAPI]
    AS [dbo];

