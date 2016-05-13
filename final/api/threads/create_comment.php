<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');


if(!$_POST['threadid']){
	error('Something went wrong.');
}

$comment = strip_tags($_POST['commentArea']);

if(!$comment) {
  echo json_encode(getThreadComments($_POST['threadid']));
  exit;
}

if (!isset($_SESSION['userid'])){
	error_log('user was not logged in on api/projects/search_project.php');
	exit;
}


comment($_SESSION['userid'], $_POST['threadid'], $comment);

if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo json_encode(getThreadComments($_POST['threadid']));
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
