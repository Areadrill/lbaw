$(document).ready(function (){

	$(".submitRemoveComment").click(function (){
		$.post('../api/threads/remove_comment.php', {commentid: $("input", this).val()}, function(data){
			var json = JSON.parse(data);
			console.log(json);
			$("#allComments").empty();
			for(var i = 0; i < json.length; i++){
				$("#allComments").append(
					"<div class=\"row\">"+
			          "<div class=\"col-md-12\">"+
			            "<div class=\"panel panel-default\">"+
			              "<div class=\"panel-heading\">"+
			                "<h5><a href=\"#\"><strong><span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\"></span>"+ json[i].comentorName +"</strong></a> <span class=\"drab\">commented 3 days ago </span>"+
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

})