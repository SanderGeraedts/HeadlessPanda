<?php

public class Article{
	private $id;
	private $title;
	private $publish_date;
	private $featured_img;
	private $edit_dates;
	private $author;
	private $editors;
	private $categories;

	private $fillable = array('title', 'publish_date', 'featured_img', 'edit_dates', 'author', 'editors', 'categories');
	private $accessible = array('id', 'title', 'publish_date', 'featured_img', 'edit_dates', 'author', 'editors', 'categories');
	private $required = array('id', 'title', 'author');

	public function __set ($name, $value) {
		if (in_array($name, $this->fillable)) {
			if (isset($this->$name)) {
				$this->$name = $value;
			}
		}

		return null;
	}

	public function __get ($name) {
		if (in_array($name, $this->accessible)) {
			if (isset($this->$name)) {
				return $this->$name;
			}
		}
		return null;
	}

	public function __construct(Array $params = array()){
		if(count($params) > 0){
			foreach ($params as $key => $value) {
				$this->$key = $value;
			}

			foreach($this->required as $key){
				if(!isset($this->$key)){
					throw new \InvalidArgumentException("Invalid use of constructor:\n" . $key . " can't be empty");
				}
			}
		}
	}
}

?>