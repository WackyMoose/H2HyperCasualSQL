USE [Tanx]
GO
/****** Object:  Trigger [dbo].[SendEmail]    Script Date: 14-12-2021 10:59:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[SendEmail]   
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
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'LogEmail',
		@recipients = 'kingodk@outlook.dk',
		@subject = @Subject,
		@body = @Body,
		@importance = 'HIGH'

END	-- END OF IF STATEMENT
END -- END OF TRIGGER
