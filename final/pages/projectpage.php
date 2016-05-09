<?php
  include_once('../config/init.php');
  include_once('../database/projects.php');

  if(!isset($_SESSION['userid'])){
    header('Location: '. $BASE_URL);
    exit;
  }
  $projectID = $_GET['id'];

  if($projectID == null){
    header('Location: '. $BASE_URL . 'pages/user/userpage.php');
    exit;
  }

  $imgPath = "../images/".$_SESSION['userid'].".jpg";
  if(!file_exists($imgPath)){
    $imgPath = "../images/default.jpg";
  }
  
  $smarty->assign('username',$_SESSION['username']);
  $smarty->assign('img',$imgPath);
  $smarty->assign('info', getProjectInfo($projectID));  
  $smarty->display('project/projectpage.tpl');
?>
