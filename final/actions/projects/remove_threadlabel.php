<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');

if (!$_POST['threadlid']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}


if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/remove_threadLabel.php');
	exit;
}

try {
	deleteThreadLabel($_SESSION['userid'], $_POST['threadlid']);
} catch (PDOException $e) {

  
  $_SESSION['error_messages'][] = 'Error creating thread label';

	$_SESSION['form_values'] = $_POST;

	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Thread label removed successfuly';
header('Location: ' . $_SERVER['HTTP_REFERER']); // PROVISORIO O REDIRECT É: header('Location: ' . $BASE_URL .'pages/project.php');

?>
