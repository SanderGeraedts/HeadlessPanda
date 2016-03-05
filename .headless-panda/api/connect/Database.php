<?php 

DEFINE ('DB_USER', 'root');
DEFINE ('DB_PASSWORD', '');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'headlesspanda');

/**
* 
*/
class Database
{
	private $conn;

	public function __construct(){
		$this->conn = @mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) OR die('Could not connect to MySQL: ' . mysqli_connect_error());
	}

	public function __destruct(){
		mysqli_close($this->conn);
	}

	private function executeSQL($sql){
		if($this->conn->query($sql)){
			return true;
		}else{
			return false;
		}
	}

	private function sanitate($array) {
		foreach ($array as $key => $value) {
			if(is_array($value)) {
				$this->sanitate($value);
			}else {
				$array[$key] = mysqli_real_escape_string($this->conn, $value);
			}
			return $array;
		}
	}
}
?>