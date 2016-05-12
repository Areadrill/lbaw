<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/projects.php');

if (!$_POST['name'] || !$_POST['description']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$name = $_POST['name'];
$description = $_POST['description'];

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/create_project.php');
	exit;
}

try {
	createProject($name, $description, $_SESSION['userid']);
} catch (PDOException $e) {

  

	if (strpos($e->getMessage(), 'unique_projnameforcreator') !== false) {
		$_SESSION['error_messages'][] = 'Duplicated project name';
		$_SESSION['field_errors']['name'] = 'Project name already exists';
	}
	else
  $_SESSION['error_messages'][] = 'Error creating project';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Project created successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']); // PROVISORIO O REDIRECT É: header('Location: ' . $BASE_URL .'pages/project.php');

?>
