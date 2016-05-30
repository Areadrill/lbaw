<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/projects.php');
include_once($BASE_DIR .'database/members.php');

if (!$_POST['projectID']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$id = $_POST['projectID'];

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/create_project.php');
	exit;
}

if(checkPrivilege($_SESSION['userid'], $id) != "COORD"){
	$_SESSION['error_messages'][] = "You don't have provevileges to delete this project";
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

try {
	deleteProject($id);
} catch (PDOException $e) {

  	$_SESSION['error_messages'][] = 'Error deleting project';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Project deleted successfuly';
header('Location: ' . $BASE_URL .'pages/userpage.php');
?>