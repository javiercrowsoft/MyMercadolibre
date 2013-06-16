<?php

	class ResultSet {
	
		private $index = -1;
		public $rows = array();
	
		function __construct($stmt) {
	
			if($meta_results = $stmt->result_metadata()) {
				$fields = $meta_results->fetch_fields();
				$statementParams='';
			  
				//build the bind_results statement dynamically so I can get the results in an array
				foreach($fields as $field){
					if(empty($statementParams)){
						$statementParams.="\$row['".$field->name."']";
					}else{
						$statementParams.=", \$row['".$field->name."']";
					}
				}
				$statment="\$stmt->bind_result($statementParams);";
				eval($statment);
				
				while($stmt->fetch()) {
					$newRow = array();
					foreach($row as $col => $value) {
						$newRow[$col] = $value;
					}
					$this->rows[] = $newRow;
				}
				$stmt->close();
			}
		}
	
		function fetch_assoc() {
			$this->index++;
			if ($this->index > sizeof($this->rows) -1)
				return null;
			else
				return $this->rows[$this->index];
		}
		 
	}
	
	$mysqli = null;
	
	function cs_db_connect($server, $username, $password, $database) {
	    global $mysqli;
	
	    $mysqli = new mysqli($server, $username, $password, $database);
	    
	    if (mysqli_connect_errno()) {
	    	
	    	printf("Connect failed: %s\n", mysqli_connect_error());
	    	exit();
	    }
	        
	    return $mysqli;
	}
	
	function cs_db_exists($sqlstmt, $qparams) {
	  	return cs_db_num_rows($sqlstmt, $qparams) > 0;
	}
	
	/*
	function cs_db_query($sqlstmt) {
	    global $mysqli;
	    
	    return $mysqli->query($sqlstmt);
	}
	*/
	  
	function cs_db_insert_and_return_id($sqlstmt, $qparams) {
	  	global $mysqli;
	  	
	  	cs_db_query($sqlstmt, $qparams);
	  	return $mysqli->insert_id;
	}
	
	function cs_db_num_rows($sqlstmt, $qparams) {
	  	global $mysqli;
	  	
	  	$rows = 0;
	  	
	  	//dbg("<p>sqlstmt: $sqlstmt</p>");
	  	
		if ($stmt = $mysqli->prepare($sqlstmt)) {
			bind_params($stmt, $qparams);
		    $stmt->execute();
		    $stmt->store_result();
		    $rows = $stmt->num_rows;
		    $stmt->close();
		}
		
		return $rows;
	}
	  
	function sql_string($text) {
	  	global $mysqli;
	  	
	  	return "'" . $mysqli->real_escape_string($text) . "'";
	}
	 
	function cs_db_query($sqlstmt, $qparams = array()) {
	  	global $mysqli;
	  	
	  	//dbg("<p>sqlstmt: $sqlstmt</p>");
	  	
	  	$stmt = $mysqli->prepare($sqlstmt);
	  	bind_params($stmt, $qparams);
	  	$stmt->execute();
	  	return new ResultSet($stmt);
	}
	  
	function get_ref_values($arr){
	  	if (strnatcmp(phpversion(),'5.3') >= 0) //Reference is required for PHP 5.3+
	  	{
	  		$refs = array();
	  		foreach($arr as $key => $value)
	  			$refs[$key] = &$arr[$key];
	  		return $refs;
	  	}
	  	return $arr;
	}
	
	function bind_params($stmt, $qparams) {
		// if the query has parameters
		if (sizeof($qparams) > 0) {
			
			//dbg("<p>".dbg_dump($qparams));
		
			// first get types
			$types = "";
			foreach($qparams as $p) {
				foreach($p as $type => $value) {
					$types .= $type;
				}
			}
			 
			// first parameter of new parameter array
			$sqlparams[] = $types;
			 
			//dbg("<p>type: $types</p>");
			 
			// now get the value of each param
			foreach($qparams as $p) {
				foreach($p as $type => $value) {
					$sqlparams[] = $value;
				}
			}
		
			//dbg("<p>".dbg_dump($stmt)."</p>");
			//dbg("<p>".dbg_dump($sqlparams)."</p>");
		
			// bind parameters with statment
			call_user_func_array(array($stmt, "bind_param"), get_ref_values($sqlparams));
		}
	}

?>
