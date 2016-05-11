<?php
function getProjectMembers($projectID){
	global $conn;

	$stmt = $conn->prepare("SELECT Users.userid, username, roleassigned FROM Users, Roles WHERE Users.userid = Roles.userid AND Roles.projectid = ?");
	$stmt->execute(array($projectID));

	$members = $stmt->fetchAll();

	for($i = 0; $i < count($members); $i++){
    	$members[$i]['picPath'] = glob("../images/".$members[$i]['userid'].".*")[0];
  	}

	return $members;
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

	var_dump($stmt->fetch());

	return true;
}

function addMember($userID, $projectID){
	global $conn;

	if(checkPrivilege($userID, $projectID) !== 'COORD')
		return false;

	$stmt = $conn->prepare("INSERT INTO Roles VALUES(?, ?, 'MEMBER')");
	$stmt->execute($userID, $projectID);

	var_dump($stmt->fetch());

	return true;
}

function checkPrivilege($userID, $projectID){
	global $conn;

	$stmt = $conn->prepare("SELECT roleassigned FROM Roles WHERE userid = ? AND projectid = ?");
	$stmt->execute(array($_SESSION['userid'], $projectID));

	return $stmt->fetch()['roleassigned'];
}

function searchUsers($field){
  global $conn;
  $stmt = $conn->prepare("SELECT userid, username FROM Users WHERE to_tsvector(username) @@ to_tsquery('english',?)");

  $stmt->execute(array($field.':*'));
  $res = $stmt->fetchAll();

  return $res;
}


?>