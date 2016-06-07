<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasks.php');
include_once($BASE_DIR .'database/members.php');
include_once($BASE_DIR . 'database/users.php');

if(!$_POST['taskid']){
	http_response_code(404);
	exit;
}




if (!isset($_SESSION['userid'])){
	http_response_code(403);
	exit;
}

$privilege = checkPrivilege($_POST['userid'], getProjectByTask($_POST['taskid'])); 

if ($privilege !== "COORD"){
	http_response_code(403);
	exit;
}

http_response_code(200);
markTaskCompleted($_POST['taskid'], false);

?>
