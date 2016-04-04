CREATE TYPE ROLE AS ENUM ('COORD', 'MEMBER');
 
CREATE TABLE USER(
	userID INT SERIAL PRIMARY KEY NOT NULL,
	username VARCHAR(25) NOT NULL UNIQUE,
	password VARCHAR(512) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	joinDate TIMASTAMP NOT NULL,
	lastLogout TIMESTAMP NOT NULL,
	birthday DATE,
	education VARCHAR(25),
	CONSTRAINT joinBeforeLogout CHECK (lastLogout > joinDate)
);
 
CREATE TABLE Project(
	projectID INT SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(25) UNIQUE NOT NULL,
	creator INT REFERENCES USER(userID),
	creationDate TIMESTAMP NOT NULL,
	CONSTRAINT joinBeforeCreating CHECK (creationDate > creator.joinDate)
);
 
CREATE TABLE ROLE(
	userID INT REFERENCES USER(userID) NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	ROLE ROLE NOT NULL,
	CONSTRAINT chk_role CHECK (ROLE IN ('COORD', 'MEMBER')),
	PRIMARY KEY(userID, projectID)
);
 
CREATE TABLE TaskList(
	taskLiID INT SERIAL PRIMARY KEY NOT NULL,
	name VARCAHR(25) NOT NULL
);
 
 
CREATE TABLE Task(
	taskID INT SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	creator INT REFERENCES USER(userID) NOT NULL,
	assignee INT REFERENCES USER(userID),
	name VARCHAR(25) NOT NULL,
	taskLiID INT REFERENCES TaskList(taskLiID),
	creationInfo TIMESTAMP,
	CONSTRAINT createBeforeTask CHECK (creationInfo > projectID.creationDate),
        UNIQUE(projectID, name)
);
 
CREATE TABLE TaskLabel(
	taskLID INT SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(15)
);
 
CREATE TABLE TaskToLabel(
	taskID INT REFERENCES Task(taskID) NOT NULL,
	taskLID INT REFERENCES TaskLabel(taskLID) NOT NULL,
	PRIMARY KEY(taskID, taskLID)
);
 
CREATE TABLE TaskComment(
	taskCID INT SERIAL PRIMARY KEY NOT NULL,
	taskID INT REFERENCES Task(taskID) NOT NULL,
	commenter INT REFERENCES USER(userID) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	text VARCHAR(512) NOT NULL,
	CONSTRAINT createBeforeComment CHECK (creationInfo > taskID.creationInfo)
);
 
CREATE TABLE Thread(
	threadID INT SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	creator INT REFERENCES USER(userID) NOT NULL,
	name VARCHAR(25) NOT NULL,
	creationInfo TIEMSTAMP NOT NULL,
	CONSTRAINT createBeforeThread CHECK (creationInfo > projectID.creationDate),
        UNIQUE(projectID, name)
);
 
CREATE TABLE Comment(
	commentID INT SERIAL PRIMARY KEY NOT NULL,
	threadID INT REFERENCES Thread(threadID) NOT NULL,
	commenter INT REFERENCES USER(userID) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	text VARCHAR(512) NOT NULL,
	CONSTRAINT createBeforeComment CHECK (creationInfo > threadID.creationInfo)
);
 
CREATE TABLE ThreadLabel(
	threadLID INT SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(15) NOT NULL
);
 
CREATE TABLE ThreadToLabel(
	threadID INT REFERENCES Thread(threadID),
	threadLID INT REFERENCES ThreadLabel(threadLID),
	PRIMARY KEY(threadID, threadLID)
);
