<?php
  include_once('../config/init.php');

  if(isset($_SESSION['userid'])){
  	header('Location: ' . $BASE_URL .'pages/userpage.php');
  	exit;
  }

  $smarty->display('homepage.tpl');
?>
