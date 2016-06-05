<?php
	include_once('../../config/init.php');
	include_once($BASE_DIR.'database/tasks.php');

	if(!isset($_SESSION['userid'])){
		error('User was not logged in to the system');
		exit;
	}

	if(!$_POST['taskid'] || !$_POST['tasklid'] || !$_POST['action']){
		error('Missing vital information');
		exit;
	}

	switch($_POST['action']){
		case "assign":
			try{
				$result = assignLabelToTask($_SESSION['userid'], $_POST['taskid'], $_POST['tasklid']);
				if(!$result){
					error('something went wrong');
					http_response_code(404);
					exit;
				}
				else if($result === 'denied'){
					error('insufficient permissions');
					http_response_code(403);
				}
			} catch(PDOException $e){
				echo $e;
				//error('something went wrong');
				exit;
			}
			break;
		case "unassign":
			try{
				$result = unassignLabelFromTask($_SESSION['userid'], $_POST['taskid'], $_POST['tasklid']);
				if(!$result){
					error('something went wrong');
					http_response_code(404);
					exit;
				}
				else if($result === 'denied'){
					error('insufficient permissions');
					http_response_code(403);
				}
			} catch(PDOException $e){
				error('something went wrong');
				exit;
			}
			break;
	}

	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo json_encode(array(getTaskLabels($_POST['taskid']), getLabelsNotInTask($_POST['taskid'], getProjectByTask($_POST['taskid'])), $_POST['taskid']));
	}
	else{
		$_SESSION['success_messages'][] = 'task label operation successful';
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}

function error($msg){
	if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
		echo $msg;
	}
	else{
		$_SESSION['error_messages'][] = $msg;
		header('Location: '. $_SERVER['HTTP_REFERER']);
	}
}
?>
