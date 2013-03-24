$(function () {
	$("#ajaxbutton").click(function(){
		$.get("/", null, null, 'script');
		// return false; if this was a link
	});
});