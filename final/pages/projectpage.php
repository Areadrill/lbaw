<?php
  include_once('../config/init.php');
  echo 'tou aqui 8';
  include_once('../database/threads.php');
  include_once('../database/projects.php');
  include_once('../database/members.php');
  echo 'tou aqui 7';
  include_once('../database/tasks.php');
  echo 'tou aqui 3';
  include_once('../database/tasklists.php');
echo 'tou aqui 6';
  if(!isset($_SESSION['userid'])){
    header('Location: '. $BASE_URL);
    exit;
  }
  $projectID = $_GET['id'];
echo 'tou aqui 5';

  if(checkPrivilege($_SESSION['userid'], $projectID) == null){
    header('Location: '. $BASE_URL . 'pages/userpage.php');
    exit;
  }
echo 'tou aqui 4';
  if($projectID == null){
    header('Location: '. $BASE_URL . 'pages/user/userpage.php');
    exit;
  }
  echo 'tou aqui 3';

 $imgPath = glob("../images/".$_SESSION['userid'].".*")[0];
  if(!file_exists($imgPath)){
    $imgPath = "../images/default.jpg";
  }

  echo 'tou aqui 2';
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
  echo 'tou aqui';
  $smarty->display('project/projectpage.tpl');
?>
