<?php
include_once('../config/init.php');
session_start();
$smarty->assign('username',$_SESSION['username']);
$imgPath = "../images/".$_SESSION['userid'].".jpg";
$smarty->assign('img',$imgPath);
$smarty->display('users/userpage.tpl');
?>
