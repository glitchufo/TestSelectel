CREATE PROCEDURE [dbo].[LoadOrder]
AS
BEGIN

	DECLARE @CreateDate datetime = GETDATE();
	DECLARE @EndDate datetime;
	DECLARE @Rows INT
	
	TRUNCATE TABLE [dbo].[Order];
  
	INSERT INTO [dbo].[Order](
       [Id]
      ,[ServiceStartDate]
      ,[ServiceEndDate]
      ,[Price]
      ,[ServiceId]
      ,[UserId]
      ,[CreationDate])
  SELECT DISTINCT
      [server_order_id] AS [Id]
      ,CAST([service_start_date] AS DATE) AS [ServiceStartDate]
      ,CAST([service_end_date] AS DATE) AS [ServiceEndDate]
      ,CAST([price] AS FLOAT) AS [Price]
      ,[service_id] AS [ServiceId]
      ,u.[Id] AS [UserId]                    --ClientId
      ,@CreateDate
  FROM [StagingArea].[dbo].[CfTestDataset] AS s
  LEFT JOIN [dbo].[User] AS u ON s.[user_id] = u.[User]

  SET @Rows = @@ROWCOUNT
  SET @EndDate = GETDATE()
  EXEC [dbo].[Successful] @CreateDate,@EndDate,@Rows,N'dbo.LoadOrder'       

END