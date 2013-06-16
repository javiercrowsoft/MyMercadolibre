<?php
// myhumbleimage.php

// Do whatever myhumbleimage.php does before the image is delivered

header('Content-Type: image/jpeg');
$item_id = isset($_GET['item_id']) ? $_GET['item_id'] : 0;


if ($item_id ==464039802) { readfile('images/464039802.jpg'); exit();}
if ($item_id ==456867545) { readfile('images/456867545.jpg'); exit();}
if ($item_id ==458127787) { readfile('images/458127787.jpg'); exit();}
if ($item_id ==447626337) { readfile('images/447626337.jpg'); exit();}
if ($item_id ==449855557) { readfile('images/449855557.jpg'); exit();}
if ($item_id ==449265739) { readfile('images/449265739.jpg'); exit();}
if ($item_id ==447921419) { readfile('images/447921419.png'); exit();}
		
if ($item_id == 0) {
	readfile('images/default_grey.jpg');
}
else {
	readfile('images/default.jpg');	
}
exit;

?>