$(document).ready(function(){
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

    $('#userSearcher').on('keyup', function(){
    $.post('../api/projects/search_users.php', {field : $(this).val(), projectID: $("#projectID").val()}, function(data){
      $('#listofusers').empty();
      var json = JSON.parse(data);
      //console.log(data);
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

});

function taskLabelAdded(data){
	$("div#taskLabelList").append("<a href=\"#\" class=\"list-group-item\"><span class=\"label label-primary\">"+ data["name"] + "</span><span class=\"badge\">0</span></a>");
	$("#manageTaskLabels").modal('hide');
}
