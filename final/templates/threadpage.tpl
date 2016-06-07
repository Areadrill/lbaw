{include file='common/header.tpl'}
<title> {$threadInfo.name} on {$projectInfo.name}</title>
<link rel="stylesheet" href="../css/custom/userpageStyle.css">
<link rel="stylesheet" href="../css/custom/threadStyle.css">
<script src="../javascript/validator.min.js" ></script>
<script src="../javascript/threadpage.js" ></script>

</head>
<body>
 {include file='common/navbar.tpl'}
  <div class="container">
    <div class="row">
      <div class ="col-md-12">
        <ol class="breadcrumb">
          <li><a href={$BASE_URL}>Home</a></li>
          <li><a href="userpage.php">{$username}</a></li>
          <li><a href="projectpage.php?id={$projID}">{$projectInfo.name}</a></li>
          <li><a class="active" href="#">{$threadInfo.name}</a></li>
        </ol>
      </div>
    </div>
    <div class="row">
      <div class="col-md-7">
        <h1 style="display:inline;">{$threadInfo.name}</h1> <h1 style="display:inline" id="lblList1"> {foreach from=$labels item=label}<span class="label label-info">{$label.name}</span> {/foreach}</h1>
      </div>
      <div class="col-md-4">
        {if $role === 'COORD'}
        <div class="btn-group">
          <button style="margin-top: 0.7em" id="threadLock" type="button" class="btn btn-warning"> {if $isLocked}Unl{else}L{/if}ock Thread </button>
          <input type="hidden" id="thrID" name="thrID" value={$threadID}/>
          <button style="margin-top: 0.7em" id="threadDelete" type="button" class="btn btn-primary"> Delete Thread </button>
        </div>
        {/if}
      </div>
    </div>
    <br>
    <div class="row">
      <div class="col-md-12 pull-to-bottom">
        <p> Thread created by <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <strong> {$threadInfo.creatorName} </strong><span class="drab"> {$threadInfo.creationinfo}</span></p>
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
                  <h5><a href="#"><strong><span class="glyphicon glyphicon-user" aria-hidden="true"></span> {$comment.commentorName}</strong></a> <span class="drab">commented {$comment.ago}</span>
                    <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
                    {if $role === 'COORD'}<a href="#" class="pull-right submitRemoveComment" role="button" ><input type="hidden" name="commentid" value={$comment.commentid}><span class="glyphicon glyphicon-remove"></span></a>{/if}
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
                <form id="commentBox" action="../api/threads/create_comment.php" method="post" data-toggle="validator" {if $isLocked} hidden {/if}>
                  <input type="hidden" name="threadid" value={$threadID}>
                  <textarea name="commentArea" title="Comment area" placeholder="Comment area" maxlength="512"></textarea>
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
          {if ($role === 'COORD' || $isCreator)} <div id="threadLabelManage" class="col-md-2"><span class="glyphicon glyphicon-cog"></span></div> {/if}
        </div>
        <ul id="lblList2" class="label-list">
          {foreach from=$labels item=label}<li><span class="label label-info">{$label.name}</span></li> {/foreach}
        </ul>
        <hr/>
      </div>
    </div>
  </div>

    <div id="manageThreadLabels" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Manage this Thread's Labels</h4>
          </div>
          <h4> Current Thread Labels</h4>
          <ul id="currThreadLabels" class="list-group">
            {foreach from=$labels item=label}

                <li class="list-group-item clearfix">
                  <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                      <div class="row">
                        <div class="col-md-3">
                          <span class="label label-info">{$label.name}</span>
                        </div>
                        <div class="col-md-5">
                          <form class="alignForm labelOp" action="../api/threads/assign_label.php" method="post" >
                            <input type="hidden" name="threadid" value={$threadID}>
                            <input type="hidden" name="threadlid" value={$label.threadlid}>
                            <input type="hidden" name="action" value="unassign" >
                            <button type="submit" class="btn btn-primary pull-right"> Unassign </button>
                          </form>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-6"></div>
                  </div>
                </li>

            {/foreach}
          </ul>
          <br>
          <h4> Project Labels </h4>
          <ul id="labelsNotInThread" class="list-group">
            {foreach from=$missingLabels item=mLabel}
            <div class="row">
              <div class="col-md-1"></div>
              <div class="col-md-10">
                <li class="list-group-item clearfix">
                  <div class="row">
                    <div class="col-md-4">
                      <span class="label label-info">{$mLabel.name}</span>
                    </div>
                    <div class="col-md-4">
                      <form class="alignForm labelOp" action="../api/threads/assign_label.php" method="post">
                        <input type="hidden" name="threadid" value={$threadID}>
                        <input type="hidden" name="threadlid" value={$mLabel.threadlid}>
                        <input type="hidden" name="action" value="assign" >
                        <button type="submit" class="btn btn-primary pull-right"> Assign </button>
                      </form>
                    </div>
                  </div>
                </li>
              </div>
              <div class="col-md-4"></div>
            </div>
            {/foreach}
          </ul>
          <br>
        </div>
      </div>
    </div>

    <div id="deleteThreadConfirm" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Delete Thread</h4>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-2"></div>
              <div class="col-md-8">
                <h4> Are you sure you want to delete this thread? </h4>
              </div>
              <div class="col-md-2"></div>
              <div class="row">
                <div class="col-md-5"></div>
                <div class="col-md-3">
                  <form class="alignForm" action="../actions/threads/remove_thread.php" method="post" >
                    <input type="hidden" name="threadid" value={$threadID}>
                    <button id="deleteConfirm" type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Delete </button>
                  </form>
                </div>
                <div class="col-md-4"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
  </html>
