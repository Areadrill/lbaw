<?php
	function createProject($name, $description, $creator){
		global $conn;
		$stmt = $conn->prepare('INSERT INTO project VALUES (default, ?, ?, ?, clock_timestamp())');
		$result = $stmt->execute(array($name, $description, $creator));
		if ($result == false){
			error_log('createProject failed due to :' . print_r($conn->errorInfo()) );
			return -1;	
		}
		return $conn->lastInsertId('project_projectid_seq');	
	}
?>
