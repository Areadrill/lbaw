<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container-fluid">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="{$BASE_URL}pages/userpage.php?userid={$userid}">ProjectHarbor</a>
	</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav navbar-left">
			<li><a href="#about">About</a></li>
			<li><a href="#contact">Contact</a></li>
		</ul>
{if isset($username)}
		<form action="../actions/users/logout.php" class="navbar-form navbar-right">
			<button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-log-out"></span> Sign Out</button> 
		</form>
			<div class="navbar-right">
				<div id="mid-of-navbar">
					<a class="white-link" href="userpage.php"> {$username} </a>
					<img src={$img} alt="user image" width="30" height="30" />
				</div>
			</div>
{else}
		<form method="post" action="../actions/users/login.php" class="navbar-form navbar-right" >
					<div class="form-group">
						<input name="username" title="username" type="text" class="form-control" placeholder="Username">
						<input name="password" title="password" type="password" class="form-control" placeholder="Password">
					</div>
					<button type="submit" class="btn btn-default">Sign In</button>
				</form>
{/if}
		</div>
	</div>
</nav>