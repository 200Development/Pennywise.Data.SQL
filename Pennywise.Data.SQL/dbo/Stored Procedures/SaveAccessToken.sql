-- =============================================
-- Author:		Ryan Parsons
-- Create date: 10/08/2023
-- Description:	Check if Institution exists in DB and insert if not, then save Plaid access token that is used to query data from an institution.  
-- =============================================
CREATE PROCEDURE [dbo].[SaveAccessToken]
	@UserId int,
	@InstitutionId int,
	@InstitutionName nvarchar(255),
	@AccessToken varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM Institution WHERE InstitutionId = @InstitutionId)
	BEGIN
		INSERT INTO Institution (InstitutionId, InstitutionName)
		VALUES (@InstitutionId, @InstitutionName)
	END

	INSERT INTO dbo.Item (
		InstitutionId, 
		AccessToken, 
		UserId
	)
	VALUES (
		@InstitutionId,
		@AccessToken,
		@UserId
	)
END