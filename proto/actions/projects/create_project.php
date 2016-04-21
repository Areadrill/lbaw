<?php
include_once('../../config/init.php');
include_once($BASE_DIR . 'database/projects.php');
session_start();
$name = $_POST['name'];
$description = $_POST['description'];
if (!isset($name) || !isset($description)){
	error_log('insufficient arguments on actions/projects/create_project');
	header("Location: $BASE_URL".'pages/users/userpage.php');
	exit;
}

if (!isset($_SESSION['userid'])){
	error_log('user was not logged in on actions/projects/create_project.php');
//	header("Location: $BASE_URL".'pages/homepage.php');
	exit;
}

$id = createProject($name, $description, $_SESSION['userid']);
if($result != -1)
	header("Location: $BASE_URL".'pages/projects/project.php?projectid='.$id);


else
	header("Location: $BASE_URL".'pages/userpage.php');

?>
