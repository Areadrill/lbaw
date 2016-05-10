<?php
include_once("../../config/init.php");
include_once("../../database/users.php");
if (!$_POST['uuid'] | !$_POST['password'] | !$_POST['uid']){
	$_SESSION['error_messages'] = "Invalid reset";
	header('Location: ' . $_SERVER['HTTP_REFERER']);
}

$uuid = $_POST['uuid'];
$password = $_POST['password'];
$user = $_POST['uid'];

if (validateRecovery($user, $uuid)){
	if(resetPassword($password, $user)){
		deleteRecovery($uuid);
		header('Location: ' . $BASE_URL . 'pages/homepage.php'); 
	}
	else{
		$_SESSION['error_messages'] = 'Could not change password';
		header('Location: ' . $BASE_URL . 'pages/passwordreset.php?uuid='.$_POST['uuid'].'&userid='.$_POST['uid']);
	}
}
else{
	$_SESSION['error_messages'] = 'Reset not initiated';
	header('Location: ' . $BASE_URL.'pages/homepage.php');
}
