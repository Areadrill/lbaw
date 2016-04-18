{include file='common/header.tpl'}
    <link rel="stylesheet" href="../css/custom/homepageStyle.css">
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
            		<div class="input-group">
            		  <input type="text" class="form-control" placeholder="Username">
                  <span class="input-group-addon"> <span class="glyphicon glyphicon-user"></span></span>
            		</div>
                <br>
            		<div class="input-group">
            		  <input type="email" class="form-control" placeholder="E-mail">
            		  <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
            		</div>
                <br>
            		<div class="input-group">
            		  <input type="password" class="form-control" placeholder="Password">
            		  <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
            		</div>
                <br>
            		<div class="input-group">
            		  <input type="password" class="form-control" placeholder="Re-enter password">
            		  <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
            		</div>
            	<br>
            		<button type="submit" class="btn btn-default">Sign Up</button>
        		  </div>
        		</div>
      		</div>
      	</div>
      </div>
  </div>
{include file='common/footer.tpl'}
