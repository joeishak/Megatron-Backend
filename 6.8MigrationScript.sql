-- Script that handles changes for OKTA auth from Front End
-- Makes a copy of Metrics Table
-- Create Metrics Table
Create Table Metrics_new (
id int identity(0,1) primary key,
name varchar(100) null,
description varchar(500) null);
-- Inserts new metrics list into metrics
insert into metrics_new ( name, description)
values ('Finance Net New ARR','NetNewARR'),
('Finance Gross New ARR','GrossNewARR'),
('Finance Cancellations ARR','Cancellations ARR'),
('Finance Renewal@FP ARR','Renewal@FPARR'),
('Discover Marketable Universe','MarketableUniverse'),
('Discover Traffic','Traffic'),
('Discover UQFM Conversion','UQFMConversion'),
('Discover Paid Media Spend','Paid Media Spend'),
('Paid Media Sourced UQFMs','Paid Media Sourced UQFMs'),
('Bounce Rate', 'Bounce Rate'),
('New UQFMs', 'Try New UQFMs'),
('Cumulative UQFMS', 'Try Cumulative UQFMS'),
('New QFMs', 'New QFMs'),
('Cumulative QFMs', 'Try Cumulative QFMs'),
('28 Day New UQFM to QFM', 'Try 28 Day New UQFM to QFM'),
('Cum. UQFM to QFM', 'Try Cum. UQFM to QFM'),
('Gross New ARR', 'Buy Gross New ARR'),
('Gross New Subs', 'Buy Gross New Units'),
('Conversion', 'Buy Conversion'),
('LTV ROI', 'Life Time Value Return on Investment'),
('PM Spend - Buy', 'Buy Paid Media Spend'),
('Marketing Sourced ARR', 'Buy Marketing Sourced ARR'),
('% Activated', 'Use % Activated'),
('Wk 4 WAU Rate', 'Use Wk 4 WAU Rate'),
('Month 1 Return Rate', 'Use Month 1 Return Rate'),
('Low CEI', 'Use Low CEI'),
('Medium CEI', 'Use Medium CEI'),
('High CEI', 'Use High CEI'),
('0 (Inactive) CEI', 'Use 0 (Inactive) CEI'),
('Repeat User MAU', 'Use Repeat User MAU'),
('Cancellations ARR', 'Renew Cancellations ARR'),
('Cancellations ARR', 'Renew Cancellations ARR'),
('QTR Fin Retention Rate', 'Renew QTR Fin Retention Rate'),
('QTR UI Rate', 'Renew QTR UI Rate'),
('QTR PF Rate', 'Renew QTR PF Rate'),
('Cancellations ARR', 'Renew Cancellations ARR'),
('EOT Retention Rate', 'Renew EOT Retention Rate'),
('QTR Fin Retention Rate', 'Renew QTR Fin Retention Rate');

-- Rename old metrics table
sp_rename metrics metrics_old;
-- Rename new Metrics Table
sp_rename metrics_new metrics;

-- Drop Trigger for User Does Exist
Drop trigger dbo.UserDoesExist;

-- Drop Procedures
Drop procedure addUser;
Drop procedure updateSettings;
--Create a procedure to add a user to the database only if they do not exist
create procedure addUser
 @totalUsersWithCode as int,
 @insertedCode as varchar(30),
 @insertedfName as varchar(50),
 @insertedlName as varchar(50),
 @insertedEmail as varchar(50),
 @quarter as varchar(50),
 @segment as varchar(50),
 @nonDmSegment as varchar(5000),

as
update  users
Set @totalUsersWithCode = (select count(*) from users where id like @insertedCode)
if(@totalUsersWithCode = 0)
begin
	insert into users (id, fName, lName, email) values(@insertedCode, @insertedfName, @insertedlName, @insertedEmail);
	insert into Settings ( userid, defaultQuarter,defaultSegment,nondmsegments,signupsource,geoFilters,productFilters,subscriptionFilters,routeFilters,marketFilters)  
	values( @insertedCode, @quarter, @segment,@nonDmSegment,'[]','[]','[]','[]','[]','[]')
end

select * from settings where userid like @insertedCode
GO
--Create Procedure to update the settings for the user 
create procedure updateSettings
    @quarter varchar(50),
    @segment varchar(50),
    @user varchar(50),
    @geos varchar(5000),
    @subscriptions varchar(5000),
    @products varchar(5000),
    @routes varchar(5000),
    @markets varchar(5000),
    @nonDmSegment as varchar(5000),
    @signupsource as varchar(5000)
as
update  settings
set defaultQuarter = @quarter,
	defaultSegment= @segment,
	geoFilters = @geos,
	subscriptionFilters = @subscriptions,
	productFilters = @products,
	routeFilters = @routes,
	marketFilters = @markets,
	nondmsegments = @nonDmSegment,
	signupsource = @signupsource
where userid = @user;
select * from settings where userid = @user;