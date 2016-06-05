{include file='common/header.tpl'}
<title>ProjectHarbor</title>
<link rel="stylesheet" href="../css/custom/homepageStyle.css">
<script src="../javascript/validator.min.js" ></script>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top" >
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
				<form method="post" action="../actions/users/login.php" class="navbar-form navbar-right" >
					<div class="form-group">
						<input name="username" title="username" type="text" class="form-control" placeholder="Username">
						<input name="password" title="password" type="password" class="form-control" placeholder="Password">
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
							<form id="regForm" method="post" action="../actions/users/register.php" data-toggle="validator" >
								<div class="form-group has-feedback">
									<div class="input-group">
										<span id="userThing" class="input-group-addon"> <span class="glyphicon glyphicon-user"></span></span>
										<input id="username" name="username" title="username" type="text" {literal}	pattern="^[_A-z0-9]{1,}$" {/literal} class="form-control" placeholder="Username" maxlength="25" required>
															
									</div>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
    								<div class="help-block with-errors"></div>
								</div>

								<div class="form-group has-feedback">
									<div class="input-group">
										<span id="emailThing" class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
										<input id="email" name="email" title="email" type="email" class="form-control" placeholder="E-mail" maxlength="100" required>
									</div>
									<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
    								<div class="help-block with-errors"></div>
								</div>
								
								<div class="form-group">
									<div class="input-group">
										<span id="passwordThing" class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
										<input id="password" name="password" title="password" type="password" class="form-control" placeholder="Password" required>
									</div>
								</div>

								<div class="form-group">
									<div class="input-group">
										<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
										<input id="rpassword" name="rpassword" title="retype password" type="password" class="form-control" placeholder="Re-enter password" data-match="#password" data-match-error="Passwords don't match" required>
									</div>
								</div>
								
								<button type="submit" name="submit" class="btn btn-default">Sign Up</button>
								<a data-toggle="modal" data-target="#recover" role="button">Lost your password?</a>
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
						<form action="../actions/users/recover.php" method="post" >
							<div class="row">
								<div class="form-group">
									<div class="col-sm-2"></div>
									<div class="col-sm-8">
										<input name="email" type="email" title="email" placeholder="Email" class="form-control" maxlength="100" required>
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
