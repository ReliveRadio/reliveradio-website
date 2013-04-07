$(function(){

	function open_in_new_tab(url) {
		var win=window.open(url, '_blank');
		win.focus();
	}

	$("#sofortueberweisung_button").click(function(){
		var money = $("#sofortueberweisung_input").val();
		// test cases
		// empty
		// 0
		// 0,0
		// 0,50
		// 1
		// 200
		// 1,50
		// 1,5
		money = money.replace(",", ".");
		var containsComma = money.search(".") == -1 ? false : true;
		var number = parseFloat(money);
		if (containsComma) number *= 100;

		open_in_new_tab("https://billing.micropayment.de/sofort/event/?project=rlvrdo&title=Spende&amount=" + number);

		// https://billing.micropayment.de/sofort/event/?project=rlvrdo&title=Spende&amount=1337
	});
});