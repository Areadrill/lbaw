<?php
  include_once('../config/init.php');
  include_once('../database/projects.php');
  $smarty->assign('username',$_SESSION['username']);
  $imgPath = "../images/".$_SESSION['userid'].".jpg";
  $smarty->assign('img',$imgPath);
  $smarty->assign('projects', getProjects($_SESSION['userid']));
  $smarty->display('users/userpage.tpl');
?>
