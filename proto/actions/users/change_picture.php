<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if(!isset($_FILES['picture'])){
	$_SESSION['error_messages'][] = 'No file found';
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$fileName = explode(".", $_FILES['picture']['name']);
$extension = array_pop($fileName);

//echo $BASE_URL.'/images/'.$_SESSION['userid'].'.'.$extension;
//exit;

$imgPath =  $BASE_DIR.'images/'.$_SESSION['userid'].'.'.$extension;
if(move_uploaded_file($_FILES["picture"]["tmp_name"], $imgPath)){
	$_SESSION['success_messages'][] = "Changed picture successfully.";
}
else{
	$_SESSION['error_messages'][] = "Something went wrong changing the picture.";
}

header('Location: ' . $_SERVER['HTTP_REFERER']);


?>