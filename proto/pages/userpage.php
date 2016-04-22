<?php
  include_once('../config/init.php');
  include_once('../database/projects.php');
  include_once('../database/users.php');

  $info = getUserInfo($_SESSION['userid']);

  $smarty->assign('username',$_SESSION['username']);
  $imgPath = "../images/".$_SESSION['userid'].".jpg";
  if(!file_exists($imgPath)){
    $imgPath = "../images/default.jpg";
  }
  $smarty->assign('img',$imgPath);
  $smarty->assign('projects', getProjects($_SESSION['userid']));
  $smarty->assign('birthday', $info['birthday']);
  $smarty->assign('education', $info['education']);
  $smarty->display('users/userpage.tpl');
?>
