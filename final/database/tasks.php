<?php
include_once('members.php');

include_once('users.php');

function getTasks($projID){
	global $conn;
	$stmt = $conn->prepare("SELECT taskid, name FROM Task WHERE projectid = :projectid");
	$stmt->bindParam(":projectid", $projID);
	$stmt->execute();
	$result = $stmt->fetchAll();

	for ($i = 0; $i < count($result); $i++){
		$result[$i]['taskLabels'] = getTaskLabels($result[$i]['taskid']);
	}
	return $result;
}

function getTaskLabels($taskID) {
	global $conn;
	$stmt = $conn->prepare("SELECT tasklid, name FROM TaskLabel WHERE TaskLID IN (SELECT tasklid FROM TaskToLabel WHERE taskid = ?)");
	$stmt->execute(array($taskID));
	$res = $stmt->fetchAll();

	return $res;
}

function getLabelsNotInTask($taskID, $projectid) {
	global $conn;
	$stmt = $conn->prepare("SELECT tasklid, name FROM TaskLabel WHERE projectid = ? AND tasklid NOT IN (SELECT tasklid FROM TaskToLabel WHERE taskid = ?)");
	$stmt->execute(array($projectid, $taskID));
	$res = $stmt->fetchAll();

	return $res;
}
function filterTask($tasklabelid,$projid,$userid){

	if(checkPrivilege($userid, $projid) != "COORD"){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}
	global $conn;

	$stmt = $conn->prepare("SELECT Task.taskid, Task.name FROM Task, TaskLabel, TaskToLabel WHERE TaskLabel.tasklid = ? AND TaskToLabel.tasklid = TaskLabel.tasklid AND TaskToLabel.taskid = Task.taskid");
	$stmt->execute(array($tasklabelid));

	$res = $stmt->fetchAll();
	for($i = 0; $i < count($res); $i++){
			$res[$i]['taskLabels'] = getTaskLabels($res[$i]['taskid']);
	}

	return $res;
}

function getTaskInfo($taskID){
	global $conn;
	$stmt = $conn->prepare("SELECT Task.name AS name, creator, assignee, complete, creationinfo, Tasklist.taskliid, Tasklist.name AS tasklistName FROM Task, Tasklist WHERE Task.taskid = ? AND (Task.taskliid = Tasklist.taskliid OR Task.taskliid IS NULL)");
	$stmt->execute(array($taskID));
	$res = $stmt->fetch();
	$res['creatorName'] = getUsername($res['creator']);
	$res['assigneeName'] = getUsername($res['assignee']);
	$res['tasklistName'] = getTasklistName($res['taskliid']);
	return $res;
}
function getTasklistName($taskliID){
	global $conn;
	$stmt = $conn->prepare("SELECT name FROM tasklist WHERE taskliid = ?");
	$stmt->execute(array($taskliID));
	return $stmt->fetch();
}

function getProjIDTaskID($taskID){
	global $conn;
	$stmt = $conn->prepare("SELECT projectid FROM Task WHERE taskid = ?");
	$stmt->execute(array($taskID));
	return $stmt->fetch();
}
function getTaskComments($taskID){
	global $conn;
	$stmt = $conn->prepare('SELECT taskcid, commentor, creationinfo, text FROM TaskComment WHERE taskid = ? ORDER BY creationinfo ASC');
	$stmt->execute(array($taskID));
	$results = $stmt->fetchAll();
	for ($i = 0; $i < count($results); $i++){
		$results[$i]['commentorname'] = getUsername($results[$i]['commentor']);
	}

	return $results;
}

function deleteTask($userID, $taskID){
	global $conn;
	if (checkPrivilege($userID, getProjectByTask($taskID)) !== "COORD"){
		return "NO_PERM";
	}
	$stmt = $conn->prepare('DELETE FROM Task WHERE taskid =? RETURNING *');
	$stmt->execute(array($taskID));
	if (count($stmt->fetchAll()) == 0)
		return "ERROR";
	return "SUCCESS";
}

