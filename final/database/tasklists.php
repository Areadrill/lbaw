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
    $res[$i]['tasks'] = getTasksForList($res[$taskliid]);
  }
  return $res;
}

function getTasksForList($taskListID){
  global $conn;
  $stmt = $conn->prepare("SELECT name, taskid FROM task WHERE taskliid = ?");
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
?>
