<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasks.php');


if(!$_POST['tasklabelid'] || !$_POST['projid']){
	error('Something went wrong.');
	exit;
}


if (!isset($_SESSION['userid'])){
	error_log('user was not logged in on api/tasks/filter_tasks.php');
	exit;
}


$result = filterTask($_POST['tasklabelid'],$_POST['projid'],$_SESSION['userid']);
if($result == "denied"){
	error("insufficient permissions");
	http_response_code(403);
}

if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo json_encode($result);
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
