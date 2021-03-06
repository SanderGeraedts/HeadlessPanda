<?php 
	require_once('.headless-panda/HeadlessPanda.php');
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Headless Receiver</title>
		<link href="assets/css/style.css" rel = stylesheet />
		<link href="assets/img/favicon.ico" rel="shortcut icon">  
		<meta name="description" content="This is just a test site for the Headless Panda API.">
		<meta name="author" content="Code Panda - www.codepanda.nl">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta charset="UTF-8">
		<script type="text/javascript" src="assets/js/jschecker.js"></script>
	</head>
	<body>
		<header id="head">
			<div class="wrapper">
				<div id="logo">
					<p>Test site</p>
				</div>
				<nav id="navigation">
					<ul>
						<li><a id="active" class="top" href="index.html">Home</a></li>
						<li><a href="about.html">About</a></li>
						<li><a href="activities.html">Blog</a></li>
						<li><a href="">Contact</a></li>
				</nav>
			</div>
		</header>
		<main>
			<div class="wrapper"><?php 
					$articles = HeadlessPanda::get_all_articles();
					foreach($articles as $article){
						echo '<h1>' . $article->title . '</h1>';
						echo '<p>' . $article->excerpt . '</p>';
					}
				?></div>
		</main>
		<footer>
		</footer>
		<script src="assets/js/main.js"></script>
	</body>
</html>