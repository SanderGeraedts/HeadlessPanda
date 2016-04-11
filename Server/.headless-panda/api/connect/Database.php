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

	public function check_api_id($api){
		$api = mysqli_real_escape_string($this->conn, $api);
		return true;
	}

	public function get_all_articles(){
		$sql = "SELECT * FROM HP_ARTICLE";

		$command = @mysqli_query($this->conn, $sql);

		$articles = array();

		if($command) {
			while($row = mysqli_fetch_array($command)) {
				$article = new Article(array('id'=>$row['Id'], 'title'=>$row['Title'], 'excerpt'=>$row['Excerpt'], 'publish_date'=>$row['Publish_Date'], 'featured_img'=>$row['Featured_Img'], 'author'=>$row['Author_Id']));
				array_push($articles, $article);
			}
		}

		return $articles;
	}
}
?>