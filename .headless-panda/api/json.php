<?php

//checks the method and api and executes it.
if(isset($_POST['method']) && isset($_POST['api'])){
	require_once(HP_ROOT . '/api/connect/Database.php');

	$database = new Database();

	if($database->check_api_id($_POST['api'])) {
		if(function_exists($_POST['method'])) {
			if(isset($_POST['params'])) {
				$_POST['method']($_POST['params']);
			} else {
				$_POST['method']();
			}
		} else {
			return "The method doesn't exist.";
		}
	} else {
		return "Your API Id wasn't found.";
	}

} else {
	return "Please post a method and your API Id";
}

function test($params){	
	echo 'blub';
}

?>