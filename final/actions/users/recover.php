<?php
include_once("../../config/init.php");
include_once("../../database/users.php");
if(!$_POST['email']){
  $_SESSION['error_messages'][] = 'Invalid recovery';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$email = $_POST['email'];
$userid = getUserByEmail($email);
if ($userid == false){
	$_SESSION['error_messages'][] = 'Email does not exist';
	$_SESSION['form_values'] = $_POST;
	exit;
}

recoverUserPassword($userid, $BASE_URL);
header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
