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
});