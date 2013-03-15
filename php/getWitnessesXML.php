<?php

	header("Content-Type: text/xml");
		
	require_once 'db_connect.php';
		
	//query
	$query = "SELECT * FROM witnesses";
		
	//results
	$result = mysql_query($query);
	$num = mysql_num_rows($result);
	
	echo '<?xml version="1.0" encoding="utf-8"?>';
	echo '<witnesses>';
	
	$i = 0;
	
	while ($i < $num) {
	
		$id = mysql_result($result, $i, "id");
		$xml_id = mysql_result($result, $i, "xml_id");
		$title = mysql_result($result, $i, "title");
		$author = mysql_result($result, $i, "author");
		$abbreviation = mysql_result($result, $i, "abbreviation");
		$date = mysql_result($result, $i, "date");
		
		echo '<witness id="'.$id.'">';
			echo '<title><![CDATA['.$title.']]></title>';
			echo '<author><![CDATA['.$author.']]></author>';
			echo '<abbreviation><![CDATA['.$abbreviation.']]></abbreviation>';
			echo '<date>'.$date.'</date>';
		echo '</witness>';
		
		$i++;
		
	}
	
	echo '</witnesses>';

?>