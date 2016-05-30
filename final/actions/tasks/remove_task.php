<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tasks.php');

if (!isset($_POST['taskid'])) {
	$_SESSION['error_messages'][] = 'Invalid deletion';
	$_SESSION['form_values'] = $_POST;
	var_dump($_POST);
	header('Location: ' . $BASE_URL .'pages/projectpage.php?id='. $projectID); 
	exit;
}

$taskid = $_POST['taskid'];

var_dump($taskid);
$projectID = getProjectByTask($taskid);

if (!isset($_SESSION['userid'])){
	error_log('User was not logged in on actions/tasks/remove_tasks.php');
	exit;
}

try {
	$res = deleteTask($_SESSION['userid'], $taskid);

} catch (PDOException $e) {


	$_SESSION['error_messages'][] = 'Error deleting Task';

	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $BASE_URL .'pages/projectpage.php?id='. $projectID); 
	exit;
}
if($res !== "SUCCESS"){

	if ($res === "NO_PERM"){
		$_SESSION['error_messages'][] = "No permission to delete task";
		error_log('Unauthorized user attempted to delete task ' . $taskid . '. User id: '.$_SESSION['userid']);
		header('Location: ' . $_SERVER['HTTP_REFERER']);
	header('Location: ' . $BASE_URL .'pages/projectpage.php?id='. $projectID); 
	}

	else{	
		error_log("unexpected error in delete task: ".$taskid);
		$_SESSION['error_messages'][] = 'Error deleting Task';
		$_SESSION['form_values'] = $_POST;
		header('Location: ' . $_SERVER['HTTP_REFERER']);
	header('Location: ' . $BASE_URL .'pages/projectpage.php?id='. $projectID); 
		exit;

	}
}

	$_SESSION['success_messages'][] = 'Thread deleted successfuly';

	header('Location: ' . $BASE_URL .'pages/projectpage.php?id='. $projectID); 

?>
