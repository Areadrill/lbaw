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

	if($res['roleassigned'] == null){
		return false;
	}
	else{
		return $res['roleassigned'];
	}
}

function checkIsInProjectProjID($userID, $projectID){
	global $conn;

	$stmt = $conn->prepare('SELECT roleassigned FROM Roles WHERE userid = ? AND projectid = ?');
	$stmt->execute(array($userID, $projectID));

	$res = $stmt->fetch();

	if($res['roleassigned'] == null){
		return false;
	}
	else{
		return $res['roleassigned'];
	}
}

function comment($userID, $threadID, $text){

	if(isLocked($threadID)){
		return "locked";
	}

	if(checkIsInProject($userID, $threadID) === false){
		$_SESSION['error_messages'][] = 'User is not in the project';
		return "denied";
	}

	global $conn;
	$stmt = $conn->prepare("INSERT INTO Comment VALUES(default, ?, ?, clock_timestamp(), ?)");
	$stmt->execute(array($threadID, $userID, $text));

	return $stmt->fetch() !== false;
}

function createThread($userID, $projectID, $name){
	global $conn;

	if(checkIsInProjectProjID($userID, $projectID) === false){
		$_SESSION['error_messages'][] = 'User is not in the project';
		return "denied";
	}

	$stmt = $conn->prepare("INSERT INTO Thread VALUES(default, ?, ?, ?, clock_timestamp(), FALSE)");
	$stmt->execute(array($projectID, $userID, $name));

	return $stmt->fetch() !== false;
}

function deleteComment($userID, $commentID){

	if(checkPrivilege($userID, getProjIDCommentID($commentID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM Comment WHERE commentid = ?");
	$stmt->execute(array($commentID));

	return $stmt->fetch() !== false;

}

function deleteThread($userID, $threadID){
	if(checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM Thread WHERE threadid = ?");
	$stmt->execute(array($threadID));

	return $stmt->fetch() !== false;
}


function createThreadLabel($userID, $projectID, $name){
	if(checkPrivilege($userID, $projectID) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}
	global $conn;

	$stmt = $conn->prepare("INSERT INTO ThreadLabel VALUES(default, ?, ?)");
	$stmt->execute(array($projectID, $name));

	return $stmt->fetch() !== false;
}

function deleteThreadLabel($userID, $threadLID){
	if(checkPrivilege($userID, getProjIDThreadLabelID($threadLID)) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM ThreadLabel WHERE threadlid = ?");
	$stmt->execute(array($threadLID));

	return $stmt->fetch() !== false;
}


function assignLabelToThread($userID, $threadID, $threadLID){ //preciso ver se a thread e a label pertencem ao mesmo projeto?
	if((checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD') && ($_SESSION['userid'] !== getThreadInfo($threadID)['creator'])){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("INSERT INTO ThreadToLabel VALUES(?, ?)");
	$stmt->execute(array($threadID, $threadLID));

	return $stmt->fetch() !== false;
}
function filterThread($threadlabelid,$projid,$userid){
	if(checkPrivilege($userid, getProjIDThreadLabelID($threadlabelid))){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}
	global $conn;

	$stmt = $conn->prepare("SELECT Thread.threadid, Thread.name FROM Thread, ThreadLabel, ThreadToLabel WHERE ThreadLabel.threadlid	 = ? AND ThreadToLabel.threadlid = ThreadLabel.threadlid AND ThreadToLabel.threadid = Thread.threadid");
	$stmt->execute(array($threadlabelid));

	$res = $stmt->fetchAll();
	for($i = 0; $i < count($res); $i++){
			$res[$i]['threadLabels'] = getThreadLabels($res[$i]['threadid']);
	}

	return $res;
}

function unassignLabelFromThread($userID, $threadID, $threadLID){
	if((checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD') && ($_SESSION['userid'] !== getThreadInfo($threadID)['creator'])){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	global $conn;

	$stmt = $conn->prepare("DELETE FROM ThreadToLabel WHERE threadid = ? AND threadlid = ?");
	$stmt->execute(array($threadID, $threadLID));

	return $stmt->fetch() !== false;
}

function lockThread($userID, $threadID){
	global $conn;

	if(checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	$stmt = $conn->prepare('UPDATE Thread SET locked = TRUE WHERE threadid = ?');
	$stmt->execute(array($threadID));

	return $stmt->fetch() !== false;
}

function unlockThread($userID, $threadID){
	global $conn;

	if(checkPrivilege($userID, getProjIDThreadID($threadID)['projectid']) !== 'COORD'){
		$_SESSION['error_messages'][] = 'Insufficient permissions';
		return 'denied';
	}

	$stmt = $conn->prepare('UPDATE Thread SET locked = FALSE WHERE threadid = ?');
	$stmt->execute(array($threadID));

	return $stmt->fetch() !== false;
}

function isLocked($threadID){
	global $conn;

	$stmt = $conn->prepare('SELECT locked FROM Thread WHERE threadid = ?');
	$stmt->execute(array($threadID));

	return $stmt->fetch()['locked'];
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
