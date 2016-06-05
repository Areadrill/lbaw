<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasklists.php');
include_once($BASE_DIR .'database/members.php');

if (!$_POST['name'] || !$_POST['projectID']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$name = strip_tags($_POST['name']);

if(strlen($name) > 25){
	$_SESSION['error_messages'][] = "Too many characters in one of the form's fields";
	header("Location: ". $_SERVER['HTTP_REFERER']);
	exit;
}

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/create_tasklist.php');
	exit;
}

if(checkPrivilege($_SESSION['userid'], $_POST['projectID']) != "COORD"){
	$_SESSION['error_messages'][] = "You don't have provevileges to create a tasklist on this project";
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

try {
	createTaskList($name, $_POST['projectID']);
} catch (PDOException $e) {

	if (strpos($e->getMessage(), 'unique_tasklistnameinproj') !== false) {
		$_SESSION['error_messages'][] = 'Duplicated task list  name';
		$_SESSION['field_errors']['name'] = 'Task list name already exists';
	}
	else
    $_SESSION['error_messages'][] = 'Error creating task list';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Task list created successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']);

?>
