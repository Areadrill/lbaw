<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/projects.php');

if (!$_POST['name'] || !$_POST['description']) {
  $_SESSION['error_messages'][] = 'Invalid creation';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$name = $_POST['name'];
$description = $_POST['description'];

if (createProject($name, $description)) {
  $_SESSION['success_messages'][] = 'Project created successfuly';
  header('Location: ' . $BASE_URL .'pages/project.php');
} else {
  $_SESSION['error_messages'][] = 'Project creation failed';
  header('Location: ' . $_SERVER['HTTP_REFERER']);
}
?>
