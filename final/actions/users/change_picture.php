<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

if(!isset($_FILES['picture'])){
	$_SESSION['error_messages'][] = 'No file found';
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}

$allowedExtensions = array('jpg', 'jpeg', 'png', 'tiff', 'bmp', 'svg', 'gif');

//$fileName = explode(".", $_FILES['picture']['name']);
//$extension = array_pop($fileName);


$fileType = explode("/", mime_content_type($_FILES["picture"]["tmp_name"]));
if($fileType[0] !== 'image'){
	$_SESSION['error_messages'][] = 'The file you chose doesn\'t appear to be an image.';
}



if(!in_array(array_pop($fileType), $allowedExtensions)){
	$_SESSION['error_messages'][] = 'The file you chose did not a have extension characteristic of an image.';
	header('Location: ' . $_SERVER['HTTP_REFERER']);
	exit;
}




$imgPath =  $BASE_DIR.'images/'.$_SESSION['userid'].'.'.$extension;
if(move_uploaded_file($_FILES["picture"]["tmp_name"], $imgPath)){
	$_SESSION['success_messages'][] = "Changed picture successfully.";
}
else{
	$_SESSION['error_messages'][] = "Something went wrong changing the picture.";
}

header('Location: ' . $_SERVER['HTTP_REFERER']);


?>
