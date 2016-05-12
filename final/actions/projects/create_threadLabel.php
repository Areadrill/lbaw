<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');

if (!$_POST['name'] || !$_POST['projid']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$name = strip_tags($_POST['name']);

if(ctype_space($name)){
	$_SESSION['error_messages'][] = 'Name is composed of only whitespace characters.';
	$_SESSION['field_errors']['name'] = 'Name is composed of only whitespace characters.';
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}


if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/create_threadLabel.php');
	exit;
}

try {
	createThreadLabel($_SESSION['userid'], $_POST['projid'], $name);
} catch (PDOException $e) {

  

	if (strpos($e->getMessage(), 'unique_threadLabelIsProjScope') !== false) {
		$_SESSION['error_messages'][] = 'Duplicated thread label name';
		$_SESSION['field_errors']['name'] = 'Project thread label with that name already exists';
	}
	else
  $_SESSION['error_messages'][] = 'Error creating thread label';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Thread label created successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']); // PROVISORIO O REDIRECT É: header('Location: ' . $BASE_URL .'pages/project.php');


?>
