<?php
require_once('../connect/Database.php');


class JsonHandler {
	private $database;

	public function __get ($name) {
		if (isset($this->$name)) {
			return $this->$name;
		}
	}

	public function __construct() {
		$this->database = new Database();
	}

	public function check_api_id($api) {
		if($this->database->check_api_id($api)) {
			return true;
		} else {
			return false;
		}
	}
}
?>