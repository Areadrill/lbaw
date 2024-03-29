{include file='common/header.tpl'}
<link rel="stylesheet" href="../css/custom/homepageStyle.css">
<script src="../javascript/validator.min.js" ></script>
<title>ProjectHarbor - Password Recovery </title>
</head>
<body>
	{include file='common/navbar.tpl'}

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="vertical-center" >
					<div class="panel panel-default ">
						<div class="panel-body">
							<h3 class="panel-title">Recover Password</h3>
						</div>
						<div class="panel-body">
							<form method="post" action="../actions/users/reset_password.php" data-toggle="validator">
								<div class="input-group" style="display:none">
									<input name="uid" type="text" title="username" class="form-control" value="{$userid}" hidden="hidden">
									<input name="uuid" type="text" title="userID" value="{$uuid}">
								</div>
								<br>
								<div class="input-group">
									<input name="password" type="password" title="password" class="form-control" placeholder="New Password">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
								</div>
								<br>
								<div class="input-group">
									<input name="rpassword" type="password" title="retype password" class="form-control" placeholder="Re-enter new password">
									<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
								</div>
								<br>
								<button type="submit" val="submit" name="submit" class="btn btn-default">Change password</button>
							</form>
						</div>
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
