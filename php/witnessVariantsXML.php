<?php

	header("Content-Type: text/xml");
	
	require_once 'db_connect.php';
	
	$witness = $_GET['w'];
	
	//query
	if ($witness == "") {
		$query = "SELECT * FROM variants";
	} else {
		$query = "SELECT * FROM variant_witnesses,variants WHERE variant_witnesses.witness = ".$witness." AND variants.id = variant_witnesses.variant";
	}
		
	
	
		
	//results
	$result = mysql_query($query);
		
	$i = 0;
	
	$num = mysql_num_rows($result);
	
	echo '<?xml version="1.0" encoding="utf-8"?>';
	echo '<variants>';
	
	while ($i < $num) {
	
		$id = mysql_result($result,$i,"id");
		$line = mysql_result($result,$i,"line");
		$line_end = mysql_result($result,$i,"line_end");
		$xml_target = mysql_result($result,$i,"xml_target");
		$source = mysql_result($result,$i,"source");
		$variation = mysql_result($result,$i,"variant");
		$type = mysql_result($result,$i,"type");
		
		echo '<variant id="'.$id.'" line="'.$line.'" line_end="'.$line_end.'" xml_target="'.$xml_target.'">';
			echo '<source>'.$source.'</source>';
			echo '<variation>'.$variation.'</variation>';
			echo '<type>'.$type.'</type>';
		echo '</variant>';
		
		$i++;
		
	}
	
	echo '</variants>';
	
?>