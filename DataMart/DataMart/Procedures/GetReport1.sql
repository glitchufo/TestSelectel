CREATE PROCEDURE [dbo].[GetReport1]
AS
    WITH a AS (
    SELECT 
        EOMONTH(o.[ServiceStartDate]) AS [Month]
        ,u.[UserName]
        ,COUNT(o.[Id]) AS [CountS]
    FROM [dbo].[Order] AS o
    LEFT JOIN [dbo].[Service] AS s ON o.[ServiceId] = s.[Id]
    LEFT JOIN [dbo].[User] u ON o.[UserId] = u.[Id]
    GROUP BY EOMONTH(o.[ServiceStartDate]) ,u.[UserName]
    )
    ,b AS (
    SELECT 
        * 
        ,ROW_NUMBER() OVER(PARTITION  BY [UserName] ORDER BY [Month]) AS [NumS]
    FROM a
    )
    SELECT 
        [Month] AS [Месяц]
        ,SUM(CountS) AS [Кол-во новых заказов] 
    FROM b
    WHERE [NumS] = 1
    GROUP BY [Month]
    ORDER BY [Month]