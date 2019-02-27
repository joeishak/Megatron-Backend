-- Trigger to check if a user exists, if not it inserts the user and adds a setting for them automatically
/****** Object:  Trigger [dbo].[UserDoesExist]    Script Date: 2/4/2019 10:30:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE trigger [dbo].[UserDoesExist] on [dbo].[Users]
instead of Insert
as 
declare @totalUsersWithCode as Int
declare @insertedCode as varchar(30)
declare @insertedfName as varchar(50)
declare @insertedlName as varchar(50)
declare @insertedEmail as varchar(50)

Set @insertedCode = (Select id from inserted)
Set @insertedfName = (Select fName from inserted)
Set @insertedlName = (Select lName from inserted)
Set @insertedEmail = (Select email from inserted)

Set @totalUsersWithCode = (select count(*) from users where id like @insertedCode)
if(@totalUsersWithCode = 0)
begin
	insert into users (id, fName, lName, email) values(@insertedCode, @insertedfName, @insertedlName, @insertedEmail);
	insert into Settings ( userid, defaultQuarter,defaultSegment, defaultSummaryView, defaultFinKpi, defaultJournKpi,geoFilters,productFilters,subscriptionFilters,routeFilters,marketFilters)  
	values( @insertedCode, '2018-Q3', 'DIGITAL MEDIA', 'Financial','1','1','[]','[]','[]','[]','[]')
end

select * from settings where userid like @insertedCode
GO

ALTER TABLE [dbo].[Users] ENABLE TRIGGER [UserDoesExist]
GO


