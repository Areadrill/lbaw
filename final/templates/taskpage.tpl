{include file='common/header.tpl'}
<title>{$name} on {$info.name}</title>
<link rel="stylesheet" href="{$BASE_URL}css/custom/userpageStyle.css">
<link rel="stylesheet" href="{$BASE_URL}css/custom/taskpage.css">
<script src="{$BASE_URL}javascript/taskpage.js"></script>
</head>
<body>
	{include file='common/navbar.tpl'}

		<div class="container">
			<div class="row">
				<div class ="col-md-12">
					<ol class="breadcrumb">
						<li><a href="{$BASE_URL}">Home</a></li>
						<li><a href="{$BASE_URL}pages/userpage.php?userid={$userid}">{$username}</a></li>
						<li><a href="{$BASE_URL}pages/projectpage.php?id={$projectid}">{$info.name}</a></li>
						<li><a href="{$BASE_URL}pages/projectpage.php?id={$projectid}">Tasks</a></li>
						<li><a class="active" href="#">{$name} </a></li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8" id="nameandlabels">
					<h1 style="display:inline;">{$name}</h1>
					{foreach from=$labels item=label}
					<span class="label label-warning">{$label.name}</span>
					{/foreach}
				</div>
				<div class="col-md-4">
					{if $role === 'COORD'}
					<div class="btn-group">
						<button style="margin-top: 0.7em" id="taskDelete" type="button" class="btn btn-primary"> Delete Task </button>
					</div>
					{/if}
				</div>

			</div>
			<br>
			<div class="row">
				<div class="col-md-12 pull-to-bottom">
					<p >
						{if $complete eq true}
						<a class="btn btn-success btn-sm" href="#" role="button">Complete </a>
						{else}
						<a class="btn btn-danger btn-sm" href="#" role="button">Not Complete </a>
						{/if}
						Task created by <a href="{$BASE_URL}pages/userpage.php?userid={$creatorid}"> <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <strong>{$creatorname}</strong></a> </p>
					</div>
					<div class="col-md-2 pull-to-bottom">
      </div>
    </div>
    <div class="row">
      <div class="col-md-10" >
      	<div id="commentListArea">
	  {foreach from=$comments item=comment}
        <div class="row">
          <div class="col-md-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h5><a href="#"><strong><span class="glyphicon glyphicon-user" aria-hidden="true"></span> {$comment.commentorname}</strong></a>
                  <span class="drab">commented {$comment.ago}</span>
		  {if $creatorid eq $commentor or $role == 'COORD'}
		  <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
			<a href="#" class="pull-right submitRemoveComment" role="button"><input type="hidden" name="commentid" value={$comment.taskcid}><span class="glyphicon glyphicon-remove"></span></a>
		  {/if}

                </h5>
              </div>
              <div class="panel-body">
             {$comment.text}
	      </div>
            </div>
          </div>
        </div>
	{/foreach}
		</div>
        <div class="row" id="formRow">
          <div class="col-md-12">
            <div class="widget-area no-padding blank">
              <div class="status-upload">
                <form id="createCommentForm" action="{$BASE_URL}actions/tasks/create_comment.php" method="post">
                  <textarea placeholder="Comment area" title="comment" placeholder="Write your comment here" maxlength="512" ></textarea>
                  <ul>
                    <li style="margin-top:0.7em"><input id="completeForm" value="Mark compeleted" type="checkbox" name="completed"><label for="completeForm"> Mark as complete</label> </li>
                  </ul>
		  <input type="hidden" id="taskidForm" value="{$taskid}">
                  <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-send"></span> Comment</button>
                </form>
              </div><!-- Status Upload  -->
            </div><!-- Widget Area -->
          </div>
        </div>
      </div>
					<div class="col-md-2 sidebar">
						<div class="row">
							<div class="col-md-10">
								<h4 class="drab">Labels</h4>
							</div>
							<div class="col-md-2">{if ($role === 'COORD' || $isCreator)} <div id="taskLabelManage" class="col-md-2"><span class="optionDialog glyphicon glyphicon-cog"></span></div> {/if}</div>
						</div>
						<ul class="label-list">
							{foreach from=$labels item=label}
							<li><a href="#"><span class="label label-warning">{$label.name}</span></a></li>
							{foreachelse}
							<li><p> No Labels</p></li>
							{/foreach}
						</ul>
						<hr/>
						<div class="row">
							<div class="col-md-10">
								<h4 class="drab">Assignee</h4>

							</div>
							<div class="col-md-2">{if ($role === 'COORD' || $isCreator)} <div id="assigneeManage" class="col-md-2"><span class="optionDialog glyphicon glyphicon-cog"></span></div> {/if}</div>
						</div>
						{if !empty($assignee)}
						<strong><span class="glyphicon glyphicon-user"  aria-hidden="true"></span> {$assigneeName}</strong>
						{else}
						<p> Task not assigned</p>
						{/if}
						<hr/>
						<div class="row">
							<div class="col-md-10">
								<h4 class="drab">Task list</h4>
							</div>
							<div class="col-md-2">{if ($role === 'COORD' || $isCreator)} <div id="tasklistManage" class="col-md-2"><span class="optionDialog glyphicon glyphicon-cog"></span></div> {/if}</div>
						</div>
						{if !empty($tasklist)}
						<a href="#"><strong><span class="glyphicon glyphicon-list-alt"  aria-hidden="true"></span>{$tasklistName}</strong></a>
						{else}
						<p> No Task List</p>
						{/if}
					</div>
				</div>
			</div>
				<div id="deleteTaskConfirm" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Delete Task</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8">
										<h4> Are you sure you want to delete this task? </h4>
									</div>
									<div class="col-md-2"></div>
									<div class="row">
										<div class="col-md-5"></div>
										<div class="col-md-3">
											<form class="alignForm" action="{$BASE_URL}actions/tasks/remove_task.php" method="post">
												<input type="hidden" name="taskid" value={$taskid}>
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

				<div id="manageAssignee" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Manage this Task's Assignee</h4>
							</div>
							<div class="modal-body">
							{if !empty($assignee)}
							<h4> Current Assignee</h4>
							<ul id="assignee" class="list-group">
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-10">
										<li class="list-group-item clearfix">
											<div class="row">
												<div class="col-md-3">
													<span class="label label-info">{$assigneeName}</span>
												</div>
												<div class="col-md-5">
													<form class="alignForm" action="{$BASE_URL}actions/tasks/assign_task.php" method="post">
														<input type="hidden" name="taskid" value={$taskid}>
														<input type="hidden" name="userid" value="-1">
														<button type="submit" class="btn btn-primary pull-right"> Unassign </button>
													</form>
												</div>
											</div>
										</li>
									</div>
									<div class="col-md-6"></div>
								</div>
							</ul>
							{/if}
							<br>
							<h4> New Assignee</h4>
							<ul id="labelsNotInThread" class="list-group">
								{foreach from=$members item=member}

										<li class="list-group-item clearfix">
										<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-10">
											<div class="row">
												<div class="col-md-4">
													<span >{$member.username}</span>
												</div>
												<div class="col-md-4">
													<form class="alignForm " action="{$BASE_URL}actions/tasks/assign_task.php" method="post">
														<input type="hidden" name="taskid" value={$taskid}>
														<input type="hidden" name="userid" value={$member.userid}>
														<button type="submit" class="btn btn-primary pull-right"> Assign </button>
													</form>
												</div>
											</div>
											</div>
									<div class="col-md-4"></div>
								</div>
										</li>

								{/foreach}
							</ul>
							<br>
							</div>
						</div>
					</div>
				</div>
				<div id="manageTaskLabels" class="modal fade" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Manage this Task's Labels</h4>
							</div>
							<div class="modal-body">
							<h4> Current Task Labels</h4>
							<ul id="currTaskLabels" class="list-group">
								{foreach from=$labels item=label}

								<li class="list-group-item clearfix">
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10">
											<div class="row">
												<div class="col-md-3">
													<span class="label label-info">{$label.name}</span>
												</div>
												<div class="col-md-5">
													<form class="alignForm labelOp" action="{$BASE_URL}api/tasks/assign_label.php" method="post" >
														<input type="hidden" name="taskid" value={$taskid}>
														<input type="hidden" name="tasklid" value={$label.tasklid}>
														<input type="hidden" name="action" value="unassign" >
														<button type="submit" class="btn btn-primary pull-right"> Unassign </button>
													</form>
												</div>
											</div>
										</div>
										<div class="col-md-6"></div>
									</div>
								</li>

								{/foreach}
							</ul>
							<br>
							<h4> Project Labels </h4>
							<ul id="labelsNotInTask" class="list-group">
								{foreach from=$missinglabels item=mLabel}
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-10">
										<li class="list-group-item clearfix">
											<div class="row">
												<div class="col-md-4">
													<span class="label label-info">{$mLabel.name}</span>
												</div>
												<div class="col-md-4">
													<form class="alignForm labelOp" action="{$BASE_URL}api/tasks/assign_label.php" method="post">
														<input type="hidden" name="taskid" value={$taskid}>
														<input type="hidden" name="tasklid" value={$mLabel.tasklid}>
														<input type="hidden" name="action" value="assign" >
														<button type="submit" class="btn btn-primary pull-right"> Assign </button>
													</form>
												</div>
											</div>
										</li>
									</div>
									<div class="col-md-4"></div>
								</div>
								{/foreach}
							</ul>
							<br>
							</div>
						</div>
					</div>
				</div>



				{include file='common/footer.tpl'}
