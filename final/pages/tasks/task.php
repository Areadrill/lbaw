<?php
include_once('../../config/init.php');
include_once('../../database/tasks.php');
include_once('../../database/members.php');

if(!isset($_SESSION['userid'])){
	$_SESSION['error_messages'] = 'You don\'t have permission to view that task';
	header('Location: '. $BASE_URL);
	exit;
}

$taskID = $_GET['taskid'];
$projectID = getProjIDTaskID($taskID)['projectid'];
$role = checkPrivilege($_SESSION['userid'], $projectID);

if($role == null){
	$_SESSION['error_messages'] = 'You don\'t have permission to view that task';
	exit;
}


if($taskID == null){
	$_SESSION['error_messages'] = 'Task doesn\'t exist';
	header('Location: '. $BASE_URL);
	exit;
}
$task = getTaskInfo($taskID);

if(!$task){
	$_SESSION['error_messages'] = 'Task doesn\'t exist';
	header('Location: '. $_SERVER['HTTP_REFERER']);
	exit;
}
var_dump($task);
?>
