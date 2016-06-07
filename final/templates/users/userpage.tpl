{include file='../common/header.tpl'}
<title> Page for {$username} </title>
<link rel="stylesheet" href="../css/custom/userpageStyle.css">
<script src="../javascript/validator.min.js" ></script>
<script src="../javascript/userpage.js" ></script>
</head>
<body>
	 {include file='common/navbar.tpl'}
<div class="container-fluid" >
	<div class="row">
		<div class="col-md-2"></div>
		<!--<div class="vertical-center">-->
		<div class="col-md-8">
			<div id="userPage">
				<ol class="breadcrumb">
					<li><a href="homepage.php">Home</a></li>
					<li><a class="active" href="javascript:window.location.href=window.location.href">{$username}</a></li>
				</ol>
				<div class="col-md-3">
					<div id="customTest">
						<div class="panel panel-default">
							<div id="image-panel" class="panel-body">
								<a id="userImage" href="#"> <img class="img-responsive maxHeight" src={$img} alt="user image" width="200" height="200" /> </a>
								<p id="imageCover" hidden>Edit pic</p>
							</div>
						</div>

						<h2> {$username} </h2>
						<br>
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="row">
									<div class="col-md-7">
										<h4>Your info </h4>
									</div>
									<div class="col-md-2">
										<button data-toggle="modal" data-target="#infoEdit" type="button" class="btn btn-primary"> <span class="glyphicon glyphicon-edit"></span> Edit </button>
									</div>
								</div>
							</div>
							<div class="panel-body">

								<span class="glyphicon glyphicon-globe"></span> {if empty($location)} N/A {else} {$location} {/if}
								<br>
								<span class="glyphicon glyphicon-gift"></span> {if empty($birthday)} N/A {else} {$birthday} {/if}
								<br>
								<span class="glyphicon glyphicon-education"></span> {if empty($education)} N/A {else} {$education} {/if}
								<br>
								<span class="glyphicon glyphicon-calendar"> </span> Joined on {$joinDate}
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-1"></div>
				<div class="col-md-8">
					<div id="todojosprojetos">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="pull-left">Your Projects</h3>
								<button data-toggle="modal" data-target="#newProject" type="button" class="btn btn-primary pull-right button-panel"> <span class="glyphicon glyphicon-plus"></span> New Project </button>
								<div class="input-group pull-right">
									<span class="input-group-addon" id="basic-addon1">Search</span>
									<input id="searcher" type="text" title="search for projects" class="form-control" placeholder="Search your projects" aria-describedby="basic-addon1">
								</div>
								<div class="clearfix"></div>
							</div>
							<div id="listofprojs">
								{foreach from=$projects item=proj}
								<div class="panel-body">
									<div class="panel panel-primary">
										<div class="panel-heading">
											<a class="white-link" href="../pages/projectpage.php?id={$proj.projectid}" data-projid={$proj.projectid}>{$proj.name} by {$proj.creatorName.username}</a>
										</div>
										<div class="panel-body">
											<div class="row">
												<div class="col-md-3">
													<span class="glyphicon glyphicon-inbox"></span> {if $proj.userInfo.tasks.newtaskcount == 0} no {else} {$proj.userInfo.tasks.newtaskcount} {/if} new tasks
												</div>
												<div class="col-md-3">
													<span class="glyphicon glyphicon-comment"></span> {if $proj.userInfo.threads.newthreadcount == 0} no {else} {$proj.userInfo.threads.newthreadcount} {/if} new threads
												</div>
												<div class="col-md-4">
													<span class="glyphicon glyphicon-bell"></span> {if $proj.userInfo.assigned.tasksassignedtouser == 0} no {else} {$proj.userInfo.assigned.tasksassignedtouser} {/if} tasks assigned to you
												</div>
											</div>
										</div>
									</div>
								</div>
								{/foreach}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div id="newProject" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Add a Project</h4>
			</div>
			<br>
			<form id="newProjForm" data-toggle="validator" action="../actions/projects/create_project.php" method="post">
				<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-8">
						<div class="form-group has-feedback">
							<label for="newProjName">Project Name</label>
							<input id="newProjName" name="name" type="text" title="project name" class="form-control" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" required/>
							<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
    						<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="col-sm-2"></div>
				</div>
				<br>
				<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-8">
						<div class="form-group has-feedback">
							<label for="newProjDesc">Description</label>
							<input id="newProjDesc" name="description" type="text" title="project description"  class="form-control" required/>
							<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
    						<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="col-sm-2"></div>
				</div>
				<br>
				<div id="newProjSubWrapper" class="modal-footer">
					<button id="newProjSub" name="submit" type="submit" class="btn btn-primary">Create </button>
				</div>
			</form>
		</div>

	</div>
