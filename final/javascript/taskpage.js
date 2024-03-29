$(document).ready(function(){ $(document).on("click",".submitRemoveComment",function(){
		$.post('../api/tasks/remove_comment.php', {commentid: $("input", this).val()}, function(data){
			var json = JSON.parse(data);
			$("#commentListArea").empty();
			for(var i = 0; i < json.length; i++){
				$("#commentListArea").append(
						"<div class=\"row\">"+
						"<div class=\"col-md-12\">"+
						"<div class=\"panel panel-default\">"+
						"<div class=\"panel-heading\">"+
						"<h5><a href=\"#\"><strong><span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span> "+ json[i].commentorname +"</strong></a> <span class=\"drab\">commented 3 days ago </span>"+
						"<span class=\"glyphicon glyphicon-bullhorn\" aria-hidden=\"true\"></span>"+
						"<a  class=\"pull-right submitRemoveComment\"><input type=\"hidden\" name=\"commentid\" value="+ json[i].taskcid +"><span class=\"glyphicon glyphicon-remove\"></span></a>"+
						"</h5>"+
						"</div>"+
						" <div class=\"panel-body\">"+
						"<p>"+
						json[i].text+
						"</p>"+
						"</div>"+
						"</div>"+
						"</div>"+
						"</div>"
						);
			}
		});
	});

	$("#taskUncomplete").click(function(){
		$.post("../api/tasks/uncomplete_task.php", {taskid: $("#taskidForm").val()}, function(data){
			
			$("#completionstatus").addClass("btn-danger");
			$("#completionstatus").removeClass("btn-success");
			$("#completionstatus").text("Not Complete");
			$("#taskUncomplete").remove();

		});
	});

	$("#taskDelete").click(function(){
		$("#deleteTaskConfirm").modal("show");
	});
	$("#assigneeManage").click(function(){
		$("#manageAssignee").modal("show");
	});
	$("#taskLabelManage").click(function(){
		$("#manageTaskLabels").modal("show");
	});

	$(document).on("submit","#createCommentForm",function(e){
		e.preventDefault();
		$.post("../api/tasks/create_comment.php", {body: $("#createCommentForm textarea").val(), taskid: $("#taskidForm").val(), completed: $("#completeForm").is(":checked")}, function(data){
			reply = JSON.parse(data);
			if(reply['complete'] && $("#completionstatus").hasClass("btn-danger")){
				$("#completionstatus").removeClass("btn-danger");
				$("#completionstatus").addClass("btn-success");
				$("#completionstatus").text("Complete");
				if ($(".container").data("coord") == "COORD"){
					$("#taskDelete").after($("<button  style=\"margin-top: 0.7em\" id=\"taskUncomplete\" type=\"button\" class=\"btn btn-primary\">Reopen Task</button>"));
					$("#taskUncomplete").click(function(){
						$.post("../api/tasks/uncomplete_task.php", {taskid: $("#taskidForm").val()}, function(){
							$("#completionstatus").addClass("btn-danger");
							$("#completionstatus").removeClass("btn-success");
							$("#completionstatus").text("Not Complete");
							$("#taskUncomplete").remove();

						});
					});
				}
			}
			$("#commentListArea").append($("<div class=\"row\">"+
						"<div class=\"col-md-12\">"+
						"<div class=\"panel panel-default\">"+
						"<div class=\"panel-heading\">"+
						"<h5><a href=\"#\"><strong><span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span>"+reply["username"] + " </strong></a>"+
						"<span class=\"drab\">commented just now</span>"+
						"<a href=\"#\" class=\"pull-right submitRemoveComment\" role=\"button\"><input type=\"hidden\" name=\"commentid\" value="+reply['taskcid']+"><span class=\"glyphicon glyphicon-remove\"></span></a>"+
						"</h5>"+
						"</div>"+
						"<div class=\"panel-body\">"+reply["body"]+
						"</div>"+
						"</div>"+
						"</div>"+
						"</div>"));
		}).fail(function(xhr){console.log(xhr);});
	});

	$(document).on("submit",".labelOp",function(e){

		e.preventDefault();
		$.post('../api/tasks/assign_label.php', {taskid: $("input[name='taskid']", this).val(), tasklid: $("input[name='tasklid']", this).val(), action: $("input[name='action']", this).val()}, function (data){
			var json = JSON.parse(data);
			
			var s = $("#nameandlabels h1").siblings("span");
			s.remove();
			for(var k in json[0]){
				$("#nameandlabels h1").after($("<span class=\"label label-warning\">"+json[0][k]['name']+"</span>"));
			}
			var j = $("#currTaskLabels li");
			$("#currTaskLabels").empty();
			$("#labelsNotInTask").empty();
			$(".label-list").empty();



			for(var i = 0; i < json[0].length; i++){
				$("#currTaskLabels").append("<div class=\"row\">"+
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

				//$("#lblList1").append("<span class=\"label label-info\">"+ json[0][i].name +"</span> ");
				$(".label-list").append("<li><span class=\"label label-warning\">"+ json[0][i].name +"</span></li> ");
			}

			for(var i = 0; i < json[1].length; i++){
				$("#labelsNotInTask").append("<div class=\"row\">"+
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
