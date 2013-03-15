<?php
	require_once 'db_connect.php';
	
	$witness = $_GET['w'];
	
	//query
	if ($witness == "") {
		//$query = "SELECT variants.*, witnesses.* FROM variants, variant_witnesses, witnesses WHERE variant_witnesses.variant = variants.id AND witnesses.id = variant_witnesses.witness";
		$query = "SELECT * FROM variants";
	} else {
		$query = "SELECT * FROM variant_witnesses,variants WHERE variant_witnesses.witness = ".$witness." AND variants.id = variant_witnesses.variant";
	}
		
	//results
	$result = mysql_query($query);
	
	$rows = array();
	
	//loop variants
	while($r = mysql_fetch_assoc($result)) {
	  	$varID = $r["id"];
	  	
	  	//retrive the editions for each variation
	  	$editions = array();
	  	
	  	$query = "SELECT * FROM variant_witnesses WHERE variant_witnesses.variant = " . $varID;
	  	$resultEditions = mysql_query($query);
	  	
	  	while($rE = mysql_fetch_assoc($resultEditions)) {
	  		$editions[] = $rE["witness"];
	  	}
	  	
	    $r["editions"] = $editions;
	    
	    $rows[] = $r;
	}
	
	print json_encode($rows);
	
?>