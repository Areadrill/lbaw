<?php
include_once("../../config/init.php");
include_once($BASE_DIR."database/users.php");
if(!$_POST['email']){
  $_SESSION['error_messages'][] = 'Invalid recovery';
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}

$email = $_POST['email'];
$userid = getUserByEmail($email);
var_dump($userid);
if ($userid == false){
	$_SESSION['error_messages'][] = 'Email does not exist';
	$_SESSION['form_values'] = $_POST;
	var_dump("error");
	exit;
}

var_dump("success");
recoverUserPassowrd($userid);
?>
