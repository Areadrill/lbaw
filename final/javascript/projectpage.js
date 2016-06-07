$(document).ready(function(){
	$(".filterTask").click(function(){
		$.post('../api/tasks/filter_tasks.php', {tasklid: $(this).data('tasklid'), projid: $(this).data('projid')}, function(data){
			$("#recent-tasks").empty();
			var json = JSON.parse(data);
			for(var i = 0; i < json.length; i++){
				var htmlCode = "<a href=\"../pages/task.php?id="+ json[i].tasksid +"\" class=\"list-group-item\">"+"\n"+
				"<span class=\"glyphicon glyphicon-comment\"></span> " + json[i].name+"\n";
				for(var j = 0; j < json[i].tasksLabels.length; j++){
					htmlCode += "<span class=\"label label-info\">" + json[i].tasksLabels[j].name+ "</span>" +"\n";
				}
				htmlCode += "</a>"
				$("#recent-tasks").append(htmlCode);
			}
		});
	});
	$(".filterLabel").click(function(){
		$.post('../api/threads/filter_threads.php', {threadlabelid: $(this).data('threadlid'), projid: $(this).data('projid')}, function(data){
			$("#recent-threads").empty();
			var json = JSON.parse(data);
			for(var i = 0; i < json.length; i++){
				var htmlCode = "<a href=\"../pages/threadpage.php?id="+ json[i].threadid +"\" class=\"list-group-item\">"+ "\n"+
				"<span class=\"glyphicon glyphicon-comment\"></span> " + json[i].name +"\n";
				for(var j = 0; j < json[i].threadLabels.length; j++){
					htmlCode += "<span class=\"label label-info\">" + json[i].threadLabels[j].name+ "</span>"+ "\n";
				}
				htmlCode += "</a>";
				$("#recent-threads").append(htmlCode);
			}
		});
	});
	$(".dropdown-menu li a").click(function(){
	  var selText = $(this).text();
		var taskid = $(this).data("taskid");
		var taskliid = $(this).data("taskliid");
		$(".addTaskToTL[data-taskliid="+ taskliid +"]").data("taskid", taskid);
	  $(this).parents('.dropdown').find('.dropdown-toggle').html(selText+' <span class="caret"></span>');
	});
	$("#descriptionTab").click(function(){
	  $("#description").show();
      $("#forum").hide();
      $("#members").hide();
      $("#settings").hide();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#tasksTab").click(function(){
      $("#description").hide();
      $("#settings").hide();
      $("#forum").hide();
      $("#members").hide();
      $("#tasks").show();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#tasklistsTab").click(function(){
	  $("#description").hide();
      $("#forum").hide();
      $("#settings").hide();
      $("#members").hide();
      $("#tasks").hide();
      $("#tasklists").show();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#forumTab").click(function(){
      $("#description").hide();
      $("#settings").hide();
      $("#forum").show();
      $("#members").hide();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#membersTab").click(function(){
      $("#description").hide();
      $("#settings").hide();
      $("#forum").hide();
      $("#members").show();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#settingsTab").click(function(){
      $("#description").hide();
      $("#forum").hide();
      $("#members").hide();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("#settings").show();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });

    $("#deleteproj").click(function (){
      $("#deleteProjConfirm").modal('show');
    });

		$("#editproj").click(function(){
			$("#editProjDescription").modal('show');
		});
		$("#newTaskList").click(function(){
			$("#newTaskListModal").modal('show');
		});

		$(".manageTask").click(function(){
			var tasklistid = $(this).data("tasklistid");
			$(".manageTaskList[data-tasklistid="+tasklistid+"]").modal('show');
		});

    $('#userSearcher').on('keyup', function(){
    $.post('../api/projects/search_users.php', {field : $(this).val(), projectID: $("#projectID").val()}, function(data){
      $('#listofusers').empty();
      var json = JSON.parse(data);
      for(var i = 0; i < json.length; i++){
        $('#listofusers').append(
          "<div class=\"row\">"+
              "<div class=\"col-md-1\"></div>"+
                "<div class=\"col-md-11\">"+
                  "<div class=\"panel panel-primary\" style=\"margin-bottom:0\">"+
                     "<div class=\"panel-body\" >"+
                        "<div class=\"row\">"+
                          "<div class=\"col-md-1\">"+
                            "<div class=\"pull-left\">"+
                              "<a href=\"#\" style=\"margin-bottom: 0;\" class=\"thumbnail\">"+
                                "<img src=\""+ json[i].picPath.substring(3, json[i].picPath.length) +"\" alt=\""+ json[i].username +"\" height=\"25px\" width=\"25px\"/>"+
                              "</a>"+
                          "</div>"+
                          "</div>"+
                            "<div class=\"col-md-2\">"+
                              "<p>"+ json[i].username +"</p>"+
                            "</div>"+
                            "<div class=\"col-md-3\">"+
                              "<form action=\"../api/projects/assign_role.php\" method=\"post\">"+
                                "<input type=\"hidden\" name=\"projectID\" value=\""+ json[i].projid +"\">"+
                                "<input type=\"hidden\" name=\"userID\" value=\""+ json[i].userid +"\">"+
                                "<input type=\"hidden\" name=\"action\" value=\"add\">"+
                                "<button type=\"submit\" class=\"btn btn-primary\"> <span class=\"glyphicon glyphicon-download\"></span> Add to Project</button>"+
                              "</form>"+
                            "</div>"+
                        "</div>"+
                      "</div>"+
                  "</div>"+
                "</div>"+
              "</div>"+
          "</div>"

        );
      }
    });
  });

  $("#newThread").click(function(){
    $("#createThread").modal('show');
  });

  $("#newTask").click(function(){
	  $("#createTask").modal('show');
  });

   $("#labelManage").click(function(){
    $("#manageLabels").modal('show');
  });

   $("#taskLabelManage").click(function(){
    $("#manageTaskLabels").modal('show');
  });

    $("#newTLSubmmit").click(function(){
    $("#newLabel").submit();
  });


  $("#newTaskLabelSubmit").click(function(){
       	 $("#newTaskLabelName").get(0).setCustomValidity('');
	  var request = {"projectid": $("#newTaskLabel input[name=\"projectid\"]").val(),
		  	 "name": $("#newTaskLabel input[name=\"name\"]").val()};
	  $.post("../api/tasks/create_label.php", request, taskLabelAdded, "json").fail(function(xhr){
		  $.notify(xhr.responseJSON['error']);
	  });
  });

  $(".tasklist").click(function(){
	  tasklist = $(this);
	  content = tasklist.children(".belong");
		tasklist.find(".glyphicon").first().toggleClass('glyphicon-triangle-right').toggleClass('glyphicon-triangle-bottom');
	  content.slideToggle(500);
  });


  $("#newThreadSubWrapper").hover(function (){
    console.log("ola");
    if($("div", "#newThreadForm").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#newThreadSub").prop('disabled', true);
    }
    else{
      $("#newThreadSub").prop('disabled', false);
    }
  });

    $("#newTaskSubWrapper").hover(function (){
    console.log("ola");
    if($("div", "#newTaskForm").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#newTaskSub").prop('disabled', true);
    }
    else{
      $("#newTaskSub").prop('disabled', false);
    }
  });
      $("#newTaskLabelWrapper").hover(function (){
    console.log("ola");
    if($("div", "#newTaskLabel").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#newTaskLabelSubmit").prop('disabled', true);
    }
    else{
      $("#newTaskLabelSubmit").prop('disabled', false);
    }
  });

   $("#newTLSubmmitWrapper").hover(function (){
    console.log("ola");
    if($("div", "#newLabel").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#newTLSubmmit").prop('disabled', true);
    }
    else{
      $("#newTLSubmmit").prop('disabled', false);
    }
  });

  $("#newTaskListSubWrapper").hover(function (){
    console.log("ola");
    if($("div", "#newTaskListForm").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#newTaskListSub").prop('disabled', true);
    }
    else{
      $("#newTaskListSub").prop('disabled', false);
    }
  });

$("#editConfirmWrapper").hover(function (){
    console.log("ola");
    if($("div", "#editProjForm").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#editConfirm").prop('disabled', true);
    }
    else{
      $("#editConfirm").prop('disabled', false);
    }
  });



});

