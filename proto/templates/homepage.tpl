{include file='common/header.tpl'}
<link rel="stylesheet" href="../css/custom/homepageStyle.css">
<script rel="text/javascript" src="../javascript/homepage.js"></script>
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
				<a class="navbar-brand" href="index.html">ProjectHarbor</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-left">
					<li><a href="#about">About</a></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
				<form method="post" action="../actions/users/login.php" class="navbar-form navbar-right" role="login">
					<div class="form-group">
						<input name="username" type="text" class="form-control" placeholder="Username">
						<input name="password" type="password" class="form-control" placeholder="Password">
					</div>
					<button type="submit" class="btn btn-default">Sign In</button>
				</form>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="vertical-center" >
					<div class="panel panel-default ">
						<div class="panel-body">
							<h3 class="panel-title">Sign Up</h3>
						</div>
						<div class="panel-body">
							<form method="post" action="../actions/users/register.php">
								<div class="input-group">
									<input name="username" type="text" class="form-control" placeholder="Username">
									<span class="input-group-addon"> <span class="glyphicon glyphicon-user"></span></span>
								</div>
								<br>
								<div class="input-group">
									<input name="email" type="email" class="form-control" placeholder="E-mail">
									<span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
								</div>
								<br>
								<div class="input-group">
									<input name="password" type="password" class="form-control" placeholder="Password">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
								</div>
								<br>
								<div class="input-group">
									<input name="rpassword" type="password" class="form-control" placeholder="Re-enter password">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
								</div>
								<br>
								<button type="submit" val="submit" name="submit" class="btn btn-default">Sign Up</button>
								<a data-toggle="modal" data-target="#recover" href="#">Lost your password?</a>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="recover" class="modal fade" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Recover password</h4>
						</div>
						<br>
						<form action="../actions/users/recover.php" method="post">
							<div class="row">
								<div class="form-group">
									<div class="col-sm-2"></div>
									<div class="col-sm-8">
										<input name="email" type="email" placeholder="Email" class="form-control" required>
									</div>
									<div class="col-sm-2"></div>
								</div>
							</div>
							<br>
							<br>
							<div class="modal-footer">
								<input name="submit" type="submit" class="btn btn-primary" value="Submit"/>
							</div>
						</form>
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
	{if !empty($ERROR_MESSAGES)}
	<script>
	$(document).ready(function(){
		$("#bootstrap-alert-box-modal").modal('show');
	});
	</script>

	{/if}
	{include file='common/footer.tpl'}
