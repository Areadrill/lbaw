{include file='common/header.tpl'}
<link rel="stylesheet" href="../css/custom/userpageStyle.css">
<link rel="stylesheet" href="../css/custom/threadStyle.css">
<script src="../javascript/threadpage.js" ></script>

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
            <a href="userpage.html"> {$username} </a>
            <img src={$imgPath} alt="user image" width="30px" height="30px" />
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
          <li><a href="userpage.html">{$username}</a></li>
          <li><a href="projectpage.html">{$projectInfo.name}</a></li>
          <li><a class="active" href="#">{$threadInfo.name}</a></li>
        </ol>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <h1 style="display:inline;">{$threadInfo.name} {foreach from=$labels item=label}<span class="label label-info">{$label.name}</span>{/foreach}<span class="label label-info">Front-end</span> <span class="label label-danger">Bug fixing</span></h1>
      </div>
    </div>
    <br>
    <div class="row">
      <div class="col-md-12 pull-to-bottom">
        <p> Thread created by <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <strong> {$threadInfo.creatorName} </strong><span class="drab"> 4 months ago</span></p>
      </div>
      <div class="col-md-2 pull-to-bottom">

      </div>
    </div>
    <div class="row">
      <div class="col-md-10">
      <div id="allComments">
      {foreach from=$comments item=comment}
         <div class="row">
          <div class="col-md-12">
            <div class="panel panel-default">
              <div class="panel-heading">
                <h5><a href="#"><strong><span class="glyphicon glyphicon-user" aria-hidden="true"></span> {$comment.commentorName}</strong></a> <span class="drab">commented 3 days ago </span>
                  <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
                  {if $role === 'COORD'}<a href="#" class="pull-right submitRemoveComment"><input type="hidden" name="commentid" value={$comment.commentid}><span class="glyphicon glyphicon-remove"></span></a>{/if}
                </h5>
              </div>
              <div class="panel-body">
                <p>
                  {$comment.text}
                </p>
              </div>
            </div>
          </div>
        </div>
      {/foreach}
      </div>
        <div class="row">
          <div class="col-md-12">
            <div class="widget-area no-padding blank">
              <div class="status-upload">
                <form action="../api/threads/create_comment.php" method="post">
                  <input type="hidden" name="threadid" value={$threadID}>
                  <textarea name="commentArea" placeholder="Comment area" ></textarea>
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
        <div id="pageNumbers">
          <ul class="pagination">
            <li class="disabled"><a href="#">&laquo;</a></li>
            <li class="active"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">&raquo;</a></li>
          </ul>
        </div>
      </div>
      <div class="col-md-2 sidebar">
        <div class="row">
          <div class="col-md-10">
            <h4 class="drab">Labels</h4>
          </div>
          <div class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div>
        </div>
        <ul class="label-list">
        {foreach from=$labels item=label}<li><span class="label label-info">{$label.name}</span></li>{/foreach}<li><a href="#"><span class="label label-danger">Bug fixing</span></a> <a href="#"><span class="label label-info">Front-end</span></a></li>
        </ul>
        <hr/>
      </div>
    </div>
  </body>
  </html>
