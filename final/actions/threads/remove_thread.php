<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');

if (!$_POST['threadid']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$projectID = getProjIDThreadID($_POST['threadid'])['projectid'];

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/remove_thread.php');
	exit;
}

try {
	deleteThread($_SESSION['userid'], $_POST['threadid']);

} catch (PDOException $e) {

	
  $_SESSION['error_messages'][] = 'Error deleting Thread';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Thread deleted successfuly';

header('Location: ' . $BASE_URL .'pages/projectpage.php?id='. $projectID); // PROVISORIO O REDIRECT É: header('Location: ' . $BASE_URL .'pages/project.php');

?>
