CREATE PROCEDURE [dbo].[LoadUser]
AS
BEGIN

	DECLARE @CreateDate datetime = GETDATE();
	DECLARE @EndDate datetime;
	DECLARE @Rows INT
	TRUNCATE TABLE [dbo].[User];
  
	INSERT INTO [dbo].[User](
        [User]                        --user_id
        ,[UserName]                  --user_name
        ,[UserSurname]               --user_surname
			  ,[CreationDate])
  SELECT DISTINCT
        [user_id]  AS [User]                  --ClientId
        ,[user_name]  AS [UserName]                --ClientName
        ,[user_surname]   AS [UserSurname]            --ClientSurname
			  ,@CreateDate
  FROM [StagingArea].[dbo].[CfTestDataset]
 
  SET @Rows = @@ROWCOUNT
  SET @EndDate = GETDATE()
  EXEC [dbo].[Successful] @CreateDate,@EndDate,@Rows,N'dbo.LoadUser'       

END