<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');  
if (!$_POST['email'] || !$_POST['bday'] || !$_POST['education']) {
	$_SESSION['error_messages'][] = 'All fields are mandatory';
	$_SESSION['form_values'] = $_POST;
	print_r($_POST);
	var_dump('not all variables set');
	exit;
}

try{
	updateInfo($_SESSION['userid'], $_POST['email'], $_POST['bday'], $_POST['education']);
}
catch(PDOException $e){
	$_SESSION['error_messages'][] = 'Something went wrong'; 
	exit;
}
$_SESSION['success_messages'][] = 'User registered successfully'; 
?>