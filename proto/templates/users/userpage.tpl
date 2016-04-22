{include file='../common/header.tpl'}
	<link rel="stylesheet" href="../css/custom/userpageStyle.css">
	<script src="../javascript/userpage.js" ></script>
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
				<a class="navbar-brand" href="../../index.html">ProjectHarbor</a>
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
					<a class="white-link" href="userpage.html"> {$username} </a>
					<img src={$img} alt="user image" width="30px" height="30px" />
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>
<div class="container-fluid" >
	<div class="row">
		<div class="col-md-2"></div>
		<!--<div class="vertical-center">-->
		<div class="col-md-8">
			<div id="userPage">
				<ol class="breadcrumb">
					<li><a href="index.html">Home</a></li>
					<li><a class="active" href="#">{$username}</a></li>
				</ol>
				<div class="col-md-3">
					<div id="customTest">
						<div class="panel panel-default">
							<div class="panel-body">
								<img class="img-responsive maxHeight" src={$img} alt="user image" width="200px" height="200px" />
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

								<span class="glyphicon glyphicon-globe"></span> Porto, Portugal
								<br>
								<span class="glyphicon glyphicon-gift"></span> {$birthday}
								<br>
								<span class="glyphicon glyphicon-education"></span> {$education}
								<br>
								<span class="glyphicon glyphicon-calendar"> </span> Joined on 09-03-2016
								<p>...</p>
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
	  								<input id="searcher" type="text" class="form-control" placeholder="Search your projects" aria-describedby="basic-addon1">
								</div>
								<div class="clearfix"></div>
							</div>
							<div id="listofprojs">
								{foreach from=$projects item=proj}
								<div class="panel-body">
									<div class="panel panel-primary">
										<div class="panel-heading">
											<a class="white-link" href="projectpage.html" data-projid={$proj.id}>{$proj.name}</a>
										</div>
										<div class="panel-body">
											<div class="row">
												<div class="col-md-3">
													<span class="glyphicon glyphicon-inbox"></span> 2 new tasks
												</div>
												<div class="col-md-3">
													<span class="glyphicon glyphicon-comment"></span> 1 new thread
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
			<form action="../actions/projects/create_project.php" method="post">
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="name" type="text" placeholder="Project Name" class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="description" type="text" placeholder="Description" class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger">Close</button>
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
      		<form action="../actions/projects/edit_info.php" method="post">
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="bday" type="date" placeholder={$birthday} class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2"></div>
						<div class="col-sm-8">
							<input name="education" type="text" placeholder={$education} class="form-control" required>
						</div>
						<div class="col-sm-2"></div>
					</div>
				</div>
				<br>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger">Close</button>
					<input name="submit" type="submit" class="btn btn-primary" value="Edit"/>
	      </div>
			</form>
      	</div>
	</div>
</div>
{include file='../common/footer.tpl'}
