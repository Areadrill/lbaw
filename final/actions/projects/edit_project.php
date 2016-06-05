<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/projects.php');
include_once($BASE_DIR .'database/members.php');

if (!$_POST['projectID'] || !$_POST['name'] || !$_POST['description'] ) {
  $_SESSION['error_messages'][] = 'Invalid edit';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$id = $_POST['projectID'];
$name = strip_tags($_POST['name']);
$description = strip_tags($_POST['description']);

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/edit_project.php');
	exit;
}

if(checkPrivilege($_SESSION['userid'], $id) != "COORD"){
	$_SESSION['error_messages'][] = "You don't have provevileges to edit this project";
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

try {
	editProject($id, $name, $description);
} catch (PDOException $e) {

  if (strpos($e->getMessage(), 'unique_projnameforcreator') !== false) {
    $_SESSION['error_messages'][] = 'Duplicated project name';
    $_SESSION['field_errors']['name'] = 'Project name already exists';
  }
  else{
    $_SESSION['error_messages'][] = 'Error editing project';
  }

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Project edited successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
