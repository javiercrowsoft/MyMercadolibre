<?php

$in_debug = false;

$in_debug = isset($_GET['in_debug']) ? $_GET['in_debug'] == 'y' : false;

if ($in_debug) {
	error_reporting(E_ALL);
	ini_set('display_errors', 1);
}

define('CS_DEBUG_ON', false);

$cs_server		= 'localhost';
$cs_user		= 'crowsoft_meli';
$cs_password  	= '***********';
$cs_database  	= 'crowsoft_cscvxi';
?>