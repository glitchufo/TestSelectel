CREATE TABLE [dbo].[Order]
(
  [Id] INT NOT NULL PRIMARY KEY             --server_order_id
  ,[ServiceStartDate] DATE NOT NULL         --service_start_date
  ,[ServiceEndDate] DATE NOT NULL           --service_end_date
  ,[Price] FLOAT NOT NULL                   --price
  ,[ServiceId] INT NOT NULL                 --Id in table Service
  ,[UserId] INT NOT NULL                    --Id in table user
  ,[CreationDate] DATE
)
