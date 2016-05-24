<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/threads.php');

	if(!isset($_SESSION['userid'])){
		error('User was not logged in to the system');
		exit;
	}

	if(!$_POST['threadid']){
		error('Missing vital information');
		exit;
	}

	if(isLocked($_POST['threadid'])){
		$result = unlockThread($_SESSION['userid'], $_POST['threadid']);
		if($result === "denied"){
			error('insufficient permissions');
			http_response_code(403);
		}
		else if($result == false){
			error('something went wrong');
			http_response_code(404);
		}

		$action = "unlocked";
	}
	else{
		$result = lockThread($_SESSION['userid'], $_POST['threadid']);
		if($result === "denied"){
			error('insufficient permissions');
			http_response_code(403);
		}
		else if($result == false){
			error('something went wrong');
			http_response_code(404);
		}

		$action = "locked";
	}

	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo $action;
		http_response_code(200);
	}
	else{
		$_SESSION['success_messages'][] = "thread locked successfully";
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
