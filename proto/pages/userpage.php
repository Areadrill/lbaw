<?php
  include_once('../config/init.php');
  $smarty->assign('username',$_SESSION['username']);
  $imgPath = "../images/".$_SESSION['userid'].".jpg";
  $smarty->assign('img',$imgPath);
  $smarty->display('users/userpage.tpl');
?>
