CREATE PROCEDURE [dbo].[LoadAll]
AS
BEGIN
BEGIN TRY

	DECLARE @CreateDate datetime = GETDATE();
	DECLARE @EndDate datetime;
    DECLARE @Query NVARCHAR(4000)


--Execute all load ETL 
  EXECUTE [dbo].[LoadUser];
  EXECUTE [dbo].[LoadService];
  EXECUTE [dbo].[LoadOrder];
  
   
    SET @EndDate = GETDATE()
    EXEC [dbo].[Successful] @CreateDate,@EndDate,@@ROWCOUNT,N'dbo.LoadAll'

END TRY
BEGIN CATCH  

	DECLARE @error INT
	DECLARE @message NVARCHAR(4000)
	DECLARE @procedure NVARCHAR(4000)
    DECLARE @StartDate datetime = GETDATE()

    INSERT INTO [dbo].[Logs]
    (    
        [StartDate]        
        ,[ErorNumber]       
        ,[ErrorMessage]     
        ,[Procedure]        
        ,[Status]           
    )
    SELECT  
         @StartDate         AS [StartDate]        
        ,ERROR_NUMBER()     AS [ErorNumber]       
        ,ERROR_MESSAGE()    AS [ErrorMessage]     
        ,@Query             AS [Procedure]        
        ,N'Unsuccessful'    AS [Status]           
	SELECT
    	@procedure = ERROR_PROCEDURE()
        ,@message = ERROR_MESSAGE()
		,@error = ERROR_NUMBER()
	
	RAISERROR('Procedure : %d: %s', 16, 1, @error, @message, @procedure)
END CATCH
		
END

