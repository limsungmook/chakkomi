$(function() {
	var History = window.History;
	if ( !History.enabled ){
	    return false;
	}
	$(".laydesk_sidebar_menu a, #laydesk_body a").click(function(e) {
//		$.getScript(this.href);
//		history.pushState(null, document.title, this.href);

		History.pushState(null, document.title, this.href);

		return false;

	    });
	History.Adapter.bind(window, 'statechange', function(){
		var State = History.getState();

		
		$.getScript(State.url);

		

	    });
//	$(window).bind("popstate", function() {
//		$.getScript(location.href);
//	    });
});
