$(function() {
	var History = window.History;
	if ( !History.enabled ){
	    return false;
	}
	$(".laydesk_sidebar_menu a").live("click", function(e) {

//		$.getScript(this.href);
		History.pushState(null, document.title, this.href);
//		e.preventDefault();
	    });
	History.Adapter.bind(window, 'statechange', function(){
		var State = History.getState();
//		History.log(State.data, State.title, State.url);
		$.getScript(State.url);
		

	    });
//	$(window).bind("popstate", function() {
//		$.getScript(location.href);
//	    });
});
