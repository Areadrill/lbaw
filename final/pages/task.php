<?php
include_once('../config/init.php');
include_once('../database/tasks.php');
include_once('../database/members.php');
include_once('../database/projects.php');
include_once('../lib/time.php');

if(!isset($_SESSION['userid'])){
	$_SESSION['error_messages'] = 'You don\'t have permission to view that task';
	header('Location: '. $BASE_URL);
	exit;
}

$taskID = $_GET['taskid'];
$projectID = getProjIDTaskID($taskID)['projectid'];
$role = checkPrivilege($_SESSION['userid'], $projectID);

if($role == null){
	$_SESSION['error_messages'] = 'You don\'t have permission to view that task';
	exit;
}


if($taskID == null){
	$_SESSION['error_messages'] = 'Task doesn\'t exist';
	header('Location: '. $BASE_URL);
	exit;
}
$task = getTaskInfo($taskID);

if(!$task){
	$_SESSION['error_messages'] = "Task doesn't exist";
	header('Location: '. $_SERVER['HTTP_REFERER']);
	exit;
}
$tasklabels = getTaskLabels($taskID);
$notasklabels = getLabelsNotInTask($taskID, $projectID);
$taskcomments = getTaskComments($taskID);
$projectmembers = getMembers(getProjectByTask($taskID));

$imgPath = glob("../images/".$_SESSION['userid'].".*")[0];
 if(!file_exists($imgPath)){
	 $imgPath = $BASE_URL . "images/default.jpg";
 }

for($i = 0; $i < count($taskcomments); $i++){
	$taskcomments[$i]['ago'] = ago(strtotime($taskcomments[$i]['creationinfo']));
}
$projectid = getProjectByTask($taskID);
$smarty->assign('taskid', $taskID);
$smarty->assign('role', $role);
$smarty->assign('projectid', $projectid);
$smarty->assign('username', getUsername($_SESSION['userid']));
$smarty->assign('info', getProjectInfo($projectid));
$smarty->assign('missinglabels', $notasklabels);
$smarty->assign('userid', $_SESSION['userid']);
$smarty->assign('members', $projectmembers);
$smarty->assign('creatorid', $task['creator']);
$smarty->assign('creatorname', $task['creatorName']);
$smarty->assign('complete', $task['complete']);
$smarty->assign('name', $task['name']);
$smarty->assign('assignee', $task['assignee']);
$smarty->assign('assigneeName', $task['assigneeName']);
$smarty->assign('tasklist', $task['taskliid']);
$smarty->assign('tasklistName', $task['tasklistname']);
$smarty->assign('labels', $tasklabels);
$smarty->assign('comments', $taskcomments);
$smarty->assign('img', $imgPath);
$smarty->display('taskpage.tpl');
?>
