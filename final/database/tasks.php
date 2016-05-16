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

function getTaskInfo($taskID){
	global $conn;
	$stmt = $conn->prepare("SELECT name, creator,assignee, complete, creationinfo, taskliid FROM Task WHERE taskid = ?");
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
	$stmt = $conn->prepare('SELECT taskcid, commentor, creationinfo, text FROM TaskComment WHERE taskid = ?');
	$stmt->execute(array($taskID));
	$results = $stmt->fetchAll();
	for ($i = 0; $i < count($results); $i++){
		$results[$i]['commentorname'] = getUsername($results[$i]['commentor']);
	}
	
	return $results;
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

?>
