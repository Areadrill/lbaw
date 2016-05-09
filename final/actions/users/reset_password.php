<?php
include_once("../../config/init.php");
include_once("../../database/users.php");
if (!$_POST['uuid'] | !$_POST['password'] | !$_POST['uid']){
	$_SESSION['error_messages'] = "Invalid reset";
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

$uuid = $_POST['uuid'];
$password = $_POST['password'];
$user = $_POST['uid'];

if (validate_recovery($user, $uuid)){
	updatePassword($password);
	header('Location: ' . $BASE_URL . 'pages/userpage.php'); 
}
else{
	$_SESSION['error_messages'] = 'Reset not initiated';
	$_SESSION['form_values'] = $_POST;
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}
