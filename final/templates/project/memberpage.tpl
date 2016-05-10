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
  <div id="members" class="panel panel-default" hidden>
    <ul class="list-group">
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
</div>
