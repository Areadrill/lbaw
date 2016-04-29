SET search_path TO proto;

DROP TYPE IF EXISTS ROLE;
CREATE TYPE ROLE AS ENUM ('COORD', 'MEMBER');

DROP TABLE IF EXISTS Users CASCADE;
CREATE TABLE Users(
	userID SERIAL PRIMARY KEY NOT NULL,
	username VARCHAR(25) NOT NULL CONSTRAINT unique_username UNIQUE,
	password VARCHAR(256) NOT NULL,
	salt VARCHAR(256) NOT NULL,
	email VARCHAR(100) NOT NULL CONSTRAINT unique_email UNIQUE,
	joinDate TIMESTAMP NOT NULL,
	lastLogout TIMESTAMP NOT NULL,
	location VARCHAR(25),
	birthday DATE,
	education VARCHAR(25),
	CONSTRAINT joinBeforeLogout CHECK (lastLogout > joinDate)
);
DROP TABLE IF EXISTS Project CASCADE;
CREATE TABLE Project(
	projectID SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(25) NOT NULL,
	description TEXT NOT NULL,
	creator INT REFERENCES Users(userID) ON DELETE CASCADE NOT NULL,
	creationDate TIMESTAMP NOT NULL,
	CONSTRAINT unique_projNameForCreator UNIQUE(projectID, name)
);
DROP TABLE IF EXISTS Roles CASCADE;
CREATE TABLE Roles(
	userID INT REFERENCES Users(userID) ON DELETE CASCADE NOT NULL,
	projectID INT REFERENCES Project(projectID) ON DELETE CASCADE NOT NULL,
	roleAssigned ROLE NOT NULL,
	PRIMARY KEY(userID, projectID)
);
DROP TABLE IF EXISTS TaskList CASCADE;
CREATE TABLE TaskList(
	taskLiID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) ON DELETE CASCADE NOT NULL,
	name VARCHAR(25) NOT NULL,
	CONSTRAINT unique_taskListNameInProj UNIQUE(projectID, name)
);

DROP TABLE IF EXISTS Task CASCADE;
CREATE TABLE Task(
	taskID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) ON DELETE CASCADE NOT NULL,
	creator INT REFERENCES Users(userID) NOT NULL,
	assignee INT REFERENCES Users(userID) ON DELETE SET NULL,
	name VARCHAR(50) NOT NULL,
	complete BOOLEAN NOT NULL,
	taskLiID INT REFERENCES TaskList(taskLiID),
	creationInfo TIMESTAMP,
	CONSTRAINT unique_taskNameInProj UNIQUE(projectID, name)
);
DROP TABLE IF EXISTS TaskLabel CASCADE;
CREATE TABLE TaskLabel(
	taskLID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) ON DELETE CASCADE NOT NULL,
	name VARCHAR(15),
	CONSTRAINT unique_labelIsProjScope UNIQUE(taskLID, projectID)
);
DROP TABLE IF EXISTS TaskToLabel CASCADE;
CREATE TABLE TaskToLabel(
	taskID INT REFERENCES Task(taskID) ON DELETE CASCADE NOT NULL,
	taskLID INT REFERENCES TaskLabel(taskLID) ON DELETE CASCADE NOT NULL,
	PRIMARY KEY(taskID, taskLID)
);
DROP TABLE IF EXISTS TaskComment;
CREATE TABLE TaskComment(
	taskCID SERIAL PRIMARY KEY NOT NULL,
	taskID INT REFERENCES Task(taskID) ON DELETE CASCADE NOT NULL,
	commentor INT REFERENCES Users(userID) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	text VARCHAR(512) NOT NULL
);
DROP TABLE IF EXISTS Thread;
CREATE TABLE Thread(
	threadID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) ON DELETE CASCADE NOT NULL,
	creator INT REFERENCES Users(userID) NOT NULL,
	name VARCHAR(50) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	CONSTRAINT unique_threadNameInProj UNIQUE(projectID, name)
);
DROP TABLE IF EXISTS Comment;
CREATE TABLE Comment(
	commentID SERIAL PRIMARY KEY NOT NULL,
	threadID INT REFERENCES Thread(threadID) ON DELETE CASCADE NOT NULL,
	commentor INT REFERENCES Users(userID) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	text VARCHAR(512) NOT NULL
);
DROP TABLE IF EXISTS ThreadLabel;
CREATE TABLE ThreadLabel(
	threadLID SERIAL PRIMARY KEY NOT NULL,
	projectID int REFERENCES Project(projectID) ON DELETE CASCADE NOT NULL,
	name VARCHAR(15) NOT NULL,
	CONSTRAINT unique_threadLabelIsProjScope UNIQUE(threadLID, projectID)
);
DROP TABLE IF EXISTS ThreadToLabel;
CREATE TABLE ThreadToLabel(
	threadID INT REFERENCES Thread(threadID) ON DELETE CASCADE,
	threadLID INT REFERENCES ThreadLabel(threadLID) ON DELETE CASCADE,
	PRIMARY KEY(threadID, threadLID)
);

DROP TABLE IF EXISTS PasswordRecovery;
CREATE TABLE PasswordRecovery(
	passwordRecoveryId SERIAL PRIMARY KEY NOT NULL,
	userid int REFERENCES Users(userID) ON DELETE CASCADE NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	uniqueIdentifier UUID NOT NULL,
	CONSTRAINT unique_uuid UNIQUE(uniqueIdentifier)
);
