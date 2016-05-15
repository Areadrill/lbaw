<?php
include_once('members.php');
include_once('users.php');

function getTasks($projID){
	global $conn;
	$stmt = $conn->prepare("SELECT taskid, name FROM Task WHERE projectid = :projectid");
	$stmt->bindParam(":projectid", $projID);
	$stmt->execute();
	$result = $stmt->fetchAll();

	for ($i = 0; $i < count($res); $i++){
		$result['i']['taskLabels'] = getTaskLabels($res[$i]['taskid']);
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
	$stmt = $conn->prepare("SELECT name, creator,assignee, complete creationinfo FROM Task WHERE taskid = ?");
	$stmt->execute(array($taskID));
	$res = $stmt->fetch();
	$res['creatorName'] = getUsername($res['creator']);
	return $res;
}

function getProjIDTaskID($taskID){
	global $conn;
	$stmt = $conn->prepare("SELECT projectid FROM Task WHERE taskid = ?");
	$stmt->execute(array($taskID));
	return $stmt->fetch();
}

?>
