--CommentIndicatortest
select MetricId, count(*) from comments c, metrics m where m.id = c.metricid group by metricid

--fetchComments
select c.id, c.metricId, c.postTimeStamp, c.userId, c.comment, (select u.fName from [rtb].[dbo].[Users] u WHERE u.id = c.userId ) as 'firstName', (select u.lName from [rtb].[dbo].[Users] u WHERE u.id = c.userId ) as 'lastName'
from [rtb].[dbo].[Comments] c where metricId = CAST(@metric as int)

--fetchCommentsCount
Select metricId, (select m.[name] from Metrics m where m.id = metricId ) as 'type', count(comment) as 'commentCount' from Comments GROUP BY metricId;

--fetchReplies
select r.id, r.userId, r.postTimeStamp, r.commentId, r.reply, 
(select u.fName from [rtb].[dbo].[Users] u WHERE u.id = r.userId ) as 'firstName',
(select u.lName from [rtb].[dbo].[Users] u WHERE u.id = r.userId ) as 'lastName'
from [rtb].[dbo].[Replies] r WHERE commentId IN (@params)

--GetUserSettings
Select * from settings where userId = '@sub'

--NewUser
Insert Into Users (id, fName, lName, email)
Values('@sub', '@fName', '@lName', '@email')

--postComments
exec postComment  '@userId', @metricId, '@postDateTime', '@comment'

--postReply
exec postReply  '@userId', '@postDateTime', @commentId, '@comment'

--UpdateSettings
exec updateSettings '@quarter', '@segment','@user', '@geos',  '@subscriptions', '@products', '@routes', '@markets'