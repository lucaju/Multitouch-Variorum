<?php

	//header("Content-Type: text/xml");
		
	require_once 'db_connect.php';
		
	//query
	$query = "SELECT * FROM witnesses";
		
	//results
	$result = mysql_query($query);
	
	$rows = array();
	while($r = mysql_fetch_assoc($result)) {
	    $rows[] = $r;
	}
	
	print json_encode($rows);

?>