$(document).ready(function(){
  $('#searcher').on('keyup', function(){
    $.post('../api/user/search_projects.php', {field : $(this).val()}, function(data){
      $('#listofprojs').empty();
      var json = JSON.parse(data);
      for(var i = 0; i < json.length; i++){
        $('#listofprojs').append("<div class=\"panel-body\">"+
          "<div class=\"panel panel-primary\">"+
            "<div class=\"panel-heading\">"+
            " <a class=\"white-link\" href=\"../pages/projectpage.php?id="+ json[i].projectid + "\"" + 
            " data-projid="+ json[i].projectid+">"+ json[i].name + " by " + json[i].creatorName.username +"</a>"+
            "</div>"+
            "<div class=\"panel-body\">"+
              "<div class=\"row\">"+
                "<div class=\"col-md-3\">"+
                  "<span class=\"glyphicon glyphicon-inbox\"></span> "+ json[i].userInfo.assigned.tasksassignedtouser +" new tasks assigned to you"+
                "</div>"+
                "<div class=\"col-md-3\">"+
                  "<span class=\"glyphicon glyphicon-comment\"></span> "+ json[i].userInfo.tasks.newtaskcount + " new tasks"+
                "</div>"+
                "<div class=\"col-md-3\">"+
                  "<span class=\"glyphicon glyphicon-comment\"></span> "+ json[i].userInfo.threads.newthreadcount + " new threads"+
                "</div>"+
              "</div>"+
            "</div>"+
          "</div>"+
        "</div>");
      }
    });
  });

  $("#userImage, #imageCover").click(function(){
    $("#imageEdit").modal('show');
  });

  $("#userImage, #imageCover").hover(toggleImageCover);

  $("#infoEditSubWrapper").hover(function (){
    if($("div", "#infoEditForm").hasClass("has-error") || $("input", this).hasClass("has-danger")){
      $("#infoEditSub").prop('disabled', true);
    }
    else{
      $("#infoEditSub").prop('disabled', false);
    }
 
  });


});

var imageCover = false;

function toggleImageCover(){
  if(imageCover){
    //$("#userImage").show();
    $("#imageCover").hide();
    imageCover = false;
  }
  else{
    //$("#userImage").hide();
    $("#imageCover").show();
    imageCover = true;
  }
}
