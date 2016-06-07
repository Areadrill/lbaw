<?php
  include_once('../config/init.php');
  include_once('../database/threads.php');
  include_once('../database/projects.php');
  include_once('../database/members.php');
  include_once('../database/tasks.php');
  include_once('../database/tasklists.php');
  if(!isset($_SESSION['userid'])){
    header('Location: '. $BASE_URL);
    exit;
  }
  $projectID = $_GET['id'];

  if(checkPrivilege($_SESSION['userid'], $projectID) == null){
    header('Location: '. $BASE_URL . 'pages/userpage.php');
    exit;
  }

  if($projectID == null){
    header('Location: '. $BASE_URL . 'pages/user/userpage.php');
    exit;
  }

 $imgPath = glob("../images/".$_SESSION['userid'].".*")[0];
  if(!file_exists($imgPath)){
    $imgPath = "../images/default.jpg";
  }

  $smarty->assign('projID', $projectID);
  $smarty->assign('members', getProjectMembers($projectID));
  $smarty->assign('username',$_SESSION['username']);
  $smarty->assign('img',$imgPath);
  $smarty->assign('role', checkPrivilege($_SESSION['userid'], $projectID));
  $smarty->assign('info', getProjectInfo($projectID));
  $smarty->assign('threads', getThreads($projectID));
  $smarty->assign('tasks', getTasks($projectID));
  $smarty->assign('projectThreadLabels', getProjectThreadLabels($projectID));
  $smarty->assign('projectThreadLabelCount', getThreadLabelCountForProject($projectID));
  $smarty->assign('projectTaskLabels', getProjectTaskLabels($projectID));
  $smarty->assign('projectTaskLists', getProjectTaskLists($projectID));
  $smarty->assign('noTaskList', getTasksNoTaskList($projectID));

  $smarty->display('project/projectpage.tpl');
?>
