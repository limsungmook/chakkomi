$(function() {
	$.setFragment({ "page" : $.queryString(this.href).page })
	$.getScript(this.href);


    });