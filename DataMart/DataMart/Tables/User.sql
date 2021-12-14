CREATE TABLE [dbo].[User]
(
  [Id]           INT IDENTITY(1,1) NOT NULL         --user_id,this is business key not int
  ,[User]        NVARCHAR(255) NOT NULL                --user_id
  ,[UserName]    NVARCHAR(255) NOT NULL              --user_name
  ,[UserSurname] NVARCHAR(255) NOT NULL              --user_surname
  ,[CreationDate] DATE
)
