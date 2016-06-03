<?php
include_once('../../config/init.php');
include_once($BASE_DIR.'database/members.php');
include_once($BASE_DIR.'database/tasks.php');

if (!isset($_SESSION['userid'])){
	error('User not logged in to the system');
	http_response_code(403);
	exit;
}

if (!isset($_POST['name']) || !isset($_POST['projectid'])){
	error('Malformed request to create task label');
	http_response_code(400);
	exit;
}

$user = $_SESSION['userid'];
$projectid = $_POST['projectid'];
$name = $_POST['name'];
$role = checkPrivilege($user, $projectid);

$reply = array();

if ($role !== 'COORD'){
	http_response_code(403);
	exit;
}

try{
	$res = createTaskLabel($name, $projectid);
}
catch (PDOException $e){
	$res = false;
	switch($e->errorInfo[1]){
	case 23503:
		$reply['error'] = 'Project does not exist.';
		break;
	case 7;
		$reply['error'] = 'Label with that name already exists';
		break;
	default:
		$reply['error'] = 'Unknown error '.$e->errorInfo[1];
		break;
	}
	http_response_code(400);
	echo json_encode($reply);
	exit;
}


	echo json_encode(array("name" => $name));
	http_response_code(200);

?>
