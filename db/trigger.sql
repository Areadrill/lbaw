
CREATE FUNCTION creator_insert() RETURNS TRIGGER AS
$creator_insert$
BEGIN
  INSERT INTO ROLES VALUES(NEW.creator, NEW.projectID, 'COORD');
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

CREATE FUNCTION ck_same_projectid_task() RETURNS TRIGGER AS
$ck_same_projectid_task$
BEGIN
IF (SELECT projectID FROM TaskLabel WHERE taskLID = NEW.taskLID) != (SELECT projectID FROM Task WHERE taskID = NEW.taskID) THEN
RAISE EXCEPTION 'TaskLabel is not in this project';
END IF;
RETURN NEW;
END
$ck_same_projectid_task$
LANGUAGE plpgsql;

CREATE TRIGGER ck_same_projectid_task BEFORE INSERT ON TaskToLabel
FOR EACH ROW
EXECUTE PROCEDURE ck_same_projectid_task();

CREATE FUNCTION ck_same_projectid_thread() RETURNS TRIGGER AS
$ck_same_projectid_thread$
BEGIN
IF (SELECT projectID FROM ThreadLabel WHERE threadLID = NEW.threadLID) != (SELECT projectID FROM Thread WHERE threadID = NEW.threadID) THEN
RAISE EXCEPTION 'ThreadLabel is not in this project';
END IF;
RETURN NEW;
END
$ck_same_projectid_thread$
LANGUAGE plpgsql;

CREATE TRIGGER ck_same_projectid_thread BEFORE INSERT ON ThreadToLabel
FOR EACH ROW
EXECUTE PROCEDURE ck_same_projectid_thread();

CREATE FUNCTION ck_same_projectid_tasklist() RETURNS TRIGGER AS
$ck_same_projectid_tasklist$
BEGIN
IF NEW.taskLiID != NULL AND NEW.projectID != (SELECT projectID FROM TaskList WHERE taskLiID = NEW.taskLiID) THEN
RAISE EXCEPTION 'TaskList is not in this project';
END IF;
RETURN NEW;
END
$ck_same_projectid_tasklist$
LANGUAGE plpgsql;

CREATE TRIGGER ck_same_projectid_tasklist BEFORE UPDATE ON TaskToLabel
FOR EACH ROW
EXECUTE PROCEDURE ck_same_projectid_tasklist();