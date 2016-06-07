$(document).ready(function (){

	$(document).on("click",".submitRemoveComment",function(){
	//$(".submitRemoveComment").click(function (){
		$.post('../api/threads/remove_comment.php', {commentid: $("input", this).val()}, function(data){
			var json = JSON.parse(data);
			$("#allComments").empty();
			for(var i = 0; i < json.length; i++){
				$("#allComments").append(
					"<div class=\"row\">"+
			          "<div class=\"col-md-12\">"+
			            "<div class=\"panel panel-default\">"+
			              "<div class=\"panel-heading\">"+
			                "<h5><a href=\"#\"><strong><span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span> "+ json[i].commentorName +"</strong></a> <span class=\"drab\">commented 3 days ago </span>"+
			                  "<span class=\"glyphicon glyphicon-bullhorn\" aria-hidden=\"true\"></span>"+
			                  "<a href=\"#\" class=\"pull-right submitRemoveComment\"><input type=\"hidden\" name=\"commentid\" value="+ json[i].commentid +"><span class=\"glyphicon glyphicon-remove\"></span></a>"+
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

	$("#threadLabelManage").click(function (){
		$("#manageThreadLabels").modal('show');
	});

	$("#threadDelete").click(function (){
		$("#deleteThreadConfirm").modal('show');
	});

	$("#threadLock").click(function (){
		$.post('../api/threads/toggle_lock.php', {threadid: $("#thrID").val()}, function (data){
			if(data == "locked"){
				$("#threadLock").text("<span class=\"glyphicon glyphicon-lock\"></span> Unlock Thread");
				$("#commentBox").hide();
			}
			else if(data == "unlocked"){
				$("#threadLock").text("<span class=\"glyphicon glyphicon-lock\"></span> Lock Thread");
				$("#commentBox").show();
			}

		});
	});

	$(document).on("submit",".labelOp",function(e){

		e.preventDefault();
		$.post('../api/threads/assign_label.php', {threadid: $("input[name='threadid']", this).val(), threadlid: $("input[name='threadlid']", this).val(), action: $("input[name='action']", this).val()}, function (data){
			var json = JSON.parse(data);
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
                            "<form class=\"alignForm labelOp\" action=\"../api/threads/assign_label.php\" method=\"post\">"+
                              "<input type=\"hidden\" name=\"threadid\" value="+ json[2] +">"+
                              "<input type=\"hidden\" name=\"threadlid\" value="+ json[0][i].threadlid +">"+
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
                            "<form class=\"alignForm labelOp\" action=\"../api/threads/assign_label.php\" method=\"post\">"+
                              "<input type=\"hidden\" name=\"threadid\" value="+ json[2] +">"+
                              "<input type=\"hidden\" name=\"threadlid\" value="+ json[1][i].threadlid +">"+
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
