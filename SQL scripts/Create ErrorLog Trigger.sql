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
			DECLARE @Subject NVARCHAR(MAX) = 'Trigger triggered [Level: ' + @LogLevel + ']'
			DECLARE @Body NVARCHAR(MAX) = 'Message: ' + @Message
			DECLARE @TimeStamp DATETIME = (SELECT INSERTED.[TimeStamp] FROM INSERTED)

			insert into [Tanx].[dbo].[ErrorLogs] (Message, TimeStamp) Values
				(@Message, @TimeStamp)

	END
END