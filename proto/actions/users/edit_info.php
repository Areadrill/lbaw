<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');  
if (!$_POST['bday'] || !$_POST['education']) {
	$_SESSION['error_messages'][] = 'All fields are mandatory';
	$_SESSION['form_values'] = $_POST;
	//header("Location: $BASE_URL" . 'pages/users/register.php');
	print_r($_POST);
	var_dump('not all variables set');
	exit;
}

$education = utf8_encode(strip_tags($_POST['education']));

try{
	updateInfo($_POST['bday'], $education, $_SESSION['userid']);
}
catch(PDOException $e){
	echo "NUM DEU PAH\n";
	var_dump($e);
	echo "\n\n\n";
	var_dump($education);
	echo "\n\n\n";
	var_dump($_POST['bday']);
	$_SESSION['error_messages'][] = 'Something went wrong'; 
	exit;
}
$_SESSION['success_messages'][] = 'User registered successfully'; 
header("Location: $BASE_URL".'/pages/userpage.php');
?>
