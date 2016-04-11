<?php 

define('HP_SERVER', 'http://localhost:8080/HeadlessPanda/Server/.headless-panda/');

/**
* 
*/
class HeadlessPanda
{
	public static function get_all_articles() {
		$url = HP_SERVER . 'api/json/get_all_articles.php';

		$json = file_get_contents($url);

		if($json != null) {
			$data = json_decode($json);
			return $data;
		}
	}
}

?>