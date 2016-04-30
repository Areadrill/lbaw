$(document).ready(function(){
  $('#searcher').on('keyup', function(){
    $.post('../api/user/search_projects.php', {field : $(this).val()}, function(data){
      $('#listofprojs').empty();
      var json = JSON.parse(data);
      for(var i = 0; i < json.length; i++){
        $('#listofprojs').append("<div class=\"panel-body\">"+
          "<div class=\"panel panel-primary\">"+
            "<div class=\"panel-heading\">"+
            " <a class=\"white-link\" href=\"projectpage.html\" data-projid="+ json[i].projectid+">"+ json[i].name +"</a>"+
            "</div>"+
            "<div class=\"panel-body\">"+
            "<div class=\"row\">"+
            "<div class=\"col-md-3\">"+
            "<span class=\"glyphicon glyphicon-inbox\"></span> 2 new tasks"+
                "</div>"+
                "<div class=\"col-md-3\">"+
                "<span class=\"glyphicon glyphicon-comment\"></span> 1 new thread"+
                "</div>"+
              "</div>"+
            "</div>"+
          "</div>"+
        "</div>");
      }
    });
  });

  $("#userImage").click(function(){
    $("#imageEdit").modal('show');
  })

});
