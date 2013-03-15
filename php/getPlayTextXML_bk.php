<?php

	header("Content-Type: text/xml");
	
	require_once 'db_connect.php';
		
	//query
	$query = "SELECT * FROM play_text";
		
	//results
	$result = mysql_query($query);
		
	$i = 0;
	
	$num = mysql_num_rows($result);
	
	echo "<?xml version='1.0' encoding='utf-8'?>";
	echo "<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'>";
	echo "<div id='playtext'>";
	
	$lineArray;
	
	while ($i < $num) {
	
		$actualLine = mysql_result($result,$i,"line");
		$text = mysql_result($result,$i,"text");
		$type = mysql_result($result,$i,"type");
			
		//if ($type != "Text") {
			$text = "<span styleName='" . $type . "'>" . $text . "</span>";
		//}
		
		if ($actualLine == $previousLine) {
		
			$lineArray[$previousLine] = $lineArray[$previousLine] . " " . $text;
		
		} else {
		
			$lineArray[$actualLine] = "<span styleName='LineNumber'>" . $actualLine . " - \t</span>" . $text;
			
			$previousLine = $actualLine;
		}
		
		$i++;
		
	}
	
	for ($i=1; $i <= count($lineArray); $i++) {
		
		echo "<p line='".$i."'>";
		echo $lineArray[$i];
		echo "</p>";
		
	}
	
	echo "</div>";
	echo "</TextFlow>";
	
?>