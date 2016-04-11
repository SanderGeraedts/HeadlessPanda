<?php 

class viewMain{
	private $loggedIn;

	public function __construct(){
		if($_SESSION['loggedIn'] != null){
			$this->loggedIn = unserialize($_SESSION['loggedIn']);
		}else {
			header('Location: login.php');
			$_SESSION['last_page'] = __FILE__;
			die();
		}
	}
}
 ?>