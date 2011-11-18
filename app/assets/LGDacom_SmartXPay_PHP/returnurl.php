<html>
<head>
	<script type="text/javascript">
	
		function setLGDResult() {
			if( parent.LGD_window_type == "iframe" ){
				parent.setLGDResult();
			} else {
				opener.setLGDResult();
				window.close();
			}
		}
		
	</script>
</head>
<body onload="setLGDResult()">
<?php
   if( is_array($_REQUEST) ) {                                                                                                                                                    
      foreach( $_REQUEST as $name => $value) {                                                                                                                 
        printf("<input type='hidden' id='%s' value='%s'>\n", $name, $value);                                                                                                          
      }                                                                                                                                                                           
    }                                                                                                                                    
?>
</body>
</html>