<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');


if(!$_POST['threadlabelid'] || !$_POST['projid']){
	error('Something went wrong.');
	exit;
}


if (!isset($_SESSION['userid'])){
	error_log('user was not logged in on api/threads/filtes_threads.php');
	exit;
}


$result = filterThread($_POST['threadlabelid'],$_POST['projid'],$_SESSION['userid']);
if($result = "denied"){
	error("insufficient permissions");
	http_response_code(403);
}
else if(!$result){
	error("something went wrong");
	http_response_code(404);
}

if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo json_encode(getThreadComments($_POST['threadid']));
}
else{
	$_SESSION['success_messages'][] = 'Threads filtered successfully';
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
