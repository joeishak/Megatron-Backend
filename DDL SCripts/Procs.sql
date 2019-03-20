--Create Procedure to update the settings for the user 
create procedure updateSettings
@quarter varchar(50),
@segment varchar(50),
@user varchar(50),
@geos varchar(5000),
@subscriptions varchar(5000),
@products varchar(5000),
@routes varchar(5000),
@markets varchar(5000)
as
update  settings
set defaultQuarter = @quarter,
	defaultSegment= @segment,
	geoFilters = @geos,
	subscriptionFilters = @subscriptions,
	productFilters = @products,
	routeFilters = @routes,
	marketFilters = @markets
where userid = @user;
select * from settings where userid = @user;

/****** Object:  StoredProcedure [dbo].[postReply]    Script Date: 2/19/2019 4:07:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[postReply]
@userId varchar(50),
@postDateTime datetime,
@commentId int,
@comment varchar(2000)
AS
INSERT INTO Replies values(@userId, CONVERT(datetime, @postDateTime ), @commentId, @comment)
 Select * from replies where userId like @userId and commentId = @commentId and reply = @comment

GO



/****** Object:  StoredProcedure [dbo].[postComment]    Script Date: 2/19/2019 4:07:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[postComment]
@userId varchar(50),
@metricId int,
@postDateTime datetime,
@comment varchar(2000)
AS
 INSERT INTO [Comments] values(@userId, @metricId, CONVERT(datetime, @postDateTime), @comment );
 Select * from comments where metricId like @metricId;

GO



USE [RTB]
GO
USE [RTB]
GO

/****** Object:  StoredProcedure [dbo].[deleteComment]    Script Date: 2/28/2019 9:28:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[deleteComment]
@id varchar(50)

AS
 delete from comments where id = @id;

GO

GO

/****** Object:  StoredProcedure [dbo].[deleteReplies]    Script Date: 2/28/2019 9:28:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[deleteReplies]
@id varchar(50)

AS
 Delete from replies where commentId = @id;

GO


/****** Object:  StoredProcedure [dbo].[addFeedback]    Script Date: 2/28/2019 9:28:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[addFeedback]
@user  varchar(50),
@feature varchar(50),
@message varchar(250),
@type varchar(20)

AS
 Insert into feedback(userId,feature,message,type) Values(@user,@feature,@message,@type);
GO



