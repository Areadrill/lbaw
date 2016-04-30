<?php
function createProject($name, $description,$userid){
  global $conn;
  $stmt = $conn->prepare("INSERT INTO Project VALUES (default,?, ?, ?, clock_timestamp())");
  $stmt->execute(array($name, $description,$userid));
  return $stmt->fetch() == true;
}

function getProjects($userid){
  global $conn;
  $stmt = $conn->prepare("SELECT name, projectID FROM Project WHERE projectID IN (SELECT projectID FROM Roles WHERE userID = ?)");
  $stmt->execute(array($userid));
  $res = $stmt->fetchAll();
  return $res;
}

function getNewInfo($userid, $projid){
  global $conn;

  $stmt = $conn->prepare("SELECT COUNT(taskID) AS NewTaskCount FROM Task WHERE projectID = ? AND creationInfo > (SELECT lastLogout FROM Users WHERE userID = ?)");
  $stmt->execute(array($userid, $projid));
  $res['tasks'] = $stmt->fetch();

  $stmt = $conn->prepare("SELECT COUNT(threadID) AS NewThreadCount FROM Thread WHERE projectID = $projid AND creationInfo > (SELECT lastLogout FROM Users WHERE userID = $userid");
  $stmt->execute(array($userid, $projid));
  $res['threads'] = $stmt->fetch();

  $stmt = $conn->prepare("SELECT COUNT(taskID) AS TasksAssignedToUser FROM Task WHERE projectID = $projid AND assignee = $userid");
  $stmt->execute(array($userid, $projid));
  $res['assigned'] = $stmt->fetch();

  return $res;

}

function searchProjects($field, $userid){
  global $conn;
  $stmt = $conn->prepare("SELECT projectID, name FROM Project WHERE to_tsvector(name) @@ to_tsquery('english',?) OR to_tsvector(description) @@ to_tsquery('english',?) AND projectID IN (SELECT projectID FROM Roles WHERE userID = ?);
");
  $stmt->execute(array($field.':*',$field.':*',$userid));
  $res = $stmt->fetchAll();
  return $res;
}
?>
