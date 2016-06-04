{include file='common/header.tpl'}
	<link rel="stylesheet" href="{$BASE_URL}css/custom/userpageStyle.css">
	<link rel="stylesheet" href="{$BASE_URL}css/custom/taskpage.css">
  <script src="../javascript/validator.min.js" ></script>
	<script src="{$BASE_URL}javascript/taskpage.js"></script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="homepage.php">ProjectHarbor</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-left">
					<li><a href="#about">About</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>

				<form action="../actions/users/logout.php" class="navbar-form navbar-right" role="form">
					<button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-log-out"></span> Sign Out</button>
				</form>
				<div class="navbar-right">
					<div id="mid-of-navbar">
						<a class="white-link" href="userpage.php"> {$username} </a>
						<img src={$img} alt="user image" width="30px" height="30px" />
					</div>
				</div>
			</div>
		</div>
	</nav>
	
   <div class="container">
    <div class="row">
      <div class ="col-md-12">
        <ol class="breadcrumb">
          <li><a href="index.html">Home</a></li>
          <li><a href="{$BASE_URL}pages/userpage.php?userid={$userid}">{$username}</a></li>
          <li><a href="projectpage.html">Project</a></li>
          <li><a href="projectpage.html">Tasks</a></li>
          <li><a class="active" href="#">{$name} </a></li>
        </ol>
      </div>
    </div>
    <div class="row">
      <div class="col-md-8">
        <h1 style="display:inline;">{$name}</h1>
	{foreach from=$labels item=label}	
		<span class="label label-warning">{$label.name}</span>
	{/foreach}
      </div>
      <div class="col-md-4">
        {if $role === 'COORD'}
        <div class="btn-group">
          <button style="margin-top: 0.7em" id="taskLock" taskID={$taskid} type="button" class="btn btn-primary"> {if $isLocked}Unl{else}L{/if}ock Task </button>
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
	Task created by <a href="{$BASE_URL}pages/userpage.php?userid={$creatorid}"> <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <strong>{$creatorname}</a> </p>
      </div>
      <div class="col-md-2 pull-to-bottom">

      </div>
    </div>
    <div class="row">
      <div class="col-md-10">
	  {foreach from=$comments item=comment}
        <div class="row">
          <div class="col-md-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h5><a href="#"><strong><span class="glyphicon glyphicon-user" aria-hidden="true"></span> {$comment.commentorname}</strong></a>
                  <span class="drab">commented 3 days ago </span>
		  {if $creatorid eq $commentor}
		  <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
		  {/if}
                  <a href="#" class="pull-right"><span class="glyphicon glyphicon-remove"></span></a>
                </h5>
              </div>
              <div class="panel-body">
             {$comment.text}   
	      </div>
            </div>
          </div>
        </div>
	{/foreach}
        <div class="row">
          <div class="col-md-12">
            <div class="widget-area no-padding blank">
              <div class="status-upload">
                <form>
                  <textarea placeholder="Comment area" maxlength="512" ></textarea>
                  <ul>
                    <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"><span class="glyphicon glyphicon-music"></span></a></li>
                    <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"><span class="glyphicon glyphicon-facetime-video"></span></a></li>
                    <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"><span class="glyphicon glyphicon-picture"></span></a></li>
                  </ul>
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
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>			<ul class="label-list">
	{foreach from=$labels item=label}	
          <li><a href="#"><span class="label label-warning">{$label.name}</span></a></li>
    	{foreachelse}
	<p> No Labels</p>
	{/foreach}
        </ul>
        <hr/>
        <div class="row">
          <div class="col-md-10">
            <h4 class="drab">Assignee</h4>

          </div>
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>
	{if !empty($assignee)}
        <a href="#"><strong><span class="glyphicon glyphicon-user"  aria-hidden="true"></span> {$assigneeName}</strong></a>
	{else}
	<p> Task not assigned</p>
	{/if}
        <hr/>
        <div class="row">
          <div class="col-md-10">
            <h4 class="drab">Task list</h4>
          </div>
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>
	{if !empty($tasklist)}
        <a href="#"><strong><span class="glyphicon glyphicon-list-alt"  aria-hidden="true"></span> {$tasklistName}</strong></a>
	{else}
	<p> No Task List</p>
	{/if}
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
                  <form class="alignForm" action="../../actions/tasks/remove_task.php" method="post" role="form">
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
 
    {include file='common/footer.tpl'}
