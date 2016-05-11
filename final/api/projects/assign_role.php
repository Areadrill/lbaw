<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/members.php');

	if(!isset($_SESSION['userid'])){
		error_log("user was not logged in to the system");
		exit;
	}

	if(!$_POST['userID'] || $_POST['projectID'] || $_POST['action']){
		error_log("not all information was sent");
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

	http_response_code(200);
?>