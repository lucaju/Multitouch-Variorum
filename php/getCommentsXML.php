<?php

	header("Content-Type: text/xml");
		
	require_once 'db_connect.php';
		
	//query
	$query = "SELECT * FROM comments";
		
	//results
	$result = mysql_query($query);
	$num = mysql_num_rows($result);
	
	echo '<?xml version="1.0" encoding="utf-8"?>';
	echo '<comments>';
	
	$i = 0;
	
	while ($i < $num) {
	
		$id = mysql_result($result, $i, "id");
		$line_start = mysql_result($result, $i, "line_start");
		$line_end = mysql_result($result, $i, "line_end");
		$source = mysql_result($result, $i, "source");
		$author = mysql_result($result, $i, "author");
		$citation = mysql_result($result, $i, "citation");
		$reference_start = mysql_result($result, $i, "reference_start");
		$reference_end = mysql_result($result, $i, "reference_end");
		$text = mysql_result($result, $i, "comment");
				
		echo '<comment id="'.$id.'" lineStart="'.$line_start.'" lineEnd="'.$line_end.'">';
			echo '<source><![CDATA['.$source.']]></source>';
			echo '<author><![CDATA['.$author.']]></author>';
			echo '<citation><![CDATA['.$citation.']]></citation>';
			echo '<reference>';
				echo '<start>'.$reference_start.'</start>';
				echo '<end>'.$reference_end.'</end>';
			echo '</reference>';
			echo '<text><![CDATA['.$text.']]></text>';
		echo '</comment>';
		
		$i++;
		
	}
	
	echo '</comments>';

?>