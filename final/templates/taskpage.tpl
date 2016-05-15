<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <!-- Latest compiled and minified CSS -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <link rel="stylesheet" href="css/bootstrap.min.css"  crossorigin="anonymous">
  <!-- Optional theme -->
  <!--<link rel="stylesheet" href="css/bootstrap-theme.min.css">-->
  <link rel="stylesheet" href="userpageStyle.css">
  <link rel="stylesheet" href="taskpageStyle.css">
  <!-- Latest compiled and minified JavaScript -->
  <script src="js/bootstrap.min.js" ></script>
  <title> Task Page </title>
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
        <form class="navbar-form navbar-right" role="logout">
          <button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-log-out"></span> Sign Out</button>
        </form>
        <div class="navbar-right">
          <div id="mid-of-navbar">
            <a href="userpage.html"> jLopes </a>
            <img src="https://sigarra.up.pt/feup/pt/FOTOGRAFIAS_SERVICE.foto?pct_cod=230756" alt="user image" width="30px" height="30px" />
          </div>
        </div>
      </div>
    </div>
  </nav>
  <div class="container">
    <div class="row">
      <div class ="col-md-12">
        <ol class="breadcrumb">
          <li><a href="index.html">Home</a></li>
          <li><a href="userpage.html">jlopes</a></li>
          <li><a href="projectpage.html">Project</a></li>
          <li><a href="projectpage.html">Tasks</a></li>
          <li><a class="active" href="#">Finish documen...</a></li>
        </ol>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <h1 style="display:inline;">Finish documentation <span class="label label-warning">Master</span></h1>
      </div>
    </div>
    <br>
    <div class="row">
      <div class="col-md-12 pull-to-bottom">
        <p > <a class="btn btn-success btn-sm" href="#" role="button">Concluído </a> Task created by <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <strong> AAguiar </strong><span class="drab"> 4 months ago</span></p>
      </div>
      <div class="col-md-2 pull-to-bottom">

      </div>
    </div>
    <div class="row">
      <div class="col-md-10">
        <div class="row">
          <div class="col-md-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h5><a href="#"><strong><span class="glyphicon glyphicon-user" aria-hidden="true"></span> AAguiar</strong></a>
                  <span class="drab">commented 3 days ago </span><span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
                  <a href="#" class="pull-right"><span class="glyphicon glyphicon-remove"></span></a>
                </h5>
              </div>
              <div class="panel-body">
                <p>The documention is almost finished.</p>
                <p>Sections missing:</p>
                <p>- 4.5</p>
                <p>- 4.6</p>
                <p>- 5</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h5><a href="#"><strong><span class="glyphicon glyphicon-user"  aria-hidden="true"></span> jLopes</strong></a> <span class="drab">marked as completed 2 hours ago </span><span class="glyphicon glyphicon-ok text-success" aria-hidden="true"></span></h5>
              </div>
              <div class="panel-body">
                <p>This task is complete.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="widget-area no-padding blank">
              <div class="status-upload">
                <form>
                  <textarea placeholder="Comment area" ></textarea>
                  <ul>
                    <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"><span class="glyphicon glyphicon-music"></span></a></li>
                    <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"><span class="glyphicon glyphicon-facetime-video"></span></a></li>
                    <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"><span class="glyphicon glyphicon-picture"></span></a></li>
                  </ul>
                  <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-send"></span> Comment</button>
                </form>
              </div><!-- Status Upload  -->
            </div><!-- Widget Area -->
          </div>
        </div>
      </div>
      <div class="col-md-2 sidebar">
        <div class="row">
          <div class="col-md-10">
            <h4 class="drab">Labels</h4>
          </div>
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>			<ul class="label-list">
          <li><a href="#"><span class="label label-warning">Master</span></a></li>
        </ul>
        <hr/>
        <div class="row">
          <div class="col-md-10">
            <h4 class="drab">Assignee</h4>

          </div>
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>
        <a href="#"><strong><span class="glyphicon glyphicon-user"  aria-hidden="true"></span> MCruz</strong></a>

        <hr/>
        <div class="row">
          <div class="col-md-10">
            <h4 class="drab">Task list</h4>

          </div>
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>
        <a href="#"><strong><span class="glyphicon glyphicon-list-alt"  aria-hidden="true"></span> Demitate government</strong></a>

      </div>
    </div>
  </body>
  </html>
