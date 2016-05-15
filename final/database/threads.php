<?php
include_once('members.php');
include_once('users.php');

function getThreads($projID) {
	global $conn;
	$stmt = $conn->prepare("SELECT threadid, name FROM Thread WHERE projectID = ?");
	$stmt->execute(array($projID));
	$res = $stmt->fetchAll();

	for($i = 0; $i < count($res); $i++){
	    $res[$i]['threadLabels'] = getThreadLabels($res[$i]['threadid']);
	}

	return $res;
}

function getThreadLabels($threadID) {
	global $conn;
	$stmt = $conn->prepare("SELECT threadlid, name FROM ThreadLabel WHERE threadLID IN (SELECT threadlid FROM ThreadToLabel WHERE threadID = ?)");
	$stmt->execute(array($threadID));
	$res = $stmt->fetchAll();
	
	return $res;
}

function getLabelsNotInThread($threadID){
	global $conn;
	$stmt = $conn->prepare("SELECT threadlid, name FROM ThreadLabel WHERE projectid = ? AND threadlid NOT IN (SELECT threadlid FROM ThreadToLabel WHERE threadid = ?)");
	$stmt->execute(array(getProjIDThreadID($threadID)['projectid'], $threadID));
	$res = $stmt->fetchAll();
	
	return $res;
}

function getProjectThreadLabels($projID) {
	global $conn;
	$stmt = $conn->prepare("SELECT threadLID, name FROM ThreadLabel WHERE projectID = ?");
	$stmt->execute(array($projID));
	$res = $stmt->fetchAll();

	for($i = 0; $i < count($res); $i++){
	    $res[$i]['count'] = getThreadLabelsCount($res[$i]['threadLID']);
	}
	return $res;
}

function getThreadLabelsCount($threadlid){
	global $conn;
	$stmt = $conn->prepare("SELECT COUNT(threadID) FROM ThreadToLabel WHERE threadLID = ?");
	$stmt->execute(array($threadlid));
	$res = $stmt->fetch();
	return $res['count'];
}

function getThreadLabelCountForProject($projectID){
	global $conn;
	$stmt = $conn->prepare("SELECT COUNT(threadlid) FROM ThreadLabel WHERE projectid = ?");
	$stmt->execute(array($projectID));
	$res = $stmt->fetch();
	return $res['count'];
}

function getThreadInfo($threadID){
	global $conn;
	$stmt = $conn->prepare("SELECT name, creator, creationinfo FROM Thread WHERE threadid = ?");
	$stmt->execute(array($threadID));
	$res = $stmt->fetch();
	$res['creatorName'] = getUsername($res['creator']);
	return $res;
}

function getThreadComments($threadID){
	global $conn;
	$stmt = $conn->prepare("SELECT commentid, commentor, creationinfo, text FROM Comment WHERE threadid = ?");
	$stmt->execute(array($threadID));
	$res = $stmt->fetchAll();

	for($i = 0; $i < count($res); $i++){
	    $res[$i]['commentorName'] = getUsername($res[$i]['commentor']);
	}

	return $res;
}


function checkIsInProject($userID, $threadID){
	global $conn;
	$stmt = $conn->prepare('SELECT projectid FROM Thread WHERE threadid = ?');
	$stmt->execute(array($threadID));

	$projID = $stmt->fetch();
	
	$stmt = $conn->prepare('SELECT roleassigned FROM Roles WHERE userid = ? AND projectid = ?');
	$stmt->execute(array($userID, $projID['projectid']));

	$res = $stmt->fetch();

	if($res == null){
		return false;
	}
	else{
		return $res;
	}
}

function comment($userID, $threadID, $text){
	if(checkIsInProject($userID, $threadID) === false){
		$_SESSION['error_messages'][] = 'User is not in the project';
		echo 'crl';
	}

	global $conn;
	$stmt = $conn->prepare("INSERT INTO Comment VALUES(default, ?, ?, clock_timestamp(), ?)");
	$stmt->execute(array($threadID, $userID, $text));

	return $stmt->fetch() !== false;
}

function createThread($userID, $projectID, $name){
	global $conn;

	$stmt = $conn->prepare("INSERT INTO Thread VALUES(default, ?, ?, ?, clock_timestamp())");
	$stmt->execute(array($projectID, $userID, $name));

	return $stmt->fetch() !== false;	
}

function deleteComment($userID, $commentID){

	if(checkPrivilege($userID, getProjIDCommentID($commentID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM Comment WHERE commentid = ?");
	$stmt->execute(array($commentID));

	return $stmt->fetch() !== false;	

}

function deleteThread($userID, $threadID){
	if(checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM Thread WHERE threadid = ?");
	$stmt->execute(array($threadID));

	return $stmt->fetch() !== false;
}


function createThreadLabel($userID, $projectID, $name){
	if(checkPrivilege($userID, $projectID) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}
	global $conn;

	$stmt = $conn->prepare("INSERT INTO ThreadLabel VALUES(default, ?, ?)");
	$stmt->execute(array($projectID, $name));

	return $stmt->fetch() !== false;
}

function deleteThreadLabel($userID, $threadLID){
	if(checkPrivilege($userID, getProjIDThreadLabelID($threadLID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM ThreadLabel WHERE threadlid = ?");
	$stmt->execute(array($threadLID));

	return $stmt->fetch() !== false;
}


function assignLabelToThread($userID, $threadID, $threadLID){ //preciso ver se a thread e a label pertencem ao mesmo projeto?
	if((checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD') && ($_SESSION['userid'] !== getThreadInfo($threadID)['creator'])){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("INSERT INTO ThreadToLabel VALUES(?, ?)");
	$stmt->execute(array($threadID, $threadLID));

	return $stmt->fetch() !== false;
}

function unassignLabelFromThread($userID, $threadID, $threadLID){
	if((checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD') && ($_SESSION['userid'] !== getThreadInfo($threadID)['creator'])){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return false;
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM ThreadToLabel WHERE threadid = ? AND threadlid = ?");
	$stmt->execute(array($threadID, $threadLID));

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

function getProjIDThreadLabelID($threadLID){
	global $conn;

	$stmt = $conn->prepare("SELECT projectid FROM ThreadLabel WHERE threadlid = ?");
	$stmt->execute(array($threadLID));

	return $stmt->fetch()['projectid'];	
}

function getThreadIDProjIDName($projectID, $name){
	global $conn;

	$stmt = $conn->prepare("SELECT threadid FROM Thread WHERE projectid = ? AND name = ?");
	$stmt->execute(array($projectID, $name));

	return $stmt->fetch();	
}

function getThreadIDCommentID($commentID){
	global $conn;

	$stmt = $conn->prepare("SELECT threadid FROM Comment WHERE commentid = ?");
	$stmt->execute(array($commentID));

	return $stmt->fetch()['threadid'];
}

?>