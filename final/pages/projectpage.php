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

  $smarty->display('project/projectpage.tpl');
?>
