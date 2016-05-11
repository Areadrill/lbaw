$(document).ready(function(){
	$("#descriptionTab").click(function(){
	  $("#description").show();
      $("#forum").hide();
      $("#members").hide();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#tasksTab").click(function(){
      $("#description").hide();
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
      $("#members").hide();
      $("#tasks").hide();
      $("#tasklists").show();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#forumTab").click(function(){
      $("#description").hide();
      $("#forum").show();
      $("#members").hide();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });
    $("#membersTab").click(function(){
      $("#description").hide();
      $("#forum").hide();
      $("#members").show();
      $("#tasks").hide();
      $("#tasklists").hide();
      $("li.active").removeClass('active');
      $(this).addClass('active');
    });

    $('#userSearcher').on('keyup', function(){
    $.post('../api/user/search_users.php', {field : $(this).val()}, function(data){
      $('#listofprojs').empty();
      var json = JSON.parse(data);
      for(var i = 0; i < json.length; i++){
        $('#listofprojs').append("<div class=\"panel-body\">"+
          "<div class=\"panel panel-primary\">"+
            "<div class=\"panel-heading\">"+

            //" <a class=\"white-link\" href=\"projectpage.html\" data-projid="+ json[i].projectid+">"+ json[i].name +"</a>"+
            "</div>"+
            "<div class=\"panel-body\">"+
            "<div class=\"row\">"+
            "<div class=\"col-md-3\">"+
            "json[i].username"
            //"<span class=\"glyphicon glyphicon-inbox\"></span> 2 new tasks"+
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

});
