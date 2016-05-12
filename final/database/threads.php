<?php
include_onde('members.php');

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

function getProjectThreadLabels($projID) {
	global $conn;
	$stmt = $conn->prepare("SELECT threadLID, name FROM ThreadLabel WHERE projectID = ?");
	$stmt->execute(array($projID));
	$res = $stmt->fetchAll();

	for($i = 0; $i < count($res); $i++){
	    $res[$i]['count'] = getLabelsCount($res[$i]['threadLID']);
	}
	return $res;
}

function getThreadLabelsCount($threadlid){
	global $conn;
	$stmt = $conn->prepare("SELECT COUNT(threadID) FROM ThreadToLabel WHERE threadLID = ?");
	$stmt->execute(array($threadlid));
	$res = $stmt->fetchAll();
	return $res;
}

function checkIsInProject($userID, $threadID){
	global $conn;
	$stmt->prepare('SELECT projectid FROM Thread WHERE threadid = ?');
	$stmt->execute(array($threadID));

	$projID = $stmt->fetch();

	$stmt = $conn->prepare('SELECT roleassigned FROM Roles WHERE userid = ? AND projectID = ?');
	$stmt->execute(array($userID, $projID));

	$res = $stmt->fetch();
	if($res == null){
		return false;
	}
	else{
		return $res;
	}
}

function comment($userID, $threadID, $text){
	if(!checkIsInProject($userID, $projID)){
		$_SESSION['error_messages'][] = 'User is not in the project';
		return false;
	}

	global $conn;
	$stmt = $conn->prepare("INSERT INTO Comment VALUES(default, ?, ?, clock_timestamp(), ?)");
	$stmt->execute(array($threadID, $userID, $text));

	return $stmt->fetch() !== false;
}

function createThread($userID, $projectID, $name){
	if(checkPrivilege($userID, $projectID) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("INSERT INTO Thread VALUES(default, ?, ?, ?, clock_timestamp())");
	$stmt->execute(array($projectID, $userID, $name));

	return $stmt->fetch() !== false;	
}

function deleteComment($userID, $commentID){

	if(checkPrivilege($userID, getProjIDCommentID($commentID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM Comment WHERE commentid = ?");
	$stmt->execute(array($commentID));

	return $stmt->fetch() !== false;	

}

function deleteThread($userID, $threadID){
	if(checkPrivilege($userID, getProjIDThreadID($threadID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM Thread WHERE threadid = ?");
	$stmt->execute(array($threadID));

	return $stmt->fetch() !== false;
}


function createThreadLabel($userID, $threadID, $name){
	if(checkPrivilege($userID, getProjIDThreadID($threadID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("INSERT INTO ThreadLabel VALUES(default, ?, ?)");
	$stmt->execute(array(getProjIDThreadID($threadID), $name));

	return $stmt->fetch() !== false;
}

function deleteThreadLabel($userID, $threadLID){
	if(checkPrivilege($userID, getProjIDThreadID($threadID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM ThreadLabel WHERE threadlid = ?");
	$stmt->execute(array($threadLID));

	return $stmt->fetch() !== false;
}


function assignLabelToThread($userID, $threadID, $threadLID){ //preciso ver se a thread e a label pertencem ao mesmo projeto?
	if(checkPrivilege($userID, getProjIDThreadID($threadID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("INSERT INTO ThreadToLabel VALUES(?, ?)");
	$stmt->execute(array($threadID, $threadLID));

	return $stmt->fetch() !== false;
}

function unassignLabelFromThread($userID, $threadID, $threadLID){
	if(checkPrivilege($userID, getProjIDThreadID($threadID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM ThreadToLabel WHERE threadid = ? AND threadlid = ?");
	$stmt->execute(array($threadid, $threadLID));

	return $stmt->fetch() !== false;
}


function getProjIDThreadID($threadID){
	global $conn;

	$stmt = $conn->prepare("SELECT projectid FROM Thread WHERE threadid = ?");
	$stmt->execute(array($threadID));

	return $stmt->fetch();	

}

function getProjIDCommentID($commentID){
	global $conn;

	$stmt = $conn->prepare("SELECT projectid FROM Thread WHERE threadid = (SELECT threadid FROM Comment WHERE commentid = ?)");
	$stmt->execute(array($commentID));

	return $stmt->fetch();	
}

?>
