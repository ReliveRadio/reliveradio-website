// starts & ends are two Date objects that are passed in from the index view!

$(function () {

	// catch all the elements from dom
	var progressbars = $(".liveprogress");
	var time_left_views = $(".timeleft");
	var percent_played_views = $(".percentplayed");
	var percent_left_views = $(".percentleft");

	function update_progressbar(start_time, end_time) {
		// convert dates to milliseconds
		var start = start_time.getTime();
		var end = end_time.getTime();
		var now = new Date().getTime();

		// do some nice and fancy math
		var duration = Math.abs(end - start);
		var played = Math.abs(now - start);
		var percent_played = (played / duration) * 100;
		var percent_left = Math.floor(100 - percent_played);
		var time_left = Math.abs(end - now);

		// update view elements
		progressbars.each(function() {
				$(this).width(percent_played + '%');
		});
		time_left_views.each(function() {
				$(this).text(Math.floor(time_left / 60 / 1000));
		});
		percent_played_views.each(function() {
				$(this).text(Math.floor(percent_played) + "%");
		});
		percent_played_views.each(function() {
				$(this).text(percent_left + "%");
		});
	}

	// january is 0 not 1 in JS, so decrease by 1 here.
	starts.setMonth(starts.getMonth() - 1);
	ends.setMonth(ends.getMonth() - 1);

	// calc initial state
	update_progressbar(starts, ends);

	// refresh time in milliseconds
	var intervalTime = 10 * 1000; // 10 seconds
	// start timer
	window.setInterval(function(){
		update_progressbar(starts, ends);
		// check if the episode is finished
		var now = new Date();
		if (now > ends) {
			// if episode is finished, reload the page
			location.reload();
		}
	}, intervalTime);

});