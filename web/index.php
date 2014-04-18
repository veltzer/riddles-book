<html>
	<head>
		<meta charset="UTF-8">
		<title>Riddling</title>
		<link rel="shortcut icon" href="favicon.ico"/>
		<meta name="Description" content="A riddle collection done with open source tools"/>
		<meta name="Keywords" content="Mark Veltzer, veltzer, riddles, riddling, collection"/>
	</head>
	<body>
		<h1>Welcome to the riddling project</h1>
		<p>
		<b>riddles</b> is collection of riddles in tex format.
		You can find the latest version <a href="../out/riddling.pdf">here</a>.
		Project home page is <a href="https://veltzer.net/riddling">here</a>.
		</p>
		<iframe src="viewer/viewer.html" width="100%" height="1700px"></iframe>
		<p>
		Mark Veltzer, <?php 
			$copyYear = 2012;
			$curYear = date('Y');
			echo $copyYear . (($copyYear != $curYear) ? '-' . $curYear : '');
		?>
		<a href="mailto:mark.veltzer@gmail.com">mark.veltzer@gmail.com</a>
		</p>
	</body>
</html>
