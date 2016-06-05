<?php
function createTaskList($name, $projID){
  global $conn;
  $stmt = $conn->prepare("INSERT INTO tasklist VALUES (default,?, ?)");
  $stmt->execute(array($projID, $name));
  return $stmt->fetch();
}

function getProjectTaskLists($projID){
  global $conn;
  $stmt = $conn->prepare("SELECT name, taskliid FROM tasklist WHERE projectid = ?");
  $stmt->execute(array($projID));
  $res = $stmt->fetchAll();

  for($i = 0; $i < count($res); $i++){
    $res[$i]['tasks'] = getTasksForList($res[$i]['taskliid']);
    $res[$i]['completed'] = 0;
    for($j = 0; $j < count($res[$i]['tasks']); $j++){
      if($res[$i]['tasks'][$j]['complete'])
        $res[$i]['completed']++;
    }
  }
  return $res;
}

function getTasksForList($taskListID){
  global $conn;
  $stmt = $conn->prepare("SELECT name, taskid, complete FROM task WHERE taskliid = ?");
  $stmt->execute(array($taskListID));
  $res = $stmt->fetchAll();
  return $res;
}

function deleteTaskList($taskListID){
  global $conn;
  $stmt = $conn->prepare("DELETE FROM tasklist WHERE taskliid = ?;");
  $stmt->execute(array($taskListID));
  return $stmt->fetch();
}

function getTasksNoTaskList($projectID){
  global $conn;
  $stmt = $conn->prepare("SELECT name, taskid FROM task WHERE taskliid IS NULL AND projectid = ?;");
  $stmt->execute(array($projectID));
  return $stmt->fetchAll();
}
function addTaskToTaskList($tasklistID, $taskid){
  global $conn;
  $stmt = $conn->prepare("UPDATE task SET taskliid = ? WHERE taskid = ?;");
  $stmt->execute(array($tasklistID, $taskid));
  return $stmt->fetch();
}
?>