function taskLabelAdded(data){
	$("div#taskLabelList").append("<a href=\"#\" class=\"list-group-item\"><span class=\"label label-primary\">"+ data["name"] + "</span><span class=\"badge\">0</span></a>");
	$("#manageTaskLabels").modal('hide');
}
function deleteTaskList(taskliid, projID){
	$('<form id="removeTaskList" class="alignForm" action="../actions/tasklist/delete_tasklist.php" method="post">'+
		'<input type="hidden" name="projectID" value='+ projID +'>' +
		'<input type="hidden" name="tasklistID" value='+ taskliid +'>' +
	'</form>').submit();
}

function addToTaskList(taskliid, projID){
	var taskid = $(".addTaskToTL[data-taskliid="+ taskliid +"]").data("taskid");

	$('<form id="removeTaskList" class="alignForm" action="../actions/tasklist/assign_tasklist.php" method="post">'+
		'<input type="hidden" name="projectID" value='+ projID +'>' +
		'<input type="hidden" name="taskid" value='+ taskid +'>' +
		'<input type="hidden" name="tasklistID" value='+ taskliid +'>' +
	'</form>').submit();
}

function removeFromTaskList(taskid, projID){
	$('<form id="removeTaskList" class="alignForm" action="../actions/tasklist/unassign_tasklist.php" method="post">'+
		'<input type="hidden" name="projectID" value='+ projID +'>' +
		'<input type="hidden" name="taskid" value='+ taskid +'>'+
	'</form>').submit();
}
