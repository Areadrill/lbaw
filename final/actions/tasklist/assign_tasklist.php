<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasklists.php');
include_once($BASE_DIR .'database/members.php');

if (!$_POST['tasklistID'] || !$_POST['projectID'] || !$_POST['taskid']) {
  $_SESSION['error_messages'][] = 'Invalid assign';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/assign_tasklist_tasklist.php');
	exit;
}

if(checkPrivilege($_SESSION['userid'], $_POST['projectID']) != "COORD"){
	$_SESSION['error_messages'][] = "You don't have provevileges to add a task to a tasklist";
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

try {
	addTaskToTaskList($_POST['tasklistID'], $_POST['taskid']);
} catch (PDOException $e) {

  $_SESSION['error_messages'][] = 'Error adding task to task list';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Task added to a task list successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']);

?>
