--

use Tanx
go

create procedure CreateLeaderBoard @Top int
as
	select top (@Top)
		p.PlayerName, 
		p.Kills,
		p.Deaths,
		(case 
			when p.Kills = 0 then 0
			when p.Deaths = 0 then 0
			else round( cast(p.Kills as float) / cast(p.Deaths as float), 2)
		end) AS KDR 
	from Players p
	order by KDR desc
go;

create procedure GetPlayerById @Id int
as
	SELECT p.*, u.*, m.*, ms.* 
	FROM [Tanx].[dbo].[Players] AS p
	INNER JOIN [Tanx].[dbo].[PlayerMatches] as pm ON pm.PlayerId = p.Id
	INNER JOIN [Tanx].[dbo].[Matches] as m ON m.Id = pm.MatchId
	INNER JOIN [Tanx].[dbo].[Users] AS u ON u.PlayerId = p.Id
	INNER JOIN [Tanx].[dbo].[MatchStatus] as ms ON ms.Id = m.MatchStatusId
	WHERE p.Id = @Id;
go;

create procedure GetPlayerByIdMinimal @Id int
as
	SELECT p.*, u.*, m.*, ms.* 
	FROM [Tanx].[dbo].[Players] AS p
	INNER JOIN [Tanx].[dbo].[PlayerMatches] as pm ON pm.PlayerId = p.Id
	INNER JOIN [Tanx].[dbo].[Matches] as m ON m.Id = pm.MatchId
	INNER JOIN [Tanx].[dbo].[Users] AS u ON u.PlayerId = p.Id
	INNER JOIN [Tanx].[dbo].[MatchStatus] as ms ON ms.Id = m.MatchStatusId
	WHERE p.Id = @Id;
go;