<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');


if(!$_POST['commentid']){
	error('Something went wrong.');
	exit;
}


if (!isset($_SESSION['userid'])){
	error('user was not logged in');
	exit;
}

$threadID = getThreadIDCommentID($_POST['commentid']);

$result = deleteComment($_SESSION['userid'], $_POST['commentid']);
if($result === "denied"){
	error("insufficient permissions");
	http_response_code(403);
}
else if(!$result){
	error("something went wrong");
	http_response_code(404);
}


if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo json_encode(getThreadComments($threadID));
}
else{
	$_SESSION['success_messages'][] = 'Comment created successfully';
	header('Location: '. $_SERVER['HTTP_REFERER']);
}


function error($msg){
	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		error_log($msg);
	}
	else{
		$_SESSION['error_messages'][] = $msg;
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}
}
?>
