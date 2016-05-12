<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/threads.php');

if (!$_POST['title'] || !$_POST['projid']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$title = strip_tags($_POST['title']);
$initComment = strip_tags($_POST['initialComment']);

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/projects/create_project.php');
	exit;
}

try {
	createThread($_SESSION['userid'], $_POST['projid'], $title);

	if(!empty($initComment) && !ctype_space($initComment)){
		comment($_SESSION['userid'], getThreadIDProjIDName($_POST['projid'], $title)['threadid'], $initComment);		
	}

} catch (PDOException $e) {

	if (strpos($e->getMessage(), 'unique_threadNameInProj') !== false) {
		$_SESSION['error_messages'][] = 'Duplicated thread name';
		$_SESSION['field_errors']['title'] = 'Thread name already exists';
	}
	else
  $_SESSION['error_messages'][] = 'Error creating Thread';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$_SESSION['success_messages'][] = 'Thread created successfuly';

header('Location: ' . $_SERVER['HTTP_REFERER']); // PROVISORIO O REDIRECT É: header('Location: ' . $BASE_URL .'pages/project.php');

?>
