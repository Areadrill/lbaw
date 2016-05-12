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
			if(!alterMemberRole($_POST['userID'], $_POST['projectID'], 'COORD')){
				error('insufficient permissions');
				exit;
			}
			break;
		case "demote":
			if(!alterMemberRole($_POST['userID'], $_POST['projectID'], 'MEMBER')){
				error('insufficient permissions');
				exit;
			}
			break;
		case "remove":
			if(!removeMember($_POST['userID'], $_POST['projectID'])){
				error('insufficient permissions');
				exit;
			}
			break;
		case "add":
			if(!addMember($_POST['userID'], $_POST['projectID'])){
				error('insufficient permissions');
				exit;
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
	}
	else{
		$_SESSION['error_messages'][] = $msg;
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}
}
?>