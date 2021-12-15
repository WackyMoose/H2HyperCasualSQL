use Tanx

declare @Id int = 1;

SELECT p.*, u.*, m.*, ms.* FROM [Tanx].[dbo].[Players] AS p
INNER JOIN [Tanx].[dbo].[PlayerMatches] as pm ON pm.PlayerId = p.Id
INNER JOIN [Tanx].[dbo].[Matches] as m ON m.Id = pm.MatchId
INNER JOIN [Tanx].[dbo].[Users] AS u ON u.PlayerId = p.Id
INNER JOIN [Tanx].[dbo].[MatchStatus] as ms ON ms.Id = m.MatchStatusId
WHERE p.Id = @Id;

--CREATE VIEW [Brazil Customers] AS
--SELECT CustomerName, ContactName
--FROM Customers
--WHERE Country = 'Brazil';