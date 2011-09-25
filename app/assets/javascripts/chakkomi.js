$(function() {
	var History = window.History;
	if ( !History.enabled ){
	    return false;
	}
	$(".laydesk_sidebar_menu a, #laydesk_body a").click(function(e) {
//		history.pushState(null, document.title, this.href);
		var State = History.getState();
//		History.log(State.data, State.title, State.url);
//		History.log(State.data, 'clicked', this.href);
		History.pushState(null, document.title, this.href);
		if (this.href != State.url)
		{
		    return false;
		}
	    });
	History.Adapter.bind(window, 'statechange', function(){
		var State = History.getState();
//		History.log(State.data, State.title, State.url);
//		History.log(State.data, 'getstate', State.url);
		$.getScript(State.url);
	    });
//	$(window).bind("popstate", function() {
//		$.getScript(location.href);
//	    });
});
