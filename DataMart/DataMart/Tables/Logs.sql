CREATE TABLE [dbo].[Logs]
(
    [ErrorId]           bigint  IDENTITY(1,1)
    ,[StartDate]        datetime
    ,[EndDate]          datetime
    ,[RowNumber]        bigint                   NULL
    ,[ErorNumber]       bigint                   NULL
    ,[ErrorMessage]     nvarchar(4000)           NULL
    ,[Procedure]        nvarchar(4000)           NULL
    ,[Status]           nvarchar(100)            NULL
)