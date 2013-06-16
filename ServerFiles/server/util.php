<?php

	function dbg($text) {
		global $in_debug;
		
		if (!CS_DEBUG_ON && !$in_debug)
			return;
		fdbg($text . "<br />");
	}

	function fdbg($text) {
		echo $text;
	}
	
	function dbg_dump($mixed) {
		global $in_debug;
		
		if (!CS_DEBUG_ON && !$in_debug) 
			return "";
		ob_start();
		var_dump($mixed);
		return ob_get_clean();
	}
	
	function h1($text) {
		echo "<h1>" . $text . "</h1>";
	}

	function h2($text) {
		echo "<h2>" . $text . "</h2>";
	}

	function pe($text) {
		p("<font color='red'>$text</font>");
	}
	
	function p($label, $value = null) {
		$text = $label . ($value == null ? "" : ": $value");
		echo "<p>" . $text . "</p>";
	}
	
	function unescape($str) {
		$str = str_replace("%25", "%", $str);
		$str = str_replace("%3B", ",", $str);
		$str = str_replace("%3F", "?", $str);
		$str = str_replace("%2F", "/", $str);
		$str = str_replace("%3A", ":", $str);
		$str = str_replace("%23", "#", $str);
		$str = str_replace("%26", "&", $str);
		$str = str_replace("%3D", "=", $str);
		$str = str_replace("%2B", "+", $str);
		$str = str_replace("%24", "$", $str);
		$str = str_replace("%2C", ",", $str);
		$str = str_replace("%20", " ", $str);
		$str = str_replace("%3C", "<", $str);
		$str = str_replace("%3E", ">", $str);
		return str_replace("%7E", "~", $str);
	}
	
	/**
	 * Indents a flat JSON string to make it more human-readable.
	 *
	 * @param string $json The original JSON string to process.
	 *
	 * @return string Indented version of the original JSON string.
	 */
	function indent($json) {
	
		$result      = '';
		$pos         = 0;
		$strLen      = strlen($json);
		$indentStr   = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
		$newLine     = "<br />";
		$prevChar    = '';
		$outOfQuotes = true;
	
		for ($i=0; $i<=$strLen; $i++) {
	
			// Grab the next character in the string.
			$char = substr($json, $i, 1);
	
			// Are we inside a quoted string?
			if ($char == '"' && $prevChar != '\\') {
				$outOfQuotes = !$outOfQuotes;
	
				// If this character is the end of an element,
				// output a new line and indent the next line.
			} else if(($char == '}' || $char == ']') && $outOfQuotes) {
				$result .= $newLine;
				$pos --;
				for ($j=0; $j<$pos; $j++) {
					$result .= $indentStr;
				}
			}
	
			// Add the character to the result string.
			$result .= $char;
	
			// If the last character was the beginning of an element,
			// output a new line and indent the next line.
			if (($char == ',' || $char == '{' || $char == '[') && $outOfQuotes) {
				$result .= $newLine;
				if ($char == '{' || $char == '[') {
					$pos ++;
				}
	
				for ($j = 0; $j < $pos; $j++) {
					$result .= $indentStr;
				}
			}
	
			$prevChar = $char;
		}
	
		return $result;
	}
	
?>