</div>

<div id="infoEdit" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Edit your info</h4>
			</div>
			<br>
			<form id="infoEditForm" action="../actions/users/edit_info.php" method="post" data-toggle="validator" enctype="multipart/form-data" >
				<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<div class="form-group has-feedback">
								<label for="lepass">New Password</label>
								<input id="lepass" name="pass" type="password" title="new password" class="form-control">
							</div>
						</div>
						<div class="col-sm-2"></div>
				</div>
				<br>
				<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<div class="form-group has-feedback">
								<label for="repass">Retype New Password</label>
								<input id="repass" name="repass" type="password" title="retype new password" class="form-control" data-match="#lepass" data-match-error="Passwords don't match">
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
							</div>
    					<div class="help-block with-errors"></div>
						</div>
						<div class="col-sm-2"></div>
				</div>
				<br>
				<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<div class="form-group has-feedback">
								<label for="email">E-mail</label>
								<input id="email" name="email" type="text" title="email" value={$email} class="form-control" required>
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
							</div>
    					<div class="help-block with-errors"></div>
						</div>
						<div class="col-sm-2"></div>
				</div>
				<br>
				<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<div class="form-group has-feedback">
								<label for="urLoc">Your Location</label>
								<input id="urLoc" name="location" type="text" title="your location" {if !empty($location)} value={$location} {/if} {literal}	pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" class="form-control" required>
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
							</div>
    						<div class="help-block with-errors"></div>
						</div>

						<div class="col-sm-2"></div>
				</div>
				<br>
				<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<div class="form-group has-feedback">
								<label for="birthd">Your Birthday</label>
								<input id="birthd" name="bday" type="date" title="the day you were born" {if !empty($birthday)} value={$birthday} {/if}  class="form-control" required>
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
							</div>
    						<div class="help-block with-errors"></div>
						</div>

						<div class="col-sm-2"></div>
				</div>
				<br>
				<div class="row">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
								<div class="form-group has-feedback">
								<label for="edu">Your Education</label>
								<input id="edu" name="education" type="text" title="where you studied" {if !empty($education)} value={$education} {/if} {literal}	pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" class="form-control" required>
								<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
							</div>
    					<div class="help-block with-errors"></div>
						</div>

						<div class="col-sm-2"></div>
				</div>
				<br>
				<div id="infoEditSubWrapper" class="modal-footer">
					<!--<input name="submit" type="submit" class="btn btn-primary" value="Edit"/>-->
					<button id="infoEditSub" type="submit" name="submit" class="btn btn-primary">Edit</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div id="imageEdit" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Change your profile picture</h4>
			</div>
			<form action="../actions/users/change_picture.php" method="post" enctype="multipart/form-data" >
				<br>
				<div class="row">
					<div class="col-sm-4"></div>
					<div class="col-sm-4">
						<div class="panel panel-default">
							<div class="panel-body">
								<img class="img-responsive maxHeight" src={$img} alt="user image" width="200" height="200" />
							</div>
						</div>
					</div>
					<div class="col-sm-4"></div>
				</div>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="picture" type="file" title="new profile picture" class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>

				<div class="modal-footer">
					<input name="submit" type="submit" class="btn btn-primary" value="Edit"/>
				</div>
			</form>
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

	{include file='../common/footer.tpl'}
