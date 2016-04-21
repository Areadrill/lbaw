SET SCHEMA 'proto';
DROP INDEX IF EXISTS roles_projectid_index;
CREATE INDEX roles_projectid_index ON Roles USING hash(projectid);

DROP INDEX IF EXISTS thread_projectid_index;
CREATE INDEX thread_projectid_index ON Thread USING btree(projectid);
CLUSTER Thread USING thread_projectid_index;

DROP INDEX IF EXISTS task_projectid_index;
CREATE INDEX task_projectid_index ON Task USING btree(projectid);
CLUSTER Task USING task_projectid_index;

DROP INDEX IF EXISTS taskcomment_taskid_index;
CREATE INDEX taskcomment_taskid_index ON TaskComment USING btree(taskid);
CLUSTER TaskComment USING taskcomment_taskid_index;

DROP INDEX IF EXISTS comment_threadid_index;
CREATE INDEX comment_threadid_index ON Comment USING btree(threadid);
CLUSTER Comment USING comment_threadid_index;

DROP INDEX IF EXISTS projectname_fts;
CREATE INDEX projectname_fts ON Project USING gin(to_tsvector('english', name));

DROP INDEX IF EXISTS passwordrecovery_index;
CREATE INDEX passwordrecovery_index ON PasswordRecovery USING hash(uniqueidentifier);
