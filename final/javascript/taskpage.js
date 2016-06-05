$(document).ready(function(){
	$("#taskDelete").click(function(){
		$("#deleteTaskConfirm").modal("show");
	});
	$("#assigneeManage").click(function(){
		$("#manageAssignee").modal("show");
	});
	$("#taskLabelManage").click(function(){
		$("#manageTaskLabels").modal("show");
	});

	$(document).on("submit",".labelOp",function(e){

		e.preventDefault();
		$.post('../../api/tasks/assign_label.php', {taskid: $("input[name='taskid']", this).val(), tasklid: $("input[name='tasklid']", this).val(), action: $("input[name='action']", this).val()}, function (data){
			var json = JSON.parse(data);
			console.log(data);
			$("#currThreadLabels").empty();
			$("#labelsNotInThread").empty();
			$("#lblList1").empty();
			$("#lblList2").empty();



			for(var i = 0; i < json[0].length; i++){
				$("#currThreadLabels").append("<div class=\"row\">"+
                  "<div class=\"col-md-1\"></div>"+
                    "<div class=\"col-md-10\">"+
                      "<li class=\"list-group-item clearfix\">"+
                        "<div class=\"row\">"+
                          "<div class=\"col-md-3\">"+
                            "<span class=\"label label-info\">"+ json[0][i].name +"</span>"+
                          "</div>"+
                          "<div class=\"col-md-5\">"+
                            "<form class=\"alignForm labelOp\" action=\"../api/tasks/assign_label.php\" method=\"post\">"+
                              "<input type=\"hidden\" name=\"taskid\" value="+ json[2] +">"+
                              "<input type=\"hidden\" name=\"tasklid\" value="+ json[0][i].tasklid +">"+
                              "<input type=\"hidden\" name=\"action\" value=\"unassign\" >"+
                              "<button type=\"submit\" class=\"btn btn-primary pull-right\"> Unassign </button>"+
                            "</form>"+
                         " </div>"+
                        "</div>"+
                     " </li>"+
                    "</div>"+
                    "<div class=\"col-md-6\"></div>"+
                "</div>  ");

                $("#lblList1").append("<span class=\"label label-info\">"+ json[0][i].name +"</span> ");
                $("#lblList2").append("<li><span class=\"label label-info\">"+ json[0][i].name +"</span></li> ");
			}

			for(var i = 0; i < json[1].length; i++){
				$("#labelsNotInThread").append("<div class=\"row\">"+
                  "<div class=\"col-md-1\"></div>"+
                    "<div class=\"col-md-10\">"+
                      "<li class=\"list-group-item clearfix\">"+
                        "<div class=\"row\">"+
                          "<div class=\"col-md-3\">"+
                            "<span class=\"label label-info\">"+ json[1][i].name +"</span>"+
                          "</div>"+
                          "<div class=\"col-md-5\">"+
                            "<form class=\"alignForm labelOp\" action=\"../api/tasks/assign_label.php\" method=\"post\">"+
                              "<input type=\"hidden\" name=\"taskid\" value="+ json[2] +">"+
                              "<input type=\"hidden\" name=\"tasklid\" value="+ json[1][i].tasklid +">"+
                              "<input type=\"hidden\" name=\"action\" value=\"assign\" >"+
                              "<button type=\"submit\" class=\"btn btn-primary pull-right\"> Assign </button>"+
                            "</form>"+
                         " </div>"+
                        "</div>"+
                     " </li>"+
                    "</div>"+
                    "<div class=\"col-md-6\"></div>"+
                "</div>  ");
			}
		});
	});

});


