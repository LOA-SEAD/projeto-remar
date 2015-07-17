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

    <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel='stylesheet'>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" ></script>

    <link href="${resource(dir: 'assets/css', file: 'jquery.min.js')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet" >

    <g:layoutHead/>
    <fbg:resources/>
</head>
<body>
    <g:layoutBody/>

    %{--<div class="all-wrapper">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-3" id="menu-latera">--}%
                %{--<div class="text-center">--}%
                    %{--<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">--}%
                        %{--<span class="sr-only">Toggle navigation</span>--}%
                        %{--<span class="icon-bar"></span>--}%
                        %{--<span class="icon-bar"></span>--}%
                        %{--<span class="icon-bar"></span>--}%
                    %{--</button>--}%
                %{--</div>--}%
                %{--<div class="side-bar-wrapper collapse navbar-collapse navbar-ex1-collapse">--}%
                    %{--<a href="#" class="logo hidden-sm hidden-xs">--}%
                        %{--<i class="icon-cog"></i>--}%
                        %{--<span>Sistema Administrativo<br />REMAR</span>--}%
                    %{--</a>--}%
                    <div class="relative-w">
                        <ul class="side-menu">
                            <li><a href="/" class="dropdown-toggle">Lista de Jogos</a></li>

                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <li><a href="/user" class="dropdown-toggle">Lista de Usuários</a></li>
                                <li><a href="/user/create" class="dropdown-toggle">Criar novo Usuário</a></li>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_PROF">
                                <!--<li><a href="/processoJogo/jogos">Lista de Jogos Personalizaveis</a></li>-->
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_STUD">
                                <!--<li class="dropdown-toggle"><a href="#">Estudante</a></li>-->
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_EDITOR">
                                <!--<li class="dropdown-toggle"><a href="#">Editor</a></li>-->
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_DESENVOLVEDOR">
                                <!--<li class="dropdown-toggle"><a href="#">Desenvolvedor</a></li>-->
                            </sec:ifAllGranted>

                            <li class="dropdown-toggle"><a href="/logout">Sair<!-- (<sec:loggedInUserInfo field="username"/>)--></a></li>
                            %{--</ul>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</div>--}%
                %{--<div class="col-md-9">--}%

                %{--<div class="content-wrapper wood-wrapper">--}%
                    %{--<div class="main-content">--}%
                        %{--<g:layoutBody/>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%

</body>
</html>
