$(function () {
	// refresh time in milliseconds
	var intervalTime = 10 * 60 * 1000; // 10 minutes
	// start timer
	window.setInterval(function(){
		$.get("/home/hoersuppe.js", null, null, 'script');
	}, intervalTime);
});