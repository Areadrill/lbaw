<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
if (!$_POST['email'] || !$_POST['location'] || !$_POST['bday'] || !$_POST['education']) {
	$_SESSION['error_messages'][] = 'All fields are mandatory';
	$_SESSION['form_values'] = $_POST;
	header("Location: ". $BASE_URL ."pages/userpage.php");
	exit;
}


try{
	if($_POST['pass'] === $_POST['repass'] && $_POST['pass'] != ''){
		updatePassword($_POST['pass']);
	}
	else if($_POST['pass'] !== $_POST['repass'] && strlen($_POST['pass']) !== 0){
		$_SESSION['error_messages'] = "Password fields did not match";
		header("Location: " .$BASE_URL ."pages/userpage.php");
		exit;

	}

	updateInfo($_POST['email'], $_POST['location'], $_POST['bday'], $_POST['education'], $_SESSION['userid']);
}
catch(PDOException $e){
	$_SESSION['error_messages'][] = 'Something went wrong';
	header("Location: " .$BASE_URL."pages/userpage.php");
	exit;
}
$_SESSION['success_messages'][] = 'User updated successfully';
header("Location: " .$BASE_URL."pages/userpage.php");
?>
