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
    $.post('../api/projects/search_users.php', {field : $(this).val()}, function(data){
      $('#listofusers').empty();
      var json = JSON.parse(data);
      console.log(json);
      for(var i = 0; i < json.length; i++){
        $('#listofusers').append(
          "<div class=\"panel panel-primary\">"+
          "<div class=\"panel-body\">"+
            "<div class=\"row\">"+
              "<div class=\"col-md-4\"></div>"+
                "<div class=\"col-md-8\">"+
                    "<p>"+ json[i].username +"</p>"+
                  "</div>"+
                "</div>"+
            "</div>"
          "</div>"+
          "</div>"

        );
      }
    });
  });

});
