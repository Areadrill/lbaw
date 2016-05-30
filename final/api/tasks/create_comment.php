<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasks.php');
include_once($BASE_DIR .'database/members.php');


if(!$_POST['taskid'] || !$_POST['completed'] || !$_POST['body']){
	http_response_code(404);
	exit;
}

$comment = strip_tags($_POST['body']);

if(!$comment || ctype_space($comment)) {
  error (json_encode(getThreadComments($_POST['threadid'])));
  exit;
}


if (!isset($_SESSION['userid'])){
	http_response_code(403);
	exit;
}

$privilege = checkPrivilege($_POST['userid'], getProjectByTask($_POST['taskid'])); 

if (!($_POST['completed'] == false && ($privilege === "MEMB" || $privilege === "COORD")) && !($_POST['completed'] && ($privilege === "COORD" || isAssigned($_POST['userid']))))
{
	http_response_code(403);
	exit;
}

if(createComment($_POST['taskid'], $comment, $_SESSION['userid'])){
	http_response_code(300);
	exit;
}

if ($_POST['completed']){
	if(markTaskCompleted($_POST['taskid'])){
		http_response_code(300);
		exit;
	}
}

http_response_code(200);

?>
