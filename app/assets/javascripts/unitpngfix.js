/* used unitpngfix.js. but i was fix very little for selecting the browser enviorment.
   if there is problem. mail me. ipes4579@gmail.com. and sorry my pool english. */

(function($){
    var ie55 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 5.5") != -1);
    var ie6 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 6.0") != -1);
    if (jQuery.browser.msie && (ie55 || ie6)) {
    var clear="/assets/clear.gif"; //path to clear.gif
    
    document.write('<script type="text/javascript" id="ct" defer="defer" src="javascript:void(0)"><\/script>');var ct=document.getElementById("ct");ct.onreadystatechange=function(){pngfix()};pngfix=function(){var els=document.getElementsByTagName('*'),ip=/\.png/i,al="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='",i=els.length,uels=new Array(),c=0;while(i-->0){if(els[i].className.match(/unitPng/)){uels[c]=els[i];c++;}}if(uels.length==0)pfx(els);else pfx(uels);function pfx(els){i=els.length;while(i-->0){var el=els[i],es=el.style,elc=el.currentStyle,elb=elc.backgroundImage;if(el.src&&el.src.match(ip)&&!es.filter){es.height=el.height;es.width=el.width;es.filter=al+el.src+"',sizingMethod='crop')";el.src=clear;}else{if(elb.match(ip)){var path=elb.split('"'),rep=(elc.backgroundRepeat=='no-repeat')?'crop':'scale',elkids=el.getElementsByTagName('*'),j=elkids.length;es.filter=al+path[1]+"',sizingMethod='"+rep+"')";es.height=el.clientHeight+'px';es.backgroundImage='none';if(j!=0){if(elc.position!="absolute")es.position='static';while(j-->0)if(!elkids[j].style.position)elkids[j].style.position="relative";}}}}};};
    }
    
})(jQuery);