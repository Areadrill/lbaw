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
  $stmt = $conn->prepare("SELECT projectID, name FROM Project WHERE to_tsvector(name) @@ to_tsquery('english',?) OR to_tsvector(description) @@ to_tsquery('english',?) AND projectID IN (SELECT projectID FROM Roles WHERE userID = ?);
");
  $stmt->execute(array($field,$field,$userid));
  $res = $stmt->fetchAll();
  return $res;
}
?>
