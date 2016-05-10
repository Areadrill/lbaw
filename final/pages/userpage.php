<?php
  include_once('../config/init.php');
  include_once('../database/projects.php');
  include_once('../database/users.php');

  if(!isset($_SESSION['userid'])){
    header('Location: '. $BASE_URL);
    exit;
  }


  $info = getUserInfo($_SESSION['userid']);

  $smarty->assign('username',$_SESSION['username']);

  $imgPath = glob("../images/".$_SESSION['userid'].".*")[0];
  if(!file_exists($imgPath)){
    $imgPath = "../images/default.jpg";
  }
  $smarty->assign('img',$imgPath);
  $smarty->assign('projects', getProjects($_SESSION['userid']));
  $smarty->assign('email', getUserEmail($_SESSION['userid']));
  $smarty->assign('location', $info['location']);
  $smarty->assign('birthday', $info['birthday']);
  $smarty->assign('education', $info['education']);
  $smarty->assign('joinDate', date('Y-m-d', strtotime($info['joindate'])));
  $smarty->display('users/userpage.tpl');
?>
