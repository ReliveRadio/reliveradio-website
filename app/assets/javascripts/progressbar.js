// starts & ends are two Date objects that are passed in from the index view!

$(function () {

	function update_progressbar() {
		// convert dates to milliseconds
		var start = starts.getTime();
		var end = ends.getTime();
		var now = new Date().getTime();

		// do some nice and fancy math
		var duration = Math.abs(end - start);
		var played = Math.abs(now - start);
		var percent_played = (played / duration) * 100;
		var percent_left = Math.floor(100 - percent_played);
		var time_left = Math.abs(end - now);

		// update view elements
		$(".liveprogress").each(function() {
				$(this).width(percent_played + '%');
		});
		$(".timeleft").each(function() {
				$(this).text(Math.floor(time_left / 60 / 1000));
		});
		$(".percentplayed").each(function() {
				$(this).text(Math.floor(percent_played) + "%");
		});
		$(".percentleft").each(function() {
				$(this).text(percent_left + "%");
		});
	}

	update_progressbar();

	// refresh time in milliseconds
	var intervalTime = 10 * 1000; // 10 seconds
	// start timer
	window.setInterval(function(){
		update_progressbar();
		// check if the episode is finished
		var now = new Date();
		if (now > ends) {
			// if episode is finished, do AJAX request and reload schedule
			$.get("/", null, update_progressbar, 'script');
		}
	}, intervalTime);

});