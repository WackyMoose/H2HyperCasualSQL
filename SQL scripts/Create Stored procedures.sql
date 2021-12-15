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
go