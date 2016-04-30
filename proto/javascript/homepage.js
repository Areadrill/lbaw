$(document).ready(function(){

	$("#register-submit").click(function(){
		$("form#register-form input[name='username']").val($("div.panel-body div.input-group input[type=text]").val());
		$("form#register-form input[name='password']").val($("div.panel-body div.input-group input[type=password]").val());
		$("form#register-form input[name='email']").val($("div.panel-body div.input-group input[type=email]").val());
		$("form#register-form input[type='submit']").click();
		return false;
	});
});
