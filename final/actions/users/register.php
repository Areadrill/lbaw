<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
if (!$_POST['username'] || !$_POST['email'] || !$_POST['password'] || !$_POST['rpassword']) {
	$_SESSION['error_messages'][] = 'All fields are mandatory';
	$_SESSION['form_values'] = $_POST;
	header("Location: ". $BASE_URL . 'pages/homepage.php');
	exit;
}

if ($_POST['rpassword'] != $_POST['password']) {
	$_SESSION['error_messages'][] = 'Passwords don\'t match';
	$_SESSION['form_values'] = $_POST;
	header("Location: ". $BASE_URL . 'pages/homepage.php');
	exit;
}

$email = strip_tags(utf8_encode(strip_tags($_POST['email'])));
$username = strip_tags(utf8_encode(strip_tags($_POST['username'])));
$password = utf8_encode($_POST['password']);

if(length($email) > 100 || length($username) > 25){
	$_SESSION['error_messages'][] = "Too many characters in one of the form's fields";
	return;
}


try {
	createUser($username, $password, $email);
} catch (PDOException $e) {

	if (strpos($e->getMessage(), 'users_pkey') !== false) {
		$_SESSION['error_messages'][] = 'Duplicate username';
		$_SESSION['field_errors']['username'] = 'Username already exists';
	}
	else $_SESSION['error_messages'][] = 'Error creating user';

	$_SESSION['form_values'] = $_POST;
	 header("Location: ". $BASE_URL . 'pages/homepage.php');
	exit;
}
$_SESSION['success_messages'][] = 'User registered successfully';
header("Location: " . $BASE_URL . "pages/userpage.php");
?>
