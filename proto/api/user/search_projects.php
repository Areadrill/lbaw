<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/projects.php');

if(!$_POST['field']) {
  echo json_encode(getProjects($_SESSION['userid']));
  exit;
}
$field = $_POST['field'];

if (!isset($_SESSION['userid'])){
	error_log('user was not logged in on api/projects/search_project.php');
	exit;
}

echo json_encode(searchProjects($field, $_SESSION['userid']));
?>
