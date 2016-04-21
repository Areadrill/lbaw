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

function searchProjects($field, $userid){
  global $conn;
  $stmt = $conn->prepare("SELECT name, projectid, creationDate FROM project WHERE (name ILIKE(?) OR description ILIKE(?)) AND projectID IN (SELECT projectID FROM Roles WHERE userID = ?)");
  $stmt->execute(array("%".$field."%","%".$field."%",$userid));
  $res = $stmt->fetchAll();
  return $res;
}
?>
