<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/members.php');

	if(!isset($_SESSION['userid'])){
		error('User was not logged in to the system');
		exit;
	}

	if(!$_POST['userID'] || !$_POST['projectID'] || !$_POST['action']){
		error('Missing vital information');
		exit;
	}

	switch($_POST['action']){
		case "promote":
			$result = alterMemberRole($_POST['userID'], $_POST['projectID'], 'COORD');
			if(!$result){
				error('insufficient permissions');
				http_response_code(404);
				exit;
			}
			else if($result === "denied"){
				error('Insufficient permissions');
				http_response_code(403);
			}
			break;
		case "demote":
			$result = alterMemberRole($_POST['userID'], $_POST['projectID'], 'MEMBER');
			if(!$result){
				error('insufficient permissions');
				http_response_code(404);
				exit;
			}
			else if($result === "denied"){
				error('Insufficient permissions');
				http_response_code(403);
			}
			break;
		case "remove":
			$result = removeMember($_POST['userID'], $_POST['projectID']);
			if(!$result){
				error('insufficient permissions');
				http_response_code(404);
				exit;
			}
			else if($result === "denied"){
				error('Insufficient permissions');
				http_response_code(403);
			}
			break;
		case "add":
			$result = addMember($_POST['userID'], $_POST['projectID']);
			if(!$result){
				error('insufficient permissions');
				http_response_code(404);
				exit;
			}
			else if($result === "denied"){
				error('Insufficient permissions');
				http_response_code(403);
			}
			break;
	}

	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		http_response_code(200);
	}
	else{
		$_SESSION['success_messages'][] = 'Role altering successful';
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}

function error($msg){
	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		error_log($msg);
		http_response_code();
	}
	else{
		$_SESSION['error_messages'][] = $msg;
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}
}
?>
