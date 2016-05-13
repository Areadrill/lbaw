<?php
  include_once('../config/init.php');
  include_once('../database/threads.php');
  include_once('../database/projects.php');

  if(!isset($_SESSION['userid'])){
    header('Location: '. $BASE_URL);
    exit;
  }
  $threadID = $_GET['id'];
  $projectID = getProjIDThreadID($threadID)['projectid'];

  if(checkPrivilege($_SESSION['userid'], $projectID) == null){
    header('Location: '.  $_SERVER['HTTP_REFERER']);
    exit;
  }


  if($threadID == null){
    header('Location: '. $_SERVER['HTTP_REFERER']);
    exit;
  }

 $imgPath = glob("../images/".$_SESSION['userid'].".*")[0];
  if(!file_exists($imgPath)){
    $imgPath = "../images/default.jpg";
  }

  $smarty->assign('labels', getThreadLabels($threadID));
  $smarty->assign('comments', getThreadComments($threadID));
  $smarty->assign('threadInfo', getThreadInfo($threadID));
  $smarty->assign('projectInfo', getProjectInfo($projectID));
  $smarty->assign('projID', $projectID);
  $smarty->assign('threadID', $threadID);
  $smarty->assign('username', $_SESSION['username']);
  $smarty->display('threadpage.tpl');
?>
