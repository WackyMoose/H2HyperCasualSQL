-- Version 1.0

use Tanx
go

alter table [Users]
add foreign key (PlayerId) references Players(Id);
go

alter table [PlayerMatches]
add foreign key (PlayerId) references Players(Id);
go

alter table [PlayerMatches]
add foreign key (MatchId) references Matches(Id);
go

alter table [Matches]
add foreign key (WinnerPlayerId) references Players(Id);
go

alter table [Matches]
add foreign key (MatchStatusId) references MatchStatus(Id);
go

alter table [MatchKills]
add foreign key (MatchId) references Matches(Id);
go