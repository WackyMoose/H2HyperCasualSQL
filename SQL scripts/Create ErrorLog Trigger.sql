USE Tanx
GO

CREATE TRIGGER [dbo].LogError   
   ON  [Tanx].[dbo].[Logs]
   AFTER INSERT
AS 

BEGIN

	SET NOCOUNT ON;

	DECLARE @LogLevel NVARCHAR(128) = (SELECT INSERTED.[Level] FROM INSERTED)

	IF @LogLevel = 'Warning' OR @LogLevel = 'Error' OR @LogLevel = 'Fatal'
	BEGIN
	
		DECLARE @Message NVARCHAR(MAX) = (SELECT INSERTED.[Message] FROM INSERTED)
		DECLARE @TimeStamp DATETIME = (SELECT INSERTED.[TimeStamp] FROM INSERTED)

		insert into [Tanx].[dbo].[ErrorLogs] (Message, TimeStamp) Values
			(@Message, @TimeStamp)

	END
END



