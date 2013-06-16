<?php

	function cs_user_update_token($code, $name, $user_id, $info, $auth_code, $expires, $scope, $refresh_token) {
		$sqlstmt = "select 1 from customer where cu_code = ?";
		$qparams = array();
		$qparams[] = array("s" => $code);
		$exists = cs_db_exists($sqlstmt, $qparams);
		$insert = "insert into customer (cu_code, cu_name, cu_meli_user_id, cu_meli_info, cu_meli_auth_code, cu_meli_expires, cu_meli_scope, cu_meli_refresh_token)"
				." values (?, ?, ?, ?, ?, ?, ?, ?)";
		$qiparams = array();
		$qiparams[] = array("s" => $code);
		$qiparams[] = array("s" => $name);
		$qiparams[] = array("s" => $user_id);
		$qiparams[] = array("s" => $info);
		$qiparams[] = array("s" => $auth_code);
		$qiparams[] = array("s" => $expires);
		$qiparams[] = array("s" => $scope);
		$qiparams[] = array("s" => $refresh_token);
		
		$update = "update customer set cu_meli_auth_code = ?, cu_meli_expires = ?, cu_meli_scope = ?, cu_meli_refresh_token = ? where cu_code = ?";
		$quparams = array();
		$quparams[] = array("s" => $auth_code);
		$quparams[] = array("s" => $expires);
		$quparams[] = array("s" => $scope);
		$quparams[] = array("s" => $refresh_token);
		$quparams[] = array("s" => $code);
			
		if ($exists) {
			$sqlstmt = $update;
			$qparams = $quparams;
		}
		else {
			$sqlstmt = $insert;
			$qparams = $qiparams;
		}
		return cs_db_query($sqlstmt, $qparams);
	}
	
	function cs_user_get_cu_id($code) {
		$sqlstmt = "select cu_id from customer where cu_code = ?";
		$qparams = array();
		$qparams[] = array("s" => $code);
		$result = cs_db_query($sqlstmt, $qparams);
		if ($row = $result->fetch_assoc()) {
			return $row['cu_id'];
		}
		else {
			return 0;
		}	
	}
	
	function cs_user_get_cu_id_from_meli_user_id($meli_user_id) {
		$sqlstmt = "select cu_id from customer where cu_meli_user_id = ?";
		$qparams = array();
		$qparams[] = array("s" => $meli_user_id);
		$result = cs_db_query($sqlstmt, $qparams);
		if ($row = $result->fetch_assoc()) {
			return $row['cu_id'];
		}
		else {
			return 0;
		}
	}

	function cs_user_get_meli_user_id_from_cu_id($cu_id) {
		$sqlstmt = "select cu_meli_user_id from customer where cu_id = ?";
		$qparams = array();
		$qparams[] = array("i" => $cu_id);
		$result = cs_db_query($sqlstmt, $qparams);
		if ($row = $result->fetch_assoc()) {
			return $row['cu_meli_user_id'];
		}
		else {
			return 0;
		}
	}
	
	function cs_user_get_access_token($user_id) {
		$sqlstmt = "select cu_meli_auth_code, cu_meli_expires, cu_meli_scope, cu_meli_refresh_token from customer where cu_meli_user_id = ?";
		$qparams = array();
		$qparams[] = array("s" => $user_id);
		$result = cs_db_query($sqlstmt, $qparams);
		if ($row = $result->fetch_assoc()) {
			return array('value' => $row['cu_meli_auth_code'],
							'expires' => time() + $row['cu_meli_expires'],
							'scope' => $row['cu_meli_scope'],
							'refresh_token' => $row['cu_meli_refresh_token']);
		}
		else 
			return null;		
	}
	
	function cs_user_update_password($password, $password2, $user_id) {
		if(isset($password) && isset($password2)) {
			if($user_id == 0 || $user_id == null) {
				return "Invalid user id";
			}
			if (!($password == $password2)) {
				return "Password and confirmation don't match";
			}
			if (strlen($password) < 12) {
				return "The password must be of twelve characters minimum";
			}
			if (strlen($password) > 255) {
				return "The password must be of two hundred and fifty five characters maximum";
			}
			if (!preg_match('#[0-9]#', $password)) {
				return "The password must contain at least a number";
			}
			if (!preg_match('#[a-z]#i', $password)) {
				return "The password must contain at least a letter";
			}
			$sqlstmt = "update customer set cu_password = ? where cu_meli_user_id = ?";
			$qparams = array();
			$qparams[] = array("s" => $password);
			$qparams[] = array("s" => $user_id);
			cs_db_query($sqlstmt);
		}
		return "";
	}
	
	function cs_user_must_set_password($user_id) {
		$sqlstmt = "select 1 from customer where cu_meli_user_id = ? and cu_password = ''";
		$qparams = array();
		$qparams[] = array("s" => $user_id);
		return cs_db_exists($sqlstmt, $qparams);
	}

	function cs_user_check_token($meli, $access_token_in_db, $user_id) {
		$user = $meli->getWithAccessToken('/users/me');		
		$access_token = $meli->getAccessToken();
		if (is_a_valid_access_token($access_token)) {
			if ($access_token_in_db['value'] !== $access_token['value']) {
				$user_code = $user['json']['nickname'];
				$user_name = $user['json']['first_name'].' '.$user['json']['last_name'];
				$user_info = json_encode($user['json']);
				cs_user_update_token($user_code, $user_name, $user_id, $user_info, $access_token['value'], $access_token['expires'], $access_token['scope'], $access_token['refresh_token']);
			}
		}
	}
	
	function is_a_valid_access_token($access_token) {
		if(!isset($access_token))
			return false;
		if($access_token == null)
			return false;
		if(!isset($access_token['value']))
			return false;
		if ($access_token['value'] == null)
			return false;
		if ($access_token['value'] == "")
			return false;
		return true;
	}
	
?>