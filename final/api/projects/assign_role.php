<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/members.php');

	if(!isset($_SESSION['userid'])){
		if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			error_log("User was not logged in to the system");
		}
		else{
			$_SESSION['error_messages'][] = 'User was not loged in to the system';
			header('Location: '. $_SERVER['HTTP_REFERER']);	
		}
		exit;
	}

	if(!$_POST['userID'] || !$_POST['projectID'] || !$_POST['action']){
		if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			error_log("not all information was sent");
		}
		else{
			$_SESSION['error_messages'][] = 'not all information was present';
			header('Location: '. $_SERVER['HTTP_REFERER']);	
		
		}
		exit;
	}

	switch($_POST['action']){
		case "promote":
			alterMemberRole($_POST['userID'], $_POST['projectID'], 'COORD');
			break;
		case "demote":
			alterMemberRole($_POST['userID'], $_POST['projectID'], 'MEMBER');
			break;
		case "remove":
			removeMember($_POST['userID'], $_POST['projectID']);
			break;
	}

	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		http_response_code(200);
	}
	else{
		$_SESSION['success_messages'][] = 'Role altering successful';
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}
?>