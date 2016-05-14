<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR .'database/threads.php');

	if(!isset($_SESSION['userid'])){
		error('User was not logged in to the system');
		exit;
	}

	if(!$_POST['threadid'] || !$_POST['threadlid'] || !$_POST['action']){
		error('Missing vital information');
		exit;
	}

	switch($_POST['action']){
		case "assign":
			try{
				if(!assignLabelToThread($_SESSION['userid'], $_POST['threadid'], $_POST['threadlid'])){
					error('insufficient permissions');
					exit;
				}
			} catch(PDOException $e){
				echo $e;
				//error('something went wrong');
				exit;
			}
			break;
		case "unassign":
			try{
				if(!unassignLabelFromThread($_SESSION['userid'], $_POST['threadid'], $_POST['threadlid'])){
					error('insufficient permissions');
					exit;
				}
			} catch(PDOException $e){
				error('something went wrong');
				exit;
			}
			break;
	}

	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo json_encode(array(getThreadLabels($_POST['threadid']), getLabelsNotInThread($_POST['threadid']), $_POST['threadid']));
	}
	else{
		$_SESSION['success_messages'][] = 'thread label operation successful';
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}

function error($msg){
	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		error_log($msg);
	}
	else{
		$_SESSION['error_messages'][] = $msg;
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}
}
?>