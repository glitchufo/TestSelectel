CREATE PROCEDURE [dbo].[GetReport2]
AS
    /*
    Задача:
    "Количество новых заказов серверов по каждому Userу, в динамике помесячно в соответствии с примером ниже."
    
    Не совсе понятно нужно вывести только по месяцам или года тоже. Сделал только по месяцам.
    Также ниже если нудно по годам, то можно сделать EOMONTH вывести и в динамическом запросе сделать PIVOT, но нужно будет его доработать
    */
    DROP TABLE IF EXISTS #a;

    SELECT 
        u.[UserName]    AS [User]
        ,MONTH(ServiceStartDate) AS [MoNum]
        ,DATENAME(Month,[ServiceStartDate]) AS [MonthName]
        ,COUNT(o.[Id]) AS [ServiceCount]
    INTO #a    
    FROM [dbo].[Order] AS o
    LEFT JOIN [dbo].[Service] AS s ON o.[ServiceId] = s.[Id]
    LEFT JOIN [dbo].[User] u ON o.[UserId] = u.[Id]
    GROUP BY DATENAME(Month,[ServiceStartDate]) ,MONTH(ServiceStartDate) , u.[UserName] 
    
    SELECT [User] AS [Клиент]
        ,SUM([Январь]) AS [Январь]
        ,SUM([Февраль]) AS [Февраль]
        ,SUM([Март]) AS [Март]
        ,SUM([Апрель]) AS [Апрель]
        ,SUM([Май]) AS [Май]
        ,SUM([Июнь]) AS [Июнь]
        ,SUM([Июль]) AS [Июль]
        ,SUM([Август]) AS [Август]
        ,SUM([Сентябрь]) AS [Сентябрь]
        ,SUM([Октябрь]) AS [Октябрь]
        ,SUM([Ноябрь]) AS [Ноябрь]
        ,SUM([Декабрь]) AS [Декабрь]
    FROM #a AS p
    PIVOT(SUM([ServiceCount]) FOR [MonthName] IN (
                [Январь]
                ,[Февраль]
                ,[Март]
                ,[Апрель]
                ,[Май]
                ,[Июнь]
                ,[Июль]
                ,[Август]
                ,[Сентябрь]
                ,[Октябрь]
                ,[Ноябрь]
                ,[Декабрь]
                )) AS pvt
    GROUP BY pvt.[User]
    ORDER BY pvt.[User]
/*
    DECLARE @PivotList AS NVARCHAR(4000)
    DECLARE @PivotListSum AS NVARCHAR(4000)
    DECLARE @SqlQuery AS NVARCHAR(4000)
    DROP TABLE IF EXISTS #mp;

    SELECT DISTINCT 
        MONTH(ServiceStartDate) AS [MoNum]
        ,DATENAME(Month,[ServiceStartDate]) AS [MonthName]
    INTO #mp  
    FROM [dbo].[Order] AS o
    ORDER BY [MoNum]

    SELECT 
        @PivotList = COALESCE(@PivotList + ',','') + QUOTENAME([MonthName])
        ,@PivotListSum = COALESCE(@PivotListSum + ',','') + CONCAT('SUM([',[MonthName],']) AS ', QUOTENAME([MonthName]))
    FROM #mp 

    SELECT @SqlQuery = N'SELECT [User], '+ @PivotListSum +' 
    FROM #a AS p  
    PIVOT  
    (  
    SUM([ServiceCount])
    FOR [MonthName]  IN ('+ @PivotList +')
    ) AS pvt  
    GROUP BY pvt.[User]
    ORDER BY pvt.[User]
    '

    SELECT @SqlQuery
    --EXEC @SqlQuery
    */

    