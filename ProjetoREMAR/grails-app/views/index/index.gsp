<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>REMAR</title>
	<link rel="shortcut icon" href="${resource(dir: 'assets/img/logo', file: 'icone-remar_v2.ico')}" type="image/x-icon">

	<link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
	<link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
	<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

	<!-- Bootstrap core CSS -->
	<link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
	<link href="${resource(dir: 'assets/css', file: 'grayscale.css')}" rel="stylesheet">
	<link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">

</head>

<body id="#page-top" data-spy="scroll" data-offset="0" data-target="#navbar-main">

	<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand page-scroll" href="#page-top">
					<span class="icon-puzzle-2 light"></span>REMAR
				</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-right navbar-main-collapse">
				<ul class="nav navbar-nav">
					<!-- Hidden li included to remove active class from about link when scrolled up past about section -->
					<li class="hidden">
						<a href="#page-top">asascascas</a>
					</li>
					<li>
						<a class="page-scroll" href="#about">Sobre</a>
					</li>
					<li>
						<a class="page-scroll" href="#team">Equipe</a>
					</li>
					<li>
						<a class="page-scroll" href="#contact">Contato</a>
					</li>
					<li>
						<g:link  class="btn btn-default btn-lg" controller="login">Entrar</g:link>
					</li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>


	<!-- Intro Header -->
	<header class="intro">
		<div class="intro-body">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<h1 class="brand-heading">REMAR</h1>
						<p class="intro-text">Recursos Educacionais abertos na rede </p>
						<a href="#about" class="btn btn-circle page-scroll">
							<span class="icon-circle-arrow-down"></span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- About Section -->
	<section id="about" class="content-section text-center">
	<div class="about-section">

	</div>
	<div class="container">
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2 about">
				<p>Grayscale is a free Bootstrap 3 theme created by Start Bootstrap. It can be yours right now, simply team the template on <a href="http://startbootstrap.com/template-overviews/grayscale/">the preview page</a>. The theme is open source, and you can use it for any purpose, personal or commercial.</p>
				<p>This theme features stock photos by <a href="http://gratisography.com/">Gratisography</a> along with a custom Google Maps skin courtesy of <a href="http://snazzymaps.com/">Snazzy Maps</a>.</p>
				<p>Grayscale includes full HTML, CSS, and custom JavaScript files along with LESS files for easy customization.</p>
			</div>
		</div>
	</div>

	</section>

	<!-- team Section -->
	<section id="team" class="content-section text-center">
		<div class="team-section">
			<div class="container">
				<div class="col-lg-8 col-lg-offset-2">
					<h2>team Grayscale</h2>
					<p>You can team Grayscale for free on the preview page at Start Bootstrap.</p>
					<a href="http://startbootstrap.com/template-overviews/grayscale/" class="btn btn-default btn-lg">Visit team Page</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Contact Section -->
	<section id="contact" class="container content-section text-center">
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<h2>Contact Start Bootstrap</h2>
				<p>Feel free to email us to provide some feedback on our templates, give us suggestions for new templates and themes, or to just say hello!</p>
				<p><a href="mailto:feedback@startbootstrap.com">feedback@startbootstrap.com</a>
				</p>
				<ul class="list-inline banner-social-buttons">
					<li>
						<a href="https://twitter.com/SBootstrap" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a>
					</li>
					<li>
						<a href="https://github.com/IronSummitMedia/startbootstrap" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i> <span class="network-name">Github</span></a>
					</li>
					<li>
						<a href="https://plus.google.com/+Startbootstrap/posts" class="btn btn-default btn-lg"><i class="fa fa-google-plus fa-fw"></i> <span class="network-name">Google+</span></a>
					</li>
				</ul>
			</div>
		</div>
	</section>

	<!-- Map Section -->
	<div id="map"></div>

	<!-- Footer -->
	<footer>
		<div class="container text-center">
			<p>Copyright &copy; Your Website 2014</p>
		</div>
	</footer>

	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.easing.1.3.js')}"></script>
	<script src="${resource(dir: 'assets/js', file: 'grayscale.js')}"></script>


	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'modernizr.custom.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'retina.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'smoothscroll.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery-func.js')}"></script>

</body>
</html>
