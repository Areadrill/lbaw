<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/members.php');

if(!$_POST['field'] || !$_POST['projectID']) {
  echo json_encode(' ');
  exit;
}
$field = $_POST['field'];

if (!isset($_SESSION['userid'])){
        error_log('user was not logged in on api/projects/search_project.php');
        exit;
}

echo json_encode(searchUsers($field, $_POST['projectID']));