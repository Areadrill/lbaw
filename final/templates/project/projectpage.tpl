{include file='common/header.tpl'}
<title>{$info.name}</title>
<script src="../javascript/notify.min.js"></script>
<script src="../javascript/projectpage.js"></script>
<script src="../javascript/validator.min.js" ></script>
<link rel="stylesheet" href="../css/custom/userpageStyle.css"> <link rel="stylesheet" href="../css/custom/projectpageStyle.css">
</head>
<body>
	 {include file='common/navbar.tpl'}
	<div class="container">
		<div class="row">
			<div class ="col-md-12">
				<ol class="breadcrumb">
					<li><a href="homepage.php">Home</a></li>
					<li><a href="userpage.php">{$username}</a></li>
					<li><a class="active" href="javascript:window.location.href=window.location.href">{$info.name}</a></li>
				</ol>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 hidden-md-down" style="border-color:black">
				<div class="panel" id="projinfo" style="">
					<div class="panel-body">
						<h3>{$info.name}</h3>
						<ul class="list-group" style="border-left:0px;border-right:0px">
							<li class="list-group-item">Created on {$info.creationdate}</li>
							<li class="list-group-item">{$info.membersNum} team members</li>
							<li class="list-group-item">Created by {$info.creatorName}</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-10">
				<div id="main-content" class="panel panel-default">
					<ul class="nav nav-tabs">
						<li id="descriptionTab" role="presentation" class="active"><a>Description</a></li>
						<li id="tasksTab" role="presentation"><a>Tasks</a></li>
						<li id="tasklistsTab" role="presentation"><a>Task Lists</a></li>
						<li id="forumTab" role="presentation" ><a>Forum</a></li>
						<li id="membersTab" role="presentation"><a>Members</a></li>
						<li id="settingsTab" role="presentation"><a>Settings</a></li>
					</ul>
					<div id="tasks" class="panel panel-default" hidden>
						{if $role == 'COORD'}<button id="taskLabelManage" class="btn btn-link pull-right"><span class="glyphicon glyphicon-cog"></span> Manage labels</button>{/if}
						<div class="row">
							<div class="col-md-8">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2>Tasks<button id="newTask" class="btn btn-primary pull-right"><span class="glyphicon glyphicon-plus"></span> Add Task</button></h2>
									</div>
									<div class="list-group" id="recent-tasks">
										{foreach from=$tasks item=task}
										<a href="../pages/tasks/task.php?taskid={$task.taskid}" class="list-group-item">{$task.name}
											{foreach from=$task.taskLabels item=label}
											<span class="label label-warning">{$label.name}</span>
											{/foreach}
										</a>
										{/foreach}
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div id="taskLabelList" class="list-group">
									<a href="#" class="list-group-item disabled">Tags<span class="badge">{$projectThreadLabelCount}</span></a>
									{foreach from=$projectTaskLabels item=taskLabel}
									<a href="#" class="list-group-item"><span class="label label-primary">{$taskLabel.name}</span><span class="badge">{$taskLabel.count}</span></a>
									{/foreach}

								</div>
							</div>


						</div>

					</div>

				<div id="forum" class="panel panel-default" hidden>
					{if $role == 'COORD'}<button id="labelManage" class="btn btn-link pull-right"><span class="glyphicon glyphicon-cog"></span> Manage labels</button>{/if}
					<br>
					<br>
					<div class="row">
						<div class="col-md-8">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h2>Threads <button id="newThread" class="btn btn-primary pull-right"><span class="glyphicon glyphicon-plus"></span> Add Thread</button></h2>
								</div>
								<div class="list-group" id="recent-threads">
									{foreach from=$threads item=thread}
									<a href="../pages/threadpage.php?id={$thread.threadid}" class="list-group-item">
										<span class="glyphicon glyphicon-comment"></span> {$thread.name}
										{foreach from=$thread.threadLabels item=label} <span class="label label-info">{$label.name}</span>
										{/foreach}
									</a>
									{/foreach}
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="list-group">
								<a href="#" class="list-group-item disabled">Tags<span class="badge">{$projectThreadLabelCount}</span></a>
								{foreach from=$projectThreadLabels item=threadLabel}
								<a data-projid="{$projID}" data-threadlid="{$threadLabel.threadLID}" class="list-group-item filterLabel"><span class="label label-primary">{$threadLabel.name}</span><span class="badge">{$threadLabel.count}</span></a>
								{/foreach}
							</div>
						</div>

					</div>
				</div>

				<div id="createThread" class="modal fade" data-toggle="validator" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Create a new Thread</h4>
							</div>
							<form action="../actions/projects/create_thread.php" data-toggle="validator" method="post" >
								<br>
								<div class="row">
									<div class="form-group">
										<div class="col-sm-2"></div>
										<div class="col-sm-8">
											<input name="projid" type="hidden" value={$projID}>
											<div class="form-group has-feedback">
												<label>Thread title</label>
												<input name="title" type="text" class="form-control" title="new thread name" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="50" required>
												<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											</div>
											<br>
											<div class="form-group">
												<label>Initial comment</label>
												<textarea style="resize: none" class="form-control" title="first comment for the thread" name="initialComment" placeholder="Not necessary" maxlength="512" rows="4" cols="52"></textarea>
											</div>
											<!--eventualmente um dropdown com as tags-->
										</div>
										<div class="col-sm-2"></div>
									</div>
								</div>
								<br>

								<div class="modal-footer">
									<input name="submit" type="submit" class="btn btn-primary" value="Create"/>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div id="createTask" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Create a new Task</h4>
							</div>
							<form role="form" action="{$BASE_URL}actions/tasks/create_task.php" data-toggle="validator" method="post" >
								<br>
								<div class="row">
										<div class="col-sm-2"></div>
										<div class="col-sm-8">
											<input name="projectid" type="hidden" value={$projID}>
											<div class="form-group has-feedback">
												<label>Task name</label>
												<input name="name" type="text" class="form-control" title="new task name" maxlength="50" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} required>
												<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
											</div>
											<br>
											<div class="form-group">
												<label>Initial comment</label>
												<textarea style="resize: none" class="form-control" name="body" title="first comment for the task" maxlength="512" rows="4" cols="52"></textarea>
											</div><!--eventualmente um dropdown com as tags-->
										</div>
										<div class="col-sm-2"></div>
								</div>
								<br>

								<div class="modal-footer">
									<input name="submit" type="submit" class="btn btn-primary" value="Create"/>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div id="manageTaskLabels" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Manage Task Labels</h4>
							</div>
							<div class="modal-body">
							<form id="newTaskLabel" action="../actions/tasks/create_label.php" data-toggle="validator" method="post" >
								<br>
								<div class="row">
									<div class="form-group">
										<div class="col-sm-2"></div>
										<div class="col-sm-8">
											<input name="projectid" type="hidden" value={$projID}>
											<div class="input-group">
												<div class="input-group-btn">
													<button id="newTaskLabelSubmit" type="button" class="btn btn-primary" aria-expanded="false"> Add to Project</button>
												</div><!-- /btn-group -->
												<input id="newTaskLabelName" name="name" type="text" title="new task label name" class="form-control" maxlength="15" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} placeholder="New Label name" aria-label="...">
											</div><!-- /input-group -->
										</div>
										<div class="col-sm-2"></div>
									</div>
								</div>
								<br>
							</form>
							<h4>Current Task Labels</h4>
							<ul class="list-group">
								{foreach from=$projectTaskLabels item=taskLabel}

								<li class="list-group-item clearfix">
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10">
											<div class="row">
												<div class="col-md-3">
													<span class="label label-primary">{$taskLabel.name}</span>
												</div>
												<div class="col-md-4">
													<span class="badge">{$taskLabel.count}</span>
												</div>
												<div class="col-md-5">
													<form class="alignForm" action="../actions/projects/remove_threadlabel.php" method="post" >
														<input type="hidden" name="threadlid" value={$threadLabel.threadlid}>
														<button type="submit" class="btn btn-danger pull-right"> Delete </button>
													</form>
												</div>
											</div>
										</div>
										<div class="col-md-1"></div>
									</div>
								</li>

								{/foreach}
							</ul>
							<br>
						</div>
						</div>
					</div>
				</div>




				<div id="manageLabels" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Manage Thread Labels</h4>
							</div>
							<div class="modal-body">
							<form id="newLabel" action="../actions/projects/create_threadLabel.php" method="post" data-toggle="validator">
								<br>
								<div class="row">
									<div class="form-group">
										<div class="col-sm-2"></div>
										<div class="col-sm-8">
											<input name="projid" type="hidden" value={$projID}>
											<div class="input-group">
												<div class="input-group-btn">
													<button id="newTLSubmmit" type="button" class="btn btn-primary"  aria-expanded="false"> Add to Project</button>
												</div><!-- /btn-group -->
												<input name="name" type="text" class="form-control" title="new thread label name" placeholder="New Label name" maxlength="15" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} aria-label="...">
											</div><!-- /input-group -->
										</div>
										<div class="col-sm-2"></div>
									</div>
								</div>
								<br>
							</form>
							<h4> Current Thread Labels</h4>
							<ul class="list-group">
								{foreach from=$projectThreadLabels item=threadLabel}

								<li class="list-group-item clearfix">
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10">
											<div class="row">
												<div class="col-md-3">
													<span class="label label-primary">{$threadLabel.name}</span>
												</div>
												<div class="col-md-4">
													<span class="badge">{$threadLabel.count}</span>
												</div>
												<div class="col-md-5">
													<form class="alignForm" action="../actions/projects/remove_threadlabel.php" method="post" >
														<input type="hidden" name="threadlid" value={$threadLabel.threadlid}>
														<button type="submit" class="btn btn-danger pull-right"> Delete </button>
													</form>
												</div>
											</div>
										</div>
										<div class="col-md-1"></div>
									</div>
								</li>

								{/foreach}
							</ul>
							<br>
						</div>
						</div>
					</div>
				</div>



				<div id="members" class="panel panel-default" hidden>
					<input id="projectID" type="hidden" name="projectID" value={$projID}>
					<ul class="list-group">
						{foreach from=$members item=member}
						<li class="list-group-item clearfix">
							<div class="row">
								<div class="col-md-1">
									<div class="pull-left">
										<a href="#" style="margin-bottom: 0;" class="thumbnail">
											<img src={$member.picPath} alt={$member.username} height="25" width="25"/>
										</a>

									</div>
								</div>

								<div class="col-md-2 text">
									{$member.username}
								</div>

								<div class="col-md-3 text">
									<span class="glyphicon glyphicon-inbox"></span> {if $member.tasksassigned == 0} no {else} {$member.tasksassigned} {/if} task{if $member.tasksassigned != 1}s{/if} assigned
								</div>

								<div class="col-md-3 text">
									{if $member.roleassigned == "MEMBER"}
									<span class="glyphicon glyphicon-pawn"></span> Team Member
									{else if $member.roleassigned == "COORD"}
									<span class="glyphicon glyphicon-king"></span> Team Coordinator
									{/if}
								</div>


								<div class="pull-right">
									<div class="btn-group" role="group" aria-label="...">
										{if $member.roleassigned == "MEMBER"}
										<form class="alignForm" action="../api/projects/assign_role.php" method="POST" >
											<input type="hidden" name="projectID" value={$projID}>
											<input type="hidden" name="userID" value={$member.userid}>
											<input type="hidden" name="action" value="promote">
											<button type="submit" class="btn btn-success"> <span class="glyphicon glyphicon-upload"></span> Promote</button>
										</form>
										<form  class="alignForm" action="../api/projects/assign_role.php" method="POST" >
											<input type="hidden" name="projectID" value={$projID}>
											<input type="hidden" name="userID" value={$member.userid}>
											<input type="hidden" name="action" value="remove">
											<button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Remove</button>
										</form>
										{else if $member.roleassigned == "COORD"}
										<form  action="../api/projects/assign_role.php" method="POST" >
											<input type="hidden" name="projectID" value={$projID}>
											<input type="hidden" name="userID" value={$member.userid}>
											<input type="hidden" name="action" value="demote">
											<button type="submit" class="btn btn-warning"> <span class="glyphicon glyphicon-download"></span> Demote</button>
										</form>
										{/if}

									</div>
								</div>
							</div>
						</li>
						{/foreach}
					</ul>
					{if $role == 'COORD'}
					<div class="input-group">
						<div class="input-group-btn">
							<button type="button" class="btn btn-primary" aria-expanded="false"> Add to Project</button>
						</div><!-- /btn-group -->
						<input id="userSearcher" type="text" title="search for users" class="form-control" placeholder="Search for users to add" aria-label="...">
					</div><!-- /input-group -->
					<div id="listofusers">
					</div>
					{/if}
				</div>
				<div id="settings" class="panel panel-default" hidden>
					{if $role == 'COORD'}
						<div class="text-center">
							<button id="editproj" type="button" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Edit Project</button>
						</div>
					<br>
						<div class="text-center">
							<button id="deleteproj" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Delete Project</button>
						</div>
						{/if}
					</div>
					<div id="description"  class="panel panel-default">
						<div class="container-fluid">
							<h1>{$info.name}</h1>
							<p> {$info.description}</p>
						</div>
					</div>
					<div id="tasklists" class="panel panel-default" hidden>
						<button id="newTaskList" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Add Task List</button>
						<br>
						<br>
						<ul class="list-group">
							{foreach from=$projectTaskLists item=tasklist}
							<li class="tasklist list-group-item clearfix">
								<div class="row">
									<div class="col-md-3">
										<span class="glyphicon glyphicon-triangle-right"></span> {$tasklist.name}
									</div>
									<div class="col-md-6">
										<div class="progress" style="margin-bottom: 0">
											<div class="progress-bar" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: {math equation="completed / division * 100" completed=$tasklist.completed total=$tasklist.tasks|@count}%;">
												{math equation="completed / division * 100" completed=$tasklist.completed total=$tasklist.tasks|@count}%
											</div>


										</div>
									</div>
									<div class="col-md-2">
										{$tasklist.tasks|@count} tasks associated
									</div>
									<div class="col-md-1">
										{if $role == 'COORD'}
										<span data-tasklistid="{$tasklist.taskliid}" class="manageTask glyphicon glyphicon-cog"></span>
										<span id="removeX" onclick="deleteTaskList({$tasklist.taskliid},{$projID})" class="glyphicon glyphicon-remove removeCross"></span>
											{/if}
										</div>
									</div>
									<div class="row belong">
										<ul>
											{foreach from=$tasklist.tasks item=task}
												<li>{if $task.complete eq true} <span class="glyphicon glyphicon-ok"></span>{/if}<a href="{$BASE_URL}pages/tasks/task.php?taskid={$task.taskid}"> {$task.name}</a></li>
											{/foreach}
										</ul>
									</div>
								</li>
								<div data-tasklistid="{$tasklist.taskliid}" class="modal fade manageTaskList" role="dialog">
									<div class="modal-dialog">
										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
												<h4 class="modal-title">Manage Task List</h4>
											</div>
											<div class="modal-body">
												{foreach from=$tasklist.tasks item=task}
												<div class="row">
													<div class="col-md-3">
														<span class="glyphicon glyphicons-notes-2"></span> {$task.name}
													</div>
													<div class="col-md-8">
													</div>
													<div class="col-md-1">
														<span onclick="removeFromTaskList({$task.taskid}, {$projID})" class="glyphicon glyphicon-remove removeCross"></span>
														</div>
													</div>
												<br>
												{/foreach}
												<div class="dropdown">
													<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Add to task list
														<span class="caret"></span></button>
														<ul class="dropdown-menu">
															{foreach from=$noTaskList item=task}
															<li>{if $task.complete eq true} <span class="glyphicon glyphicon-ok"></span>{/if}<a data-taskliid="{$tasklist.taskliid}" data-taskid="{$task.taskid}"> {$task.name}</a></li>
															{/foreach}
														</ul>
													</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
													<button data-taskliid="{$tasklist.taskliid}" onclick="addToTaskList({$tasklist.taskliid}, {$projID})" type="button" class="addTaskToTL btn btn-primary">Add task</button>
												</div>
											</div>
										</div>
									</div>
								{/foreach}
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

			<div id="bootstrap-alert-box-modal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header" style="min-height:40px;">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title"><strong>ERROR!</strong></h4>
						</div>
						<div class="modal-body">
							{foreach $ERROR_MESSAGES as $error}
							<div class="error">
								{$error}
							</div>
							{/foreach}
						</div>
					</div>
				</div>
			</div>
			<script>
			{if !empty($ERROR_MESSAGES)}
			$(document).ready(function(){
				$("#bootstrap-alert-box-modal").modal('show');
			});
			{/if}
			</script>

			<div id="deleteProjConfirm" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Delete Project</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-8">
									<h4> Are you sure you want to delete this project? </h4>
								</div>
								<div class="col-md-2"></div>
								<div class="row">
									<div class="col-md-5"></div>
									<div class="col-md-3">
										<form class="alignForm" action="../actions/projects/delete_project.php" method="post" >
											<input type="hidden" name="projectID" value={$projID}>
											<button id="deleteConfirm" type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Delete </button>
										</form>
									</div>
									<div class="col-md-4"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="newTaskListModal" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title"> New Task List</h4>
						</div>
						<div class="modal-body">
							<form data-toggle="validator" class="alignForm" action="../actions/tasklist/create_tasklist.php" method="post" >
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8">
										<div class="form-group has-feedback">
											<label>Task List Name</label>
											<input name="name" type="text" title="new tasklist name"  class="form-control" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" required>
											<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
										</div>
									</div>
									<div class="col-md-2"></div>
								</div>
								<br>
								<div class="modal-footer">
										<input type="hidden" name="projectID" value={$projID}>
										<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span> Add Task List </button>
								</div>
							</form>
						</div>
					</div>
					</div>
				</div>

			<div id="editProjDescription" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Edit Project Info</h4>
						</div>
						<div class="modal-body">
							<form class="alignForm" action="../actions/projects/edit_project.php" method="post" >
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8">
										<label>Project Name</label>
										<input name="name" type="text" title="new project name" class="form-control" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" required>
									</div>
									<div class="col-md-2"></div>
								</div>
								<br>
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8">
										<label>Description</label>
										<input name="description" type="text" title="new project description" class="form-control" required>
									</div>
									</div>
									<br>
								</div>
								<div class="modal-footer">
										<input type="hidden" name="projectID" value={$projID}>
										<button id="editConfirm" type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Edit </button>
									</div>
								</form>
							</div>
						</div>
					</div>
			<script type="application/json" id="taskLabels">
			{$projectTaskLabels|@json_encode nofilter}
			</script>

			{include file='common/footer.tpl'}
