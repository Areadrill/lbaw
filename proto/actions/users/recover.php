<?php
var_dump("tudo de bom");
include_once("../../config/init.php");
include_once($BASE_DIR."database/users.php");
var_dump("cheguei");
if(!$_POST['email']){
  $_SESSION['error_messages'][] = 'Invalid recovery';
  var_dump("bad data");
  $_SESSION['form_values'] = $_POST;
  header('Location: ' . $_SERVER['HTTP_REFERER']);
  exit;
}
  var_dump("good data");

$email = $_POST['email'];
$userid = getUserByEmail($email);
var_dump($user_id);
if ($userid == false){
	$_SESSION['error_messages'][] = 'Email does not exist';
	$_SESSION['form_values'] = $_POST;
	var_dump("error");
//  	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

var_dump("success");
recoverUserPassowrd($userid);
?>
