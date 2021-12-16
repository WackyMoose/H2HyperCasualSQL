
USE Tanx
GO

CREATE TABLE [Users] 
(
	[PlayerId] int NOT NULL PRIMARY KEY,
	[PlayerName] NVARCHAR(32) NOT NULL,
	[Password] NVARCHAR(32) NOT NULL
);

CREATE TABLE [Players]
(
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[PlayerName] NVARCHAR(32) NOT NULL,
	[Kills] INT NOT NULL DEFAULT 0,
	[Deaths] INT NOT NULL DEFAULT 0
);

CREATE TABLE [Matches]
(
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[MatchStatusId] INT NOT NULL,
	[WinnerPlayerId] INT NOT NULL,
	[PlayTime] INT NOT NULL
);

CREATE TABLE [PlayerMatches] 
(
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[PlayerId] int NOT NULL,
	[MatchId] int NOT NULL,
	[PlayerMatchKills] INT NOT NULL DEFAULT 0,
	[PlayerMatchDeaths] INT NOT NULL DEFAULT 0
);

CREATE TABLE [MatchKills]
(
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[MatchId] int NOT NULL,
	[KillerPlayerId] int NOT NULL,
	[KilledPlayerId] int NOT NULL,
	[KillDistance] int NOT NULL
);

CREATE TABLE [MatchStatus]
(
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[StatusName] NVARCHAR(32) NOT NULL
);

CREATE TABLE [Logs] 
(
   [Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
   [Message] nvarchar(max) NULL,
   [MessageTemplate] nvarchar(max) NULL,
   [Level] nvarchar(128) NULL,
   [TimeStamp] datetime NOT NULL,
   [Exception] nvarchar(max) NULL,
   [Properties] nvarchar(max) NULL
);

CREATE TABLE [ErrorLogs]
(
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Message] nvarchar(max) NULL,
	[TimeStamp] datetime NOT NULL
);