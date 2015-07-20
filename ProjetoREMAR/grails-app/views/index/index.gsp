<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- <link rel="shortcut icon" href="assets/ico/favicon.png"> -->
	<link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>

	<title>REMAR</title>

	<!-- Bootstrap core CSS -->
	<link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
	<link href="${resource(dir: 'assets/css', file: 'addStyles.css')}" rel="stylesheet">

	<!-- Custom styles for this template -->
	<link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">
	<link href="${resource(dir: 'assets/css', file: 'animate-custom.css')}" rel="stylesheet">

	<link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Raleway:400,300,700' rel='stylesheet' type='text/css'>

	<script src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'modernizr.custom.js')}"></script>

</head>

<body data-spy="scroll" data-offset="0" data-target="#navbar-main">

	<div id="navbar-main" style="font-family: 'Ropa Sans', sans-serif; /*font-family: 'Sniglet', cursive;*/">
		<!-- Fixed navbar -->
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="icon icon-shield" style="font-size:30px; color:#3498db;"></span>
					</button>
					<a class="navbar-brand hidden-xs hidden-sm" href="#home"><!--<span class="icon icon-shield" style="font-size:18px; color:#3498db;"></span>--></a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						%{--<li><a href="#home" class="smoothScroll">Home</a></li>--}%
						<li><a href="#home" style="word-wrap: break-word;">Home</a> </li>
						<li> <a href="#about" class="smoothScroll">Sobre</a></li>
						<li> <a href="#services" class="smoothScroll">Servi&ccedil;os</a></li>
						<li> <a href="#team" class="smoothScroll">Equipe</a></li>
						<!--<li> <a href="#portfolio" class="smoothScroll"> Portfolio</a></li>
						<li> <a href="#blog" class="smoothScroll"> Blog</a></li> -->
						<li><a href="#contact" class="smoothScroll">Contato</a></li>
						%{--<li><a data-toggle="modal" href="/login">Login</a></li>--}%
                        <li><g:link controller="login">Login</g:link></li>
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</div>

	%{--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--}%
		%{--<div class="modal-dialog">--}%
			%{--<div class="modal-content">--}%
				%{--<div class="modal-header">--}%
					%{--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
					%{--<h4 class="modal-title">Sign in</h4>--}%
				%{--</div>--}%

				%{--<div class="modal-body">--}%
					%{--<form action='${postUrl}' method='POST' class="form-horizontal" role="form">--}%
						%{--<div class="form-group">--}%
							%{--<div class="col-lg-12">--}%
								%{--<input type="text" class="form-control" id="username" placeholder="Nome de usu&aacute;rio"  name="j_username" />--}%
							%{--</div>--}%
						%{--</div>--}%
						%{--<div class="form-group">--}%
							%{--<div class="col-lg-12">--}%
								%{--<input type="password" class="form-control" id="inputPassword" placeholder="Senha" name='j_password' />--}%
							%{--</div>--}%
						%{--</div>--}%
						%{--<div class="form-group">--}%
							%{--<div class="col-lg-12">--}%
								%{--<input type='submit' id="submit" class="btn btn-info btn-lg" value='${message(code: "springSecurity.login.button")}'/>--}%
								%{--<p class="col-lg-7" style="font-size: 12px"> N&atilde;o possui cadastro? <a href="#"> Inscreva-se j&aacute;</a>--}%
							%{--</div>--}%
						%{--</div>--}%
					%{--</form><!-- form -->--}%

				%{--</div>--}%

			%{--</div><!-- /.modal-content -->--}%
		%{--</div><!-- /.modal-dialog -->--}%
	%{--</div><!-- /.modal -->--}%

	%{--<!----}%
	%{--<p>--}%

        %{--<h1>LANDING PAGE</h1>--}%

        %{--<g:link class="btn btn-success" controller="user" action="create">Criar Nova Conta</g:link>--}%

        %{--<g:link class="btn btn-danger" mapping="resetPassword">Esqueci a Senha</g:link>--}%

		%{--<g:link mapping="dashboard" class="btn btn-success">Dashboard</g:link>--}%
    %{--</p>--}%
	%{---->--}%



	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'retina.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.easing.1.3.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'smoothscroll.js')}"></script>
	<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery-func.js')}"></script>


	</body>
</html>
