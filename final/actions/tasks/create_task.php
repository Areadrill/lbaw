<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasks.php');

if (!$_POST['projectid'] || !$_POST['name'] || !$_POST['body']) {
	$_SESSION['error_messages'][] = 'Invalid creation';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$title = strip_tags($_POST['name']);
$initComment = strip_tags($_POST['body']);

if (!isset($_SESSION['userid'])){
	$_SESSION['error_messages'][] = 'Need logged in';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}
try{
$res = createTask($_POST['name'], $_POST['projectid'], $_SESSION['userid'], $_POST['body']);
}
catch(Exception $e){
	$_SESSION['error_messages'][] = 'Duplicated task name not allowed';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}
if($res === 'NO_PRIVILEGE'){
	$_SESSION['error_messages'][] = 'You can\'t do that';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}
else if ($res === 'FAIL_INSERT'){
	$_SESSION['error_messages'][] = 'Task creation failed';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}
$_SESSION['success_messages'][] = 'Thread created successfuly';
header('Location: ' . $BASE_URL.'pages/tasks/task.php?taskid='.$res); 

?>
