<?php
include_once('../../config/init.php');
include_once($BASE_DIR.'database/tasks.php');
include_once($BASE_DIR.'database/members.php');

if(!isset($_SESSION['userid']) || !isset($_POST['taskid']) || !isset($_POST['userid'])){
	http_response_code(400);
	var_dump('falheu0');
	$_SESSION['error_messages'] = 'Bad request';
	header('Location: '. $_SERVER['HTTP_REFERER']);
	exit;
}

$taskid = $_POST['taskid'];
$userid = $_POST['userid'];

$role = checkPrivilege($_SESSION['userid'], getProjectByTask($taskid));

if ($role != "COORD"){
	http_response_code(403);
	$_SESSION['error_messages'] = 'Only coordinators can assign tasks';
	header('Location: '. $_SERVER['HTTP_REFERER']);
	exit;
}

if ($userid == -1){
	assignTask($taskid, null);
	header('Location: '. $_SERVER['HTTP_REFERER']);
	exit;
}
else if(checkPrivilege($userid, getProjectByTask($taskid)) !== null){
	assignTask($taskid, $userid);
	header('Location: '. $_SERVER['HTTP_REFERER']);
	exit;
}
http_response_code(403);
exit;

?>
