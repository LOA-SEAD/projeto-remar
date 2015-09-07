<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    %{--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--}%
    %{--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">--}%
    %{----}%
    %{--<title>REMAR</title>--}%
    %{--<meta name="viewport" content="width=device-width, initial-scale=1.0">--}%
    %{--<link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">--}%

    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'fullcalendar.css')}"	type="text/css">--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css/datatables', file: 'datatables.css')}"	type="text/css">--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css/datatables', file: 'bootstrap.datatables.css')}"	type="text/css">--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'scss', file: 'chosen.css')}"	type="text/css">--}%
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'app.css')}"	type="text/css">--}%

    %{--<link href='http://fonts.googleapis.com/css?family=Oswald:300,400,700|Open+Sans:400,700,300' rel='stylesheet' type='text/css'>--}%
    %{--<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">--}%

    %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>--}%
    %{--<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>--}%


    %{--<script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'tab.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'dropdown.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'collapse.js')}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir: 'js/bootstrap', file: 'transition.js')}"></script>--}%
    <html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <title><g:layoutTitle /></title>
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">

    <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel='stylesheet'>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" ></script>

    <link href="${resource(dir: 'assets/js', file: 'jquery.min.js')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet" >

    <g:layoutHead/>
    <fbg:resources/>
    <script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body>
    %{--<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">--}%
        %{--<div class="container">--}%
            %{--<div class="navbar-header">--}%
                %{--<a class="navbar-brand page-scroll navbar-custom-white" href="#page-top">--}%
                    %{--<span class="icon-puzzle-2 light navbar-custom-white"></span>REMAR--}%
                %{--</a>--}%
            %{--</div>--}%

            %{--<!-- Collect the nav links, forms, and other content for toggling -->--}%
            %{--<div class="collapse navbar-collapse navbar-right navbar-main-collapse">--}%
                %{--<ul class="nav navbar-nav">--}%
                    %{--<!-- Hidden li included to remove active class from about link when scrolled up past about section -->--}%
                    %{--<li class="hidden">--}%
                        %{--<a href="#page-top"></a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#about">Sobre</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#team">Equipe</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#contact">Contato</a>--}%
                    %{--</li>--}%
                    %{--<li id="navbar-custom-green">--}%
                    %{--</li>--}%
                %{--</ul>--}%
                %{--<g:link  class="btn btn-default btn-login" controller="login">Entrar</g:link>--}%
            %{--</div>--}%
            %{--<!-- /.navbar-collapse -->--}%
        %{--</div>--}%
        %{--<!-- /.container -->--}%
    %{--</nav>--}%

    <g:layoutBody/>

</body>
</html>
