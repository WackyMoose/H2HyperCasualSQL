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
	SELECT p.*, u.*
	FROM [Tanx].[dbo].[Players] AS p
	INNER JOIN [Tanx].[dbo].[Users] AS u ON u.PlayerId = p.Id
	WHERE p.Id = @Id;
go

-- Returns 
create procedure GetMatchesByPlayerId @Id int
as
	select 
		pm.MatchId, 
		m.WinnerPlayerId, 
		m.PlayTime 'MatchPlayTime', 
		m.MatchStatusId, 
		ms.StatusName 'MatchStatusName'
	from Players p
	join PlayerMatches pm
	on p.Id = pm.PlayerId
	join Matches m
	on pm.MatchId = m.Id
	join MatchStatus ms
	on m.MatchStatusId = ms.Id
	where p.Id = @Id
	group by pm.MatchId, m.MatchStatusId, m.WinnerPlayerId, m.PlayTime, ms.Id, ms.StatusName
go