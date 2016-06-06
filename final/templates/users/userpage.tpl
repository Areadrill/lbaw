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
			<form action="../actions/projects/create_project.php" method="post" data-toggle="validator" >
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="name" type="text" title="project name" placeholder="Project Name" class="form-control" {literal} pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="description" type="text" title="project description" placeholder="Description" class="form-control" required>
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

<div id="infoEdit" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Edit your info</h4>
			</div>
			<br>
			<form action="../actions/users/edit_info.php" method="post" data-toggle="validator" enctype="multipart/form-data" >
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input id="lepass" name="pass" type="password" title="new password" placeholder="New Password" class="form-control">
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="repass" type="password" title="retype new password" placeholder="Retype New Password" class="form-control" data-match="#lepass" data-match-error="Passwords don't match">
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group has-feedback">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="email" type="text" title="email" value={$email} class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="location" type="text" title="your location" {if !empty($location)} value={$location} {else} placeholder="Your Location" {/if} {literal}	pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="bday" type="date" title="the day you were born" {if !empty($birthday)} value={$birthday} {else} placeholder="Your Birthday" {/if}  class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="education" type="text" title="where you studied" {if !empty($education)} value={$education} {else} placeholder="Your Education" {/if} {literal}	pattern="^([_A-z0-9,\.:]+\s?)+$" {/literal} maxlength="25" class="form-control" required>
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
