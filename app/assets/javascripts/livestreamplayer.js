$(function(){
	// using jQuery
	var player = new MediaElementPlayer('#player',{
		startVolume: 0.8,
		// useful for <audio> player loops
		loop: false,
		// enables Flash and Silverlight to resize to content size
		enableAutosize: true,
		// the order of controls you want on the control bar (and other plugins below)
		features: ['playpause','volume'],
		audioWidth: 130,
		// Hide controls when playing and mouse is not over the video
		alwaysShowControls: false,
		// force iPad's native controls
		iPadUseNativeControls: false,
		// force iPhone's native controls
		iPhoneUseNativeControls: false,
		// force Android's native controls
		AndroidUseNativeControls: false,
		pluginPath: '/assets/mediaelement_rails/',
		// name of flash file
		flashName: 'flashmediaelement.swf',
		// name of silverlight file
		silverlightName: 'silverlightmediaelement.xap',
		// default if the <video width> is not specified
		enableKeyboard: true,
		// when this player starts, it will pause other players
		pauseOtherPlayers: true,
		// array of keyboard commands
		keyActions: []
	});

	// get all the available buttons
	var livestreambuttons = $(".livestreambutton");

	// initialize the buttons
	livestreambuttons.each(function() {
		$(this).click(liveStreamButtonClicked);
		$(this).html('<i class="fa fa-play"></i> Livestream starten');
	});

	var isLivestreamPlaying = false;

	function liveStreamButtonClicked() {
		if(isLivestreamPlaying) {
			// the button was clicked to STOP the livestream
			player.pause();
			livestreambuttons.each(function() {
				// change look and feel of the button
				$(this).html('<i class="fa fa-play"></i> Livestream starten');
				$(this).removeClass('on');
				$(this).addClass('off');
			});
			// remember status
			isLivestreamPlaying = false;
		} else {
			// the button was clicked to START the livestream
			player.play();
			livestreambuttons.each(function() {
				// change look and feel of the button
				$(this).html('<i class="fa fa-pause"></i> Livestream stoppen');
				$(this).removeClass('off');
				$(this).addClass('on');
			});
			// remember status
			isLivestreamPlaying = true;
		}
	}
});
