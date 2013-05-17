$(function () {

	function update_listeners() {
		// if the server could not read the current listeners count correctly
		// from the xenim api it will set listeners = -1
		if(listeners >= 0) {
			$('#listeners').html(listeners);
		}
	}

	// refresh time in milliseconds
	var intervalTime = 30 * 1000; // 30 seconds
	// start timer
	window.setInterval(function(){
		$.get("/stream/listeners_technique.js", null, update_listeners, 'script');
	}, intervalTime);
});