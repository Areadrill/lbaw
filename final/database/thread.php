<?php

function getThreads($projID) {
	global $conn;
	$stmt = $conn->prepare("SELECT threadID, name FROM Thread WHERE projectID = ?");
	$stmt->execute(array($projID));
	$res = $stmt->fetchAll();

	for($i = 0; $i < count($res); $i++){
	    $res[$i]['threadLabels'] = getThreadLabels($res[$i]['threadid']);
	 }
}

function getThreadLabels($threadid) {
	global $conn;
	$stmt = $conn->prepare("SELECT name FROM ThreadLabel WHERE threadLID IN (SELECT threadLID FROM ThreadToLabel WHERE threadID = ?)");
	$stmt->execute(array($threadid));
	$res = $stmt->fetchAll();
	return $res;
}

function getProjectLabels($projID) {
	global $conn;
	$stmt = $conn->prepare("SELECT threadLID, name FROM ThreadLabel WHERE projectID = ?");
	$stmt->execute(array($projID));
	$res = $stmt->fetchAll();

	for($i = 0; $i < count($res); $i++){
	    $res[$i]['count'] = getLabelsCount($res[$i]['threadLID']);
	}
	return $res;
}

function getLabelsCount($threadlid){
	global $conn;
	$stmt = $conn->prepare("SELECT COUNT(threadID) FROM ThreadToLabel WHERE threadLID = ?");
	$stmt->execute(array($threadlid));
	$res = $stmt->fetchAll();
	return $res;
}
?>
