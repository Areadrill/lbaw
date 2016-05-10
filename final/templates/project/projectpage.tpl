{include file='common/header.tpl'}
	<script src="../javascript/projectpage.js"></script>
	<link rel="stylesheet" href="../css/custom/userpageStyle.css">
	<link rel="stylesheet" href="../css/custom/projectpageStyle.css">
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

				<form action="../actions/users/logout.php" class="navbar-form navbar-right" role="logout">
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
						<li id="descriptionTab" role="presentation" class="active"><a href="#">Description</a></li>
						<li id="tasksTab" role="presentation"><a href="#">Tasks</a></li>
						<li id="tasklistsTab" role="presentation"><a href="#">Task Lists</a></li>
						<li id="forumTab" role="presentation" ><a href="#">Forum</a></li>
						<li id="membersTab" role="presentation"><a href="#">Members</a></li>
					</ul>
					<div id="tasks" class="panel panel-default" hidden>
						<div class="row">
							<div class="col-md-8">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2>Recent Tasks</h2>
									</div>
									<div class="list-group" id="recent-tasks">
										<a href="taskpage.html" class="list-group-item">Finish documentation<span class="label label-warning">Master</span></a>
										<a href="taskpage.html" class="list-group-item">Add lists of taks<span class="label label-success">Features</span></a>
										<a href="taskpage.html" class="list-group-item">Add project progress bar<span class="label label-success text-left">Features</span></a>
										<a href="taskpage.html" class="list-group-item">Fix log in button<span class="label label-danger">Bug fixes</span></a>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="list-group">
									<a href="#" class="list-group-item active">All<span class="badge">7</span></a>
									<a href="#" class="list-group-item"><span class="label label-danger">Bug fixes</span><span class="badge">1</span></a>
									<a href="#" class="list-group-item"><span class="label label-warning">Master</span><span class="badge">0</span></a>
									<a href="#" class="list-group-item"><span class="label label-success">Features</span><span class="badge">1</span></a>
								</div>
							</div>

						</div>
					</div>
					<div id="forum" class="panel panel-default" hidden>
						<button class="btn btn-link pull-right"><span class="glyphicon glyphicon-cog"></span> Manage labels</button>
						<br>
						<br>
						<div class="row">
							<div class="col-md-8">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h2>Threads <button class="btn btn-primary pull-right"><span class="glyphicon glyphicon-plus"></span> Add Thread</button></h2>
									</div>
									<div class="list-group" id="recent-tasks">
									{foreach from=$threads item=thread}
										<a href="thread.html" class="list-group-item">
											<span class="glyphicon glyphicon-comment"></span> {$thread.name}
											{foreach from=$thread.threadLabels item=label}
												<span class="label label-info">$label.name</span>
											{/foreach}
										</a>
									{/foreach}
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="list-group">
									<a href="#" class="list-group-item disabled">Tags<span class="badge">2</span></a>
									<a href="#" class="list-group-item"><span class="label label-danger">Bug fixes</span><span class="badge">1</span></a>
									<a href="#" class="list-group-item"><span class="label label-primary">Back-end</span><span class="badge">0</span></a>
									<a href="#" class="list-group-item"><span class="label label-info">Front-end</span><span class="badge">1</span></a>
									<a href="#" class="list-group-item"><span class="label label-success">Documents</span><span class="badge">1</span></a>
								</div>
							</div>

						</div>
					</div>
					<div id="members" class="panel panel-default" hidden>
						<ul class="list-group">
							{foreach from=$members item=member}
								<li class="list-group-item clearfix">
									<div class="row">
										<div class="col-md-1">
											<div class="pull-left">
												<a href="#" style="margin-bottom: 0;"class="thumbnail">
													<img src="https://sigarra.up.pt/feup/pt/FOTOGRAFIAS_SERVICE.foto?pct_cod=231081" alt="ademar aguiar" height="25px" width="25px"/>
												</a>

											</div>
										</div>

										<div class="col-md-2 text">
											{$member.username}
										</div>

										<div class="col-md-3 text">
											<span class="glyphicon glyphicon-inbox"></span> 1 task assigned
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
												<button type="button" class="btn btn-success"> <span class="glyphicon glyphicon-upload"></span> Promote</button>
												<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Remove</button>
												{else if $member.roleassigned == "COORD"}
												<button type="button" class="btn btn-warning"> <span class="glyphicon glyphicon-download"></span> Demote</button>
												{/if}

											</div>
										</div>
									</div>
								</li>
							{/foreach}
							<li class="list-group-item clearfix">
								<div class="row">
									<div class="col-md-1">
										<div class="pull-left">
											<a href="#" style="margin-bottom: 0;"class="thumbnail">
												<img src="https://sigarra.up.pt/feup/pt/FOTOGRAFIAS_SERVICE.foto?pct_cod=231081" alt="ademar aguiar" height="25px" width="25px"/>
											</a>

										</div>
									</div>

									<div class="col-md-2 text">
										AAguiar
									</div>

									<div class="col-md-3 text">
										<span class="glyphicon glyphicon-inbox"></span> 1 task assigned
									</div>

									<div class="col-md-3 text">
										<span class="glyphicon glyphicon-pawn"></span> Team Member
									</div>


									<div class="pull-right">
										<div class="btn-group" role="group" aria-label="...">
											<button type="button" class="btn btn-success"> <span class="glyphicon glyphicon-upload"></span> Promote</button>
											<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Remove</button>
										</div>
									</div>
								</div>
							</li>
							<li class="list-group-item clearfix">
								<div class="row">
									<div class="col-md-1">
										<div class="pull-left">
											<a href="#" style="margin-bottom: 0;"class="thumbnail">
												<img src="https://sigarra.up.pt/feup/pt/FOTOGRAFIAS_SERVICE.foto?pct_cod=209810" alt="magalhaes cruz" height="25px" width="25px"/>
											</a>

										</div>
									</div>

									<div class="col-md-2 text">
										MCruz
									</div>

									<div class="col-md-3 text">
										<span class="glyphicon glyphicon-inbox"></span> 3 task assigned
									</div>

									<div class="col-md-3 text">
										<span class="glyphicon glyphicon-king"></span> Team Coordinator
									</div>

									<div class="pull-right">
										<div class="btn-group" role="group" aria-label="...">
											<button type="button" class="btn btn-warning"> <span class="glyphicon glyphicon-download"></span> Demote</button>
										</div>
									</div>
								</div>
							</li>
						</ul>
						<div class="input-group">
							<div class="input-group-btn">
								<button type="button" class="btn btn-primary" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Add to Project</button>
							</div><!-- /btn-group -->
							<input type="text" class="form-control" placeholder="Search for users to add" aria-label="...">
						</div><!-- /input-group -->
					</div>
					<div id="description"  class="panel panel-default">
						<div class="container-fluid">
							<h1> {$info.name} </h1>
							<p> {$info.description}</p>
						</div>
					</div>
					<div id="tasklists" class="panel panel-default" hidden>
						<ul class="list-group">
							<li class="list-group-item clearfix">
								<div class="row">
									<div class="col-md-3">
										<span class="glyphicon glyphicon-flag"></span> Documentation
									</div>
									<div class="col-md-6">
										<div class="progress" style="margin-bottom: 0">
											<div class="progress-bar" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 90%;">
												90%
											</div>
										</div>
									</div>
										<div class="col-md-3">
											4 tasks associated
										</div>
									</div>

							</li>
							<li class="list-group-item clearfix">
								<div class="row">
									<div class="col-md-3">
										<span class="glyphicon glyphicon-flag"></span> Front-end
									</div>
									<div class="col-md-6">
										<div class="progress" style="margin-bottom: 0">
											<div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: 30%;">
												30%
											</div>
										</div>
									</div>
										<div class="col-md-3">
											2 tasks associated
										</div>
									</div>

							</li>
							<li class="list-group-item clearfix">
								<div class="row">
									<div class="col-md-3">
										<span class="glyphicon glyphicon-flag"></span> Back-end
									</div>
									<div class="col-md-6">
										<div class="progress" style="margin-bottom: 0">
											<div class="progress-bar" role="progressbar" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" style="width: 10%;">
												10%
											</div>
										</div>
									</div>
										<div class="col-md-3">
											0 tasks associated
										</div>
									</div>

							</li>

					</div>
				</div>
			</div>
		</div>
	</div>
	{include file='common/footer.tpl'}
