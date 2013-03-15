<?php

	header("Content-Type: text/xml");
	
	require_once 'db_connect.php';
		
	//query
	$query = "SELECT * FROM play_text";
		
	//results
	$result = mysql_query($query);
		
	$i = 0;
	
	$num = mysql_num_rows($result);
	
	echo "<?xml version='1.0' encoding='utf-8'?>"."\n";
	echo "<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'>"."\n";
	echo "<div id='playtext'>"."\n";
	
	$lineArray;
	
	while ($i < $num) {
	
		$actualLine = mysql_result($result,$i,"line");
		$text = mysql_result($result,$i,"text");
		$type = mysql_result($result,$i,"type");
		
		
		$text = checkForVariation($actualLine, $text);
		
		//adding the tags	
		$text = "<g styleName='" . $type . "'>" . $text . "</g>";
		
		
		//Groups chunks by line
		if ($actualLine == $previousLine) {
		
			$lineArray[$previousLine] = $lineArray[$previousLine] . " " . $text;
		
		} else {
			
			$lineArray[$actualLine] = "<span styleName='LineNumber'>" . $actualLine . "</span>" . $text;
			
			$previousLine = $actualLine;
		}
		
		$i++;
		
	}
	
	
	//built xml line by line
	for ($i=1; $i <= count($lineArray); $i++) {
	
		$lineText = $lineArray[$i];
		
				
		echo "<p line='".$i."'>"."\n";
		echo $lineText;
		echo "</p>"."\n";
		
	}
	
	echo "</div>"."\n";
	echo "</TextFlow>";
	
	
	function checkForVariation($line, $text) {
		//check for variations
		$queryVar = "SELECT line,source FROM variants WHERE line=$line";
		$resultVar = mysql_query($queryVar);
		$numVar = mysql_num_rows($resultVar);
	
		
		
		if ($numVar > 0) {
		
			$v = 0;
			$previousSource = "";
			
			while ($v < $numVar) {
				
				$source = mysql_result($resultVar,$v,"source");
				
				if ($source != $previousSource) {
					
					$addTags = "<span styleName='Variation'>".$source."</span>";
					
					$text = str_replace($source, $addTags, $text);
					
				}
				
				$previousSource = $source;
				$v++;
			}
			
			return $text;
			
		
		} else {
			return $text;
		}

		
	}
	
?>