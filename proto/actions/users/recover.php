<?php
include_once("../../config/init.php");
var_dump("ola");
include_once("../../database/users.php");
if(!$_POST['email']){
  $_SESSION['error_messages'][] = 'Invalid recovery';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

var_dump("ola2");
$email = $_POST['email'];
$userid = getUserByEmail($email);
var_dump("ola3");
var_dump($userid);
if ($userid == false){
	$_SESSION['error_messages'][] = 'Email does not exist';
	$_SESSION['form_values'] = $_POST;
	var_dump("error");
	exit;
}

recoverUserPassword($userid, $BASE_URL);
header('Location: ' . $_SERVER['HTTP_REFERER']);
?>
