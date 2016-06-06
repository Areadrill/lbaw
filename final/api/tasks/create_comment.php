<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasks.php');
include_once($BASE_DIR .'database/members.php');
include_once($BASE_DIR . 'database/users.php');

if(!$_POST['taskid'] ||  !$_POST['body']){
	http_response_code(404);
	exit;
}

$comment = strip_tags($_POST['body']);

if (!isset($_POST['completed'])){
	$_POST['completed'] = false;
}

if(strlen($title) > 512){
	$_SESSION['error_messages'][] = "Too many characters in one of the form's fields";
	header("Location: ". $BASE_URL . 'pages/projectpage.php?id='.$_POST['projid']);
	exit;
}

if (!isset($_SESSION['userid'])){
	http_response_code(403);
	exit;
}

$privilege = checkPrivilege($_POST['userid'], getProjectByTask($_POST['taskid'])); 
$response = ["body" => $comment, "username" => getUsername($_SESSION['userid'])];

if (!($_POST['completed'] == false && ($privilege === "MEMB" || $privilege === "COORD")) && !($_POST['completed'] && ($privilege === "COORD" || isAssigned($_POST['userid']))))
{
	http_response_code(403);
	exit;
}
$taskcid = createComment($_POST['taskid'], $comment, $_SESSION['userid']);
if($taskcid !== false){
	http_response_code(200);
	$response['taskcid'] = $taskcid;
}

if ($_POST['completed']){
	if(markTaskCompleted($_POST['taskid'])){
		http_response_code(200);
	}
}

http_response_code(200);
echo json_encode($response);

?>
