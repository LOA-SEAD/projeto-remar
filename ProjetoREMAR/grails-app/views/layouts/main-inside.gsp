<%--
  Created by IntelliJ IDEA.
  User: matheus
  Date: 7/5/15
  Time: 12:17 AM
--%>

<!DOCTYPE html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>REMAR</title>
        <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="/assets/css/custom.css">

        <link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
        <link href="http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
        <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">


        <!-- Bootstrap core CSS -->
        <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
        <link href="${resource(dir: 'assets/css', file: 'grayscale-menu.css')}" rel="stylesheet">
        <link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">
        <link href="${resource(dir: 'assets/css', file: 'custom.css')}" rel="stylesheet">
        <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>

        <g:layoutHead/>

    </head>
    <body>

    <div class="container-fluid">
        <div class="col-sm-3 col-md-2 sidebar">
         <h3><i class="glyphicon glyphicon-briefcase"></i> Workspace</h3>
            <ul class="nav nav-sidebar">
                <li> <g:link controller="process" action="pendingTasks" >
                    Tarefas Pendentes</g:link></li>
                <li> <g:link uri="http://myapp.dev:9090/dashboard" >Jogos Personalizáveis</g:link></li>
                <li> <g:link controller="process" action="userProcesses">
                    <i class="fa fa-list-alt"></i>
                    Meus Processos</g:link>
                </li>
            </ul>
        </div>
    </div>

    %{--<div id="wrapper" class="active">--}%

        %{--<div id="sidebar-wrapper">--}%
            %{--<ul id="sidebar_menu" class="sidebar-nav">--}%
                %{--<li class="sidebar-brand"><a id="menu-toggle" href="#">Workspace<span id="main_icon" class="glyphicon glyphicon-align-justify"></span></a></li>--}%
            %{--</ul>--}%
            %{--<ul class="sidebar-nav" id="sidebar">--}%
                %{--<li><a>REAs Personalizáveis<span class="sub_icon glyphicon glyphicon-link"></span></a></li>--}%
                %{--<li><a>Meus REAs<span class="sub_icon glyphicon glyphicon-link"></span></a></li>--}%
                %{--<li><a>REAs Publicos<span class="sub_icon glyphicon glyphicon-link"></span></a></li>--}%
                %{--<li><a>Tarefas Pendentes<span class="sub_icon glyphicon glyphicon-link"></span></a></li>--}%
            %{--</ul>--}%
        %{--</div>--}%

    %{--</div>--}%

    <div class="row">

        <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
            <div class="container-fluid">

                <div class="navbar-header">
                    <a class="navbar-brand page-scroll" href="#page-top">
                        <span class="icon-puzzle-2 light"></span>  REMAR
                    </a>
                </div>


                <div class="collapse navbar-collapse navbar-right navbar-main-collapse ">

                    <ul class="top-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
                            <ul class="dropdown-menu message-dropdown">
                                <li class="message-preview">
                                    <a href="#">
                                        <div class="media">
                                            <span class="pull-left">
                                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong>John Smith</strong>
                                                </h5>
                                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                                <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="message-preview">
                                    <a href="#">
                                        <div class="media">
                                            <span class="pull-left">
                                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong>John Smith</strong>
                                                </h5>
                                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                                <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="message-preview">
                                    <a href="#">
                                        <div class="media">
                                            <span class="pull-left">
                                                <img class="media-object" src="http://placehold.it/50x50" alt="">
                                            </span>
                                            <div class="media-body">
                                                <h5 class="media-heading"><strong>John Smith</strong>
                                                </h5>
                                                <p class="small text-muted"><i class="fa fa-clock-o"></i> Yesterday at 4:32 PM</p>
                                                <p>Lorem ipsum dolor sit amet, consectetur...</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li class="message-footer">
                                    <a href="#">Read All New Messages</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                            <ul class="dropdown-menu alert-dropdown">
                                <li>
                                    <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                                </li>
                                <li>
                                    <a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a>
                                </li>
                                <li>
                                    <a href="#">Alert Name <span class="label label-success">Alert Badge</span></a>
                                </li>
                                <li>
                                    <a href="#">Alert Name <span class="label label-info">Alert Badge</span></a>
                                </li>
                                <li>
                                    <a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a>
                                </li>
                                <li>
                                    <a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="#">View All</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> John Smith <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
                                </li>
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="#"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                                </li>
                            </ul>
                        </li>
                    </ul>



                    %{--<ul class="nav navbar-nav">--}%
                        %{--<li class="dropdown">--}%
                            %{--<a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">--}%
                                %{--<i class="glyphicon glyphicon-user"></i>  <span class="caret"></span></a>--}%
                            %{--<ul id="g-account-menu" class="dropdown-menu" role="menu">--}%
                                %{--<li class="dpd"><a class href="#">My Profile</a></li>--}%
                                %{--<li class="dpd"><a href="/logout/index"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>--}%
                            %{--</ul>--}%
                        %{--</li>--}%
                    %{--</ul>--}%
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div id="navbar-center" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/dashboard">Espaço do Usuário  <span class="sr-only">(current)</span></a></li>
                        <li><a href="/game/index">Espaço do Desenvolvedor<span class="sr-only">(current)</span></a></li>
                        <li><a href="#">Torne-se um Desenvolvedor<span class="sr-only">(current)</span></a></li>
                    </ul>
                </div>



            </div>
            <!-- /.container -->
        </nav>

        %{--<nav class="navbar navbar-inverse navbar-fixed-top">--}%
            %{--<div class="container-fluid">--}%
                %{--<div class="navbar-header">--}%
                    %{--<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">--}%
                        %{--<span class="sr-only">Toggle navigation</span>--}%
                        %{--<span class="icon-bar"></span>--}%
                        %{--<span class="icon-bar"></span>--}%
                        %{--<span class="icon-bar"></span>--}%
                    %{--</button>--}%
                    %{--<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">--}%
                        %{--<span class="icon-toggle"></span>--}%
                    %{--</button>--}%
                    %{--<a class="navbar-brand" href="#">Painel de Controle</a>--}%
                %{--</div>--}%

                %{--<ul class="nav navbar-nav">--}%
                    %{--<li><a href="/dashboard">Espaço do Usuário  <span class="sr-only">(current)</span></a></li>--}%
                    %{--<li><a href="/game/index">Espaço do Desenvolvedor<span class="sr-only">(current)</span></a></li>--}%
                    %{--<li><a href="#">Torne-se um Desenvolvedor no REMAR<span class="sr-only">(current)</span></a></li>--}%
                %{--</ul>--}%
                %{--<ul class="nav navbar-nav navbar-right">--}%
                    %{--<li class="dropdown">--}%
                        %{--<a class="dropdown-toggle" role="button" data-toggle="dropdown" href="#">--}%
                            %{--<i class="glyphicon glyphicon-user"></i>  <span class="caret"></span></a>--}%
                        %{--<ul id="g-account-menu" class="dropdown-menu" role="menu">--}%
                            %{--<li><a href="#">My Profile</a></li>--}%
                            %{--<li><a href="/logout/index"><i class="glyphicon glyphicon-lock"></i> Logout</a></li>--}%
                        %{--</ul>--}%
                    %{--</li>--}%
                %{--</ul>--}%
            %{--</div>--}%
        %{--</nav>--}%



        <g:layoutBody/>
    </div>
    </body>
</html>