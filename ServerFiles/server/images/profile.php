<?php

require './melisdk/meli.php';

define('FORM_INPUT_ID_FIELD', '<input type="hidden" name="id" value="');
define('LINK_NEXT_PAGE', '>Siguiente >></a>');
define('HREF_KEY_WORD', 'href=');
define('MELI_DOMAIN', 'http://www.mercadolibre.com.ar');
define('TRANSACTION_START', '<div id="compra_texto"><a href="/jm/profile?id=');
define('TRANSACTION_ITEM_START', '<a href="/jm/item?site=MLA&id=');
define('TRANSACTION_ITEM_START_NO_LINK', 'vendi');
define('DIV_END', '</div>');

	function get_page($url) {
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
		
		$data = curl_exec($curl);
		if(!curl_errno($curl)){
			$info = curl_getinfo($curl);
			 dbg('<p>Took ' . $info['total_time'] . ' seconds to send a request to ' . $info['url']);
			 $content_type = curl_getinfo($curl, CURLINFO_CONTENT_TYPE);
			 dbg('<p>Content type: ' . $content_type);
		} else {
			 dbg('<p>Curl error: ' . curl_error($curl));
		}
		curl_close($curl);
		
		$data = preg_replace('/[^!-%\x27-;=?-~<>&\x09\x0a\x0d\x0B ]/e', '"&#".ord("$0").chr(59)', $data);
		$data = preg_replace('/&#195;&#([0-9]+);/e', '"&#".((int) \\1 + 64).";"', $data);
		
		return $data;
	}

	function cs_profile_get_meli_user_id($login) {
		$data = get_page("http://perfil.mercadolibre.com.ar/" . strtoupper($login));
		$i = strpos($data, FORM_INPUT_ID_FIELD);
		if ($i !== false) {
			$i += strlen(FORM_INPUT_ID_FIELD);
			$j = strpos($data, "\">", $i);
			if ($j !== false) {
				$id = substr($data, $i, $j - $i);
			}
		}
		
		 dbg("<p>id: $id");
		
		return $id;
	}
	
	function cs_profile_get_seller_list($meli_user_id) {
		$transactions = array();
		$url = "http://www.mercadolibre.com.ar/jm/profile?act=ver&id=" . $meli_user_id . "&tipo=L&oper=S&orden=1&RP2=Y";
		do {
			$data = get_page($url);
			read_transactions($data, $transactions);
			$link = get_next_page_link($data);
			if ($link === false) {
				$url = "";
			}
			else {
				$url = get_url_from_link($link);	
			}
		} while ($url !== "");
		
		return $transactions;
	}
	
	function get_next_page_link($data) {
		$j = strpos($data, LINK_NEXT_PAGE);
		if ($j !== false) {
			$i = $j - 1;
			do {
				$c = substr($data, $i, 1);
				$i -= 1;
			} while ($c !== "<" || $i < 0);
		}
		if ($c === "<") {
			return substr($data, $i +1, $j - $i);
		}
		else {
			return "";
		}		
	}
	
	function get_url_from_link($link) {
		$i = strpos($link, HREF_KEY_WORD);
		if ($i !== false) {
			$i += strlen(HREF_KEY_WORD);			
			$delimiter = substr($link, $i, 1);
			$j = strpos($link, $delimiter, $i +1);
			if ($j !== false) {
				return MELI_DOMAIN . substr($link, $i +1, $j - $i);				
			}
			else {
				return "";
			}
		}
		else {
			return "";
		}
	}
	
	/*
	<div id="compra_texto"><a href="/jm/profile?id=86284620&oper=B">TECHNOENE...(3033)</a>
	<span class="clfRowSup"></span>
	vendió <a href="/jm/item?site=MLA&id=464039802">Notebook Sony Vaio...$4999.98</a></div>
	</div>
	*/
	function read_transactions($data, &$transactions) {
		$i = strpos($data, TRANSACTION_START);
		while ($i !== false) {
			$k = strpos($data, DIV_END, $i);
			
			//dbg("<p>k $k");
			
			$seller_id = "0";
			$seller_name = "";
			$item_id = "0";
			$item_name = "";
			
			$i += strlen(TRANSACTION_START);
			$seller_id = extract_text($data, "&", $i);
			$j = move_next($data, ">", $i, $k);
			if ($j !== false) {
				$seller_name = extract_text($data, "<", $j +1);				
				$j = move_next($data, TRANSACTION_ITEM_START, $j, $k);
				if ($j !== false) {
					$j += strlen(TRANSACTION_ITEM_START);
					$item_id = extract_text($data, "\"", $j);
					$j = move_next($data, ">", $j, $k);
					if ($j !== false) {
						$item_name = extract_text($data, "<", $j +1);
					}
				}
				else {
					$j = move_next($data, TRANSACTION_ITEM_START_NO_LINK, $i, $k);
					if ($j !== false) {
						$j += strlen(TRANSACTION_ITEM_START_NO_LINK);
						$item_name = extract_text($data, "<", $j +1);
					}						
				}
			}
			
			$transaction = new stdClass;
			
			$transaction->seller_id = $seller_id;
			$transaction->seller_name = $seller_name;
			$transaction->item_id = $item_id;
			$transaction->item_name = $item_name;

			$transactions[] = $transaction;
			
			$i = strpos($data, TRANSACTION_START, $i);
		}		
	}
	
	function move_next($data, $to_search, $start_pos, $max_pos) {
		$pos = strpos($data, $to_search, $start_pos);
		if ($pos !== false) {
			if ($pos > $max_pos) {
				$pos = false;
			}
		}
		return $pos;
	}
	
	function extract_text($data, $end_text, $start_pos) {
		$end = strpos($data, $end_text, $start_pos);
		if ($end === false) {
			return false;
		}
		else {
			return substr($data, $start_pos, $end - $start_pos);
		}
	}
	
?>