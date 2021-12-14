CREATE PROCEDURE [dbo].[LoadService]
AS
BEGIN

	DECLARE @CreateDate datetime = GETDATE();
	DECLARE @EndDate datetime;
	DECLARE @Rows INT
	
	TRUNCATE TABLE [dbo].[Service];
  
	INSERT INTO [dbo].[Service](
       [Id] 
      ,[ServerConfiguration]
      ,[CreationDate])
  SELECT DISTINCT
      [service_id] AS [Id]
      ,[server_configuration] AS [ServerConfiguration]
      ,@CreateDate
  FROM [StagingArea].[dbo].[CfTestDataset]

  SET @Rows = @@ROWCOUNT
  SET @EndDate = GETDATE()
  EXEC [dbo].[Successful] @CreateDate,@EndDate,@Rows,N'dbo.LoadService'       

END