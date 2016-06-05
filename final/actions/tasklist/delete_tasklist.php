<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasklists.php');
include_once($BASE_DIR .'database/members.php');
var_dump($_POST);
if (!$_POST['tasklistID'] || !$_POST['projectID']) {
  $_SESSION['error_messages'][] = 'Invalid delete';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/delete_tasklist.php');
	exit;
}

if(checkPrivilege($_SESSION['userid'], $_POST['projectID']) != "COORD"){
	$_SESSION['error_messages'][] = "You don't have provevileges to create a tasklist on this project";
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

try {
	deleteTaskList($_POST['tasklistID']);
} catch (PDOException $e) {

  $_SESSION['error_messages'][] = 'Error deleting task list';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Task list deleted successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']);

?>
