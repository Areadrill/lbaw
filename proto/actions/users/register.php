<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');  
if (!$_POST['username'] || !$_POST['email'] || !$_POST['password']) {
	$_SESSION['error_messages'][] = 'All fields are mandatory';
	$_SESSION['form_values'] = $_POST;
	//header("Location: $BASE_URL" . 'pages/users/register.php');
	print_r($_POST);
	var_dump('not all variables set');
	exit;
}

$email = utf8_encode(strip_tags($_POST['email']));
$username = utf8_encode(strip_tags($_POST['username']));
$password = utf8_encode($_POST['password']);

$photo = $_FILES['photo'];
$extension = end(explode(".", $photo["name"]));

try {
	createUser($username, $password, $email);
	//move_uploaded_file($photo["tmp_name"], $BASE_DIR . "images/users/" . $username . '.' . $extension); // this is dangerous
	//chmod($BASE_DIR . "images/users/" . $username . '.' . $extension, 0644);
} catch (PDOException $e) {

	var_dump($e.code);
	if (strpos($e->getMessage(), 'users_pkey') !== false) {
		$_SESSION['error_messages'][] = 'Duplicate username';
		$_SESSION['field_errors']['username'] = 'Username already exists';
	}
	else $_SESSION['error_messages'][] = 'Error creating user';

	$_SESSION['form_values'] = $_POST;
	// header("Location: $BASE_URL" . 'pages/users/register.php');
	exit;
}
$_SESSION['success_messages'][] = 'User registered successfully';  
//header("Location: $BASE_URL");
?>
