DROP TYPE IF EXISTS ROLE;
CREATE TYPE ROLE AS ENUM ('COORD', 'MEMBER');

DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	userID SERIAL PRIMARY KEY NOT NULL,
	username VARCHAR(25) NOT NULL UNIQUE,
	password VARCHAR(512) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	joinDate TIMESTAMP NOT NULL,
	lastLogout TIMESTAMP NOT NULL,
	birthday DATE,
	education VARCHAR(25),
	CONSTRAINT joinBeforeLogout CHECK (lastLogout > joinDate)
);
DROP TABLE IF EXISTS Project;
CREATE TABLE Project(
	projectID SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(25) UNIQUE NOT NULL,
	creator INT REFERENCES Users(userID) NOT NULL,
	creationDate TIMESTAMP NOT NULL
);
DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles(
	userID INT REFERENCES Users(userID) NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	roleAssigned ROLE NOT NULL,
	PRIMARY KEY(userID, projectID)
);
DROP TABLE IF EXISTS TaskList;
CREATE TABLE TaskList(
	taskLiID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	name VARCHAR(25) NOT NULL,
	UNIQUE(projectID, name)
);

DROP TABLE IF EXISTS Task;
CREATE TABLE Task(
	taskID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	creator INT REFERENCES Users(userID) NOT NULL,
	assignee INT REFERENCES Users(userID),
	name VARCHAR(50) NOT NULL,
	taskLiID INT REFERENCES TaskList(taskLiID),
	creationInfo TIMESTAMP,
	UNIQUE(projectID, name)
);
DROP TABLE IF EXISTS TaskLabel;
CREATE TABLE TaskLabel(
	taskLID SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(15)
);
DROP TABLE IF EXISTS TaskToLabel;
CREATE TABLE TaskToLabel(
	taskID INT REFERENCES Task(taskID) NOT NULL,
	taskLID INT REFERENCES TaskLabel(taskLID) NOT NULL,
	PRIMARY KEY(taskID, taskLID)
);
DROP TABLE IF EXISTS TaskComment;
CREATE TABLE TaskComment(
	taskCID SERIAL PRIMARY KEY NOT NULL,
	taskID INT REFERENCES Task(taskID) NOT NULL,
	commentor INT REFERENCES Users(userID) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	text VARCHAR(512) NOT NULL
);
DROP TABLE IF EXISTS Thread;
CREATE TABLE Thread(
	threadID SERIAL PRIMARY KEY NOT NULL,
	projectID INT REFERENCES Project(projectID) NOT NULL,
	creator INT REFERENCES Users(userID) NOT NULL,
	name VARCHAR(50) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	UNIQUE(projectID, name)
);
DROP TABLE IF EXISTS Comment;
CREATE TABLE Comment(
	commentID SERIAL PRIMARY KEY NOT NULL,
	threadID INT REFERENCES Thread(threadID) NOT NULL,
	commentor INT REFERENCES Users(userID) NOT NULL,
	creationInfo TIMESTAMP NOT NULL,
	text VARCHAR(512) NOT NULL
);
DROP TABLE IF EXISTS ThreadLabel;
CREATE TABLE ThreadLabel(
	threadLID SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(15) NOT NULL
);
DROP TABLE IF EXISTS ThreadToLabel;
CREATE TABLE ThreadToLabel(
	threadID INT REFERENCES Thread(threadID),
	threadLID INT REFERENCES ThreadLabel(threadLID),
	PRIMARY KEY(threadID, threadLID)
);

CREATE FUNCTION ck_proj_date() RETURNS TRIGGER AS
$ck_proj_date$
BEGIN
IF NEW.creationDate <= (SELECT joinDate FROM Users WHERE NEW.creator = userID) THEN
RAISE EXCEPTION 'creationDate can not be smaller than the user join date';
END IF;
RETURN NEW;
END
$ck_proj_date$
LANGUAGE plpgsql;

CREATE TRIGGER ck_proj_date BEFORE 
INSERT ON Project
FOR EACH ROW
EXECUTE PROCEDURE ck_proj_date();
