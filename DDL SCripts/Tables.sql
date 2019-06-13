-- Create Users Table
Create Table Users (
id	varchar(50)  primary key,
fName varchar(50) null,
lName varchar(50) null,
email varchar(50) null
);

-- Create Settings Table
Create Table Settings (
settingId int identity (1,5) primary key,
userId varchar(50) not null,
defaultQuarter varchar(10) null,
defaultSegment varchar(50) null,
geoFilters varchar(5000),
productFilters varchar(5000),
subscriptionFilters varchar(5000),
signupsource varchar(5000),
nondmsegments varchar(5000),
routeFilters varchar(5000),
marketFilters varchar(5000),
CONSTRAINT SETTING_USER_ID_FOREIGN_KEY FOREIGN KEY(USERiD) REFERENCES users(id)
);

-- Create Metrics Table
Create Table Metrics (
id int identity(0,1) primary key,
name varchar(100) null,
description varchar(500) null);

-- Create Comments Table
Create Table Comments(
id int identity(1,1) primary key,
userId varchar(50) not null,
metricId int not null,
comment varchar(2000) null,
postTimeStamp datetime NOT NULL,
constraint COMMENT_USER_ID_FOREIGN_KEY foreign key(userId) references Users(id),
constraint COMMENT_METRIC_ID_FOREIGN_KEY foreign key(metricId) references Metrics(id));

-- Create Replies Table
Create Table Replies (
id int identity(1,2000) primary key,
userId varchar(50) not null,
commentId int not null,
postTimeStamp datetime NOT NULL,
reply varchar(2000) null,
constraint REPLY_USER_ID_FOREIGN_KEY foreign key(userId) references Users(id),
constraint REPLY_COMMENT_ID_FOREIGN_KEY foreign key(commentId) references Comments(id));


create table feedback (
    id int identity(1,1) primary key, 
    userId  varchar(50),
    feature varchar(50),
    message varchar(250),
    type varchar(20)
)