function getProjectByTask($taskID){
	global $conn;
	$stmt = $conn->prepare('SELECT projectid FROM task WHERE taskid = ?');
	$stmt->execute(array($taskID));
	return $stmt->fetch()['projectid'];
}

function markTaskCompleted($taskID, $complete){
	global $conn;
	$stmt = $conn->prepare('UPDATE task SET complete = ? WHERE taskid= ?');
	return	$stmt->execute(array($complete, $taskID));
}

function createComment($taskID, $body, $userid){
	global $conn;
	$stmt = $conn->prepare("INSERT INTO taskcomment VALUES (default, ?, ?, clock_timestamp(), ?) RETURNING taskcid");
	$res = $stmt->execute(array($taskID, $userid, $body));
	if (!$res)
	return $res;
	else
		return $stmt->fetch()['taskcid'];
}

function createTask($name,$project, $creator, $text){
	global $conn;
	if(checkPrivilege($creator, $project) == "NONE")
		return 'NO_PRIVILEGE';
	$stmt = $conn->prepare(' INSERT INTO Task VALUES (default, ?, ?, NULL, ?, false, NULL, clock_timestamp()) RETURNING taskid');
	$taskIns = $stmt->execute(array($project, $creator, $name));
	$taskid = $stmt->fetchColumn();

	if (!$taskIns)
		return 'FAIL_INSERT';

	$stmt = $conn->prepare(' INSERT INTO TaskComment VALUES (default, ?, ?, clock_timestamp(), ?)');
	$taskcIns = $stmt->execute(array($taskid, $creator, $text));
	return $taskid;
}

function assignTask($taskid, $userid){
	global $conn;
	$stmt = $conn->prepare('UPDATE Task SET assignee=? WHERE taskid=?');
	$succ = $stmt->execute(array($userid, $taskid));
	return $succ;
}

function createTaskLabel($name, $projectid){
	global $conn;
	$stmt = $conn->prepare('INSERT INTO TaskLabel VALUES (default, ?, ?)');
	$res = $stmt->execute(array($projectid, $name));
	return $res;
}
function unassignLabelFromTask($userID, $taskID, $taskLID){ //preciso ver se a thread e a label pertencem ao mesmo projeto?
	if((checkPrivilege($userID, getProjectByTask($taskID))) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM TaskToLabel WHERE taskid = ? AND tasklid = ?");
	$stmt->execute(array($taskID, $taskLID));

	return $stmt->fetch() !== false;
}


function assignLabelToTask($userID, $taskID, $taskLID){ //preciso ver se a thread e a label pertencem ao mesmo projeto?
	if((checkPrivilege($userID, getProjectByTask($taskID))) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("INSERT INTO TaskToLabel VALUES(?, ?)");
	$stmt->execute(array($taskID, $taskLID));

	return $stmt->fetch() !== false;
}

function getProjectTaskLabels($projectid){
	global $conn;
	$stmt = $conn->prepare('SELECT TaskLabel.tasklid, name, Count(TaskToLabel.tasklid) as count FROM TaskLabel LEFT JOIN TaskToLabel On TaskLabel.tasklid = TaskToLabel.tasklid WHERE  TaskLabel.projectid = ? GROUP BY TaskLabel.tasklid');
	$stmt->execute(array($projectid));
	$res = $stmt->fetchAll();
	return $res;
}

function getTaskIDCommentID($commentID){
	global $conn;

	$stmt = $conn->prepare("SELECT taskid FROM taskcomment WHERE taskcid = ?");
	$stmt->execute(array($commentID));

	return $stmt->fetch()['taskid'];
}

function getProjIDCommentIDTask($commentID){
	global $conn;

	$stmt = $conn->prepare("SELECT projectid FROM task WHERE taskid = ?");
	$stmt->execute(array(getTaskIDCommentID($commentID)));

	return $stmt->fetch();

}
function deleteTaskComment($userID, $commentID){

	if(checkPrivilege($userID, getProjIDCommentIDTask($commentID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM taskcomment WHERE taskcid = ?");
	$stmt->execute(array($commentID));

	return $stmt->fetch() !== false;

}
?>
