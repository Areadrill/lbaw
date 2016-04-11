CREATE FUNCTION creator_insert() RETURNS TRIGGER AS
$creator_insert$
BEGIN
  INSERT INTO ROLES VALUES(NEW.userID, NEW.projectID, 'COORD');
  RETURN NEW;
END
$creator_insert$
LANGUAGE plpgsql;

CREATE TRIGGER creator_insert AFTER
INSERT ON Project
FOR EACH ROW
EXECUTE PROCEDURE creator_insert();

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

CREATE FUNCTION ck_thread_date() RETURNS TRIGGER AS
$ck_thread_date$
BEGIN
IF NEW.creationInfo <= (SELECT creationDate FROM Project WHERE NEW.projectID = projectID) THEN
RAISE EXCEPTION 'Thread creation TIMESTAMP can not be smaller than the project creation TIMESTAMP';
END IF;
RETURN NEW;
END
$ck_thread_date$
LANGUAGE plpgsql;

CREATE TRIGGER ck_thread_date BEFORE
INSERT ON Thread
FOR EACH ROW
EXECUTE PROCEDURE ck_thread_date();

CREATE FUNCTION ck_comment_date() RETURNS TRIGGER AS
$ck_comment_date$
BEGIN
IF NEW.creationInfo <= (SELECT creationInfo FROM Thread WHERE NEW.threadID = threadID) THEN
RAISE EXCEPTION 'Comment creation TIMESTAMP can not be smaller than the thread creation TIMESTAMP';
END IF;
RETURN NEW;
END
$ck_comment_date$
LANGUAGE plpgsql;

CREATE TRIGGER ck_comment_date BEFORE
INSERT ON Comment
FOR EACH ROW
EXECUTE PROCEDURE ck_comment_date();

CREATE FUNCTION ck_task_date() RETURNS TRIGGER AS
$ck_task_date$
BEGIN
IF NEW.creationInfo <= (SELECT creationDate FROM Project WHERE NEW.projectID = projectID) THEN
RAISE EXCEPTION 'Task creation TIMESTAMP can not be smaller than the project creation TIMESTAMP';
END IF;
RETURN NEW;
END
$ck_task_date$
LANGUAGE plpgsql;

CREATE TRIGGER ck_task_date BEFORE
INSERT ON Task
FOR EACH ROW
EXECUTE PROCEDURE ck_task_date();

CREATE FUNCTION ck_task_comment_date() RETURNS TRIGGER AS
$ck_task_comment_date$
BEGIN
IF NEW.creationInfo <= (SELECT creationInfo FROM Task WHERE NEW.taskID = taskID) THEN
RAISE EXCEPTION 'Task comment creation TIMESTAMP can not be smaller than the task creation TIMESTAMP';
END IF;
RETURN NEW;
END
$ck_task_comment_date$
LANGUAGE plpgsql;

CREATE TRIGGER ck_task_comment_date BEFORE
INSERT ON TaskComment
FOR EACH ROW
EXECUTE PROCEDURE ck_task_comment_date();
