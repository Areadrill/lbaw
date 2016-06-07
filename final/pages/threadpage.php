<?php
  include_once('../config/init.php');
  include_once('../database/threads.php');
  include_once('../database/projects.php');
  include_once('../database/members.php');
  include_once('../lib/time.php');

  if(!isset($_SESSION['userid'])){
    header('Location: '. $BASE_URL);
    exit;
  }
  $threadID = $_GET['id'];
  $projectID = getProjIDThreadID($threadID)['projectid'];
  $role = checkPrivilege($_SESSION['userid'], $projectID);

  if($role == null){
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

  $threadcomments = getThreadComments($threadID);
  for($i = 0; $i < count($threadcomments); $i++){
	  $threadcomments[$i]['ago'] = ago(strtotime($threadcomments[$i]['creationinfo']));
  }

  $threadInfo = getThreadInfo($threadID);
  $threadInfo['creationinfo'] = ago(strtotime($threadInfo['creationinfo']));

  $smarty->assign('role', $role);
  $smarty->assign('isLocked', isLocked($threadID));
  $smarty->assign('isCreator', $_SESSION['userid'] == getThreadInfo($threadID)['creator']);
  $smarty->assign('img', $imgPath);
  $smarty->assign('labels', getThreadLabels($threadID));
  $smarty->assign('missingLabels', getLabelsNotInThread($threadID));
  $smarty->assign('comments', $threadcomments);
  $smarty->assign('threadInfo', $threadInfo);
  $smarty->assign('projectInfo', getProjectInfo($projectID));
  $smarty->assign('projID', $projectID);
  $smarty->assign('threadID', $threadID);
  $smarty->assign('username', $_SESSION['username']);
  $smarty->display('threadpage.tpl');
?>
