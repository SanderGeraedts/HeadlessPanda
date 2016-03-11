<?php 

require_once('../../config.php');
require_once('JsonHandler.php');
require_once(HP_ROOT . 'api/logic/Article.php');

$handler = new JsonHandler();
$_POST['api'] = "jkldjfdklm";

if($handler->check_api_id($_POST['api'])){
	$json = $handler->database->get_all_articles();
	echo json_encode($json);
} else {
	echo "You're API Id doesn't check out.";
}

?>