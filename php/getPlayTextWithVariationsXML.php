<?php

	header("Content-Type: text/xml");
	
	require_once 'db_connect.php';
	
	$edition = $_GET['e'];
		
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
		
		
		$text = checkForVariation($actualLine, $text, $edition, $resultEditionVar);
		
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
	
	
	
	function checkForVariation($line, $text, $edition, $resultEditionVar) {
	
		//check for variations
		if (!$edition) {
			$queryVar = "SELECT line,source FROM variants WHERE line=$line";
		} else {
			$queryVar = "SELECT variants.* FROM variants, variant_witnesses WHERE variants.line = $line AND variant_witnesses.variant = variants.id AND variant_witnesses.witness = $edition";
		}
		
		$resultEditionVar = mysql_query($queryVar);
		
		$numVar = mysql_num_rows($resultEditionVar);
		
		if ($numVar > 0) {
		
			$v = 0;
			$previousSource = "";
			
			while ($v < $numVar) {
				
				$source = mysql_result($resultEditionVar,$v,"source");
				
				
				if ($source != $previousSource) {
					
					if (!$edition) {
						$addTags = "<span styleName='Variation' edition='".$edition."'>".$source."</span>";
					} else {
						$variant = mysql_result($resultEditionVar,$v,"variant");
						$addTags = "<span styleName='Variation' edition='".$edition."'>".$variant."</span>";
					}
					
					
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