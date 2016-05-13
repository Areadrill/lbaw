<?php
function getProjectMembers($projectID){
	global $conn;

	$stmt = $conn->prepare("SELECT Users.userid, username, roleassigned FROM Users, Roles WHERE Users.userid = Roles.userid AND Roles.projectid = ?");
	$stmt->execute(array($projectID));

	$members = $stmt->fetchAll();

	for($i = 0; $i < count($members); $i++){
		$picPath = glob("../images/".$members[$i]['userid'].".*")[0];
		if(!$picPath || !file_exists($picPath)){
			$picPath = glob("../images/default.jpg")[0];
		}

    	$members[$i]['picPath'] = $picPath;
    	$members[$i]['tasksassigned'] = memberTasks($res[$i]['userid'], $projectID);
  	}

	return $members;
}

function memberTasks($userID, $projectID){
	global $conn;
	$stmt = $conn->prepare('SELECT COUNT(taskid) AS tasksassigned FROM Task WHERE assignee = ? AND projectid = ?');
	$stmt->execute(array($userID, $projectID));

	return $stmt->fetch()['tasksassigned'];
}

function alterMemberRole($userID, $projectID, $newRole){
	global $conn;

	if(checkPrivilege($userID, $projectID) !== 'COORD')
		return false;

	$stmt = $conn->prepare("UPDATE Roles SET roleassigned = ? WHERE userid = ? AND projectid = ?");
	$stmt->execute(array($newRole, $userID, $projectID));


	return $stmt->fetch() == true;
}

function removeMember($userID, $projectID){
	global $conn;

	if(checkPrivilege($userID, $projectID) !== 'COORD')
		return false;

	$stmt = $conn->prepare("DELETE FROM Roles WHERE userid = ? AND projectid = ?");
	$stmt->execute(array($userID, $projectID));

	return $stmt->fetch() !== false;
}

function addMember($userID, $projectID){
	global $conn;

	if(checkPrivilege($userID, $projectID) !== 'COORD')
		return false;

	$stmt = $conn->prepare("INSERT INTO Roles VALUES(?, ?, 'MEMBER')");
	$stmt->execute(array($userID, $projectID));

	return $stmt->fetch() !== false;
}

function checkPrivilege($userID, $projectID){
	global $conn;

	$stmt = $conn->prepare("SELECT roleassigned FROM Roles WHERE userid = ? AND projectid = ?");
	$stmt->execute(array($_SESSION['userid'], $projectID));

	return $stmt->fetch()['roleassigned'];
}

function searchUsers($field, $projectID){
  global $conn;
  $stmt = $conn->prepare("SELECT userid, username FROM Users WHERE to_tsvector(username) @@ to_tsquery('english',?)");

  $stmt->execute(array($field.':*'));
  $res = $stmt->fetchAll();

  for($i = 0; $i < count($res); $i++){
  		if(!file_exists(glob("../../images/".$res[$i]['userid'].'.*')[0])){
  			$res[$i]['picPath'] = glob("../../images/default.jpg")[0];
  		}
    	else{
    		$res[$i]['picPath'] = glob("../../images/".$res[$i]['userid'].'.*')[0];
    	}
    	$res[$i]['projid'] = $projectID;

  	}

  return $res;
}


?>