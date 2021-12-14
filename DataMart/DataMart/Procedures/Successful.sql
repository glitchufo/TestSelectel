CREATE PROCEDURE [dbo].[Successful]
    (@CreateDate datetime
    ,@EndDate datetime
    ,@Rowcount bigint
    ,@ProcedureName nvarchar(100))
AS
BEGIN
    INSERT INTO [dbo].[Logs]
        (    
            [StartDate] 
            ,[EndDate]        
            ,[RowNumber]          
            ,[Procedure]        
            ,[Status]           
        )
    SELECT  
         @CreateDate                AS [StartDate]
        ,@EndDate                   AS [EndDate]
        ,@Rowcount                  AS [RowNumber]  
        ,@ProcedureName             AS [Procedure]        
        ,N'Successful'              AS [Status]  
END