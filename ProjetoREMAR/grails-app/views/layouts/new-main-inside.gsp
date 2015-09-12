<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>REMAR</title>
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.png')}" type="image/x-icon">

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link href="${resource(dir: 'assets/css/inside-style', file: 'AdminLTE.css')}" rel="stylesheet">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="${resource(dir: 'assets/css/inside-style', file: 'skin-black-light.css')}" rel="stylesheet">
    <!-- iCheck -->
    <link href="${resource(dir: 'assets/css/inside-style', file: 'iCheck-styleBlue.css')}" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <g:layoutHead/>
</head>
<body class="hold-transition skin-black-light sidebar-mini">
    <!-- <body class="layout-top-nav"> -->
    <div class="wrapper">
        <header class="main-header">
            <a href="/dashboard" class="logo">
                <!-- mini logo for sidebar mini 50x50 pixels -->
                %{--<span class="logo-mini">ICON</span>--}%
                <!-- logo for regular state and mobile devices -->
                <span class="logo-lg">
                    <img src="/assets/img/logo/logo-remar-branco-transparente.png"
                         width="120" height="45" />
                </span>
            </a>

            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                </a>


                <div>
                    <sec class="nav navbar-nav">
                        <li><a href="/dashboard">Espaço do Usuário  <span class="sr-only">(current)</span></a></li>

                        <sec:ifAllGranted roles="ROLE_DEV">
                            <li><a href="/resource/index">Espaço do Desenvolvedor<span class="sr-only">(current)</span></a></li>
                        </sec:ifAllGranted>

                        <sec:ifNotGranted roles="ROLE_DEV">
                            <li><a href="/developer/new">Torne-se um Desenvolvedor<span class="sr-only">(current)</span></a></li>
                         </sec:ifNotGranted>
                    </sec>
                </div>


            <!-- Navbar Right Menu -->
                <div class="navbar-custom-menu" style="display: block">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        %{--<li class="dropdown messages-menu">--}%

                            %{--<a href="#" class="dropdown-toggle" data-toggle="dropdown">--}%
                                %{--<i class="fa fa-envelope-o"></i>--}%
                                %{--<span class="label label-success">0</span>--}%
                            %{--</a>--}%

                            %{--<ul class="dropdown-menu">--}%
                                %{--<li class="header">Você tem 1 menssagem</li>--}%
                                %{--<li>--}%
                                    %{--<!-- inner menu: contains the actual data -->--}%
                                    %{--<ul class="menu">--}%
                                        %{--<li><!-- start message -->--}%
                                            %{--<a href="#">--}%
                                                %{--<div class="pull-left">--}%
                                                    %{--<img src="/assets/img/inside/avatar.png" class="img-circle" alt="User Image">                                              </div>--}%
                                                %{--<h4>--}%
                                                    %{--Fulano--}%
                                                    %{--<small><i class="fa fa-clock-o"></i> 5 mins</small>--}%
                                                %{--</h4>--}%
                                                %{--<p>título</p>--}%
                                            %{--</a>--}%
                                        %{--</li><!-- end message -->--}%
                                    %{--...--}%
                                    %{--</ul>--}%
                                %{--</li>--}%
                                %{--<li class="footer"><a href="#">Ver todas mensagens</a></li>--}%
                            %{--</ul>--}%
                        %{--</li>--}%

                        %{--<!-- Tasks: style can be found in dropdown.less -->--}%
                        %{--<li class="dropdown tasks-menu">--}%
                            %{--<a href="#" class="dropdown-toggle" data-toggle="dropdown">--}%
                                %{--<i class="fa fa-flag-o"></i>--}%
                                %{--<span class="label label-danger">1</span>--}%
                            %{--</a>--}%
                            %{--<ul class="dropdown-menu">--}%
                                %{--<li class="header">Você tem tarefas pendentes</li>--}%
                                %{--<li>--}%
                                    %{--<!-- inner menu: contains the actual data -->--}%
                                    %{--<ul class="menu">--}%
                                        %{--<li><!-- Task item -->--}%
                                            %{--<a href="#">--}%
                                                %{--<h3>--}%
                                                    %{--implementar Escola Mágica--}%
                                                    %{--<small class="pull-right">20%</small>--}%
                                                %{--</h3>--}%
                                                %{--<div class="progress xs">--}%
                                                    %{--<div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">--}%
                                                        %{--<span class="sr-only">20% Complete</span>--}%
                                                    %{--</div>--}%
                                                %{--</div>--}%
                                            %{--</a>--}%
                                        %{--</li><!-- end task item -->--}%
                                    %{--...--}%
                                    %{--</ul>--}%
                                %{--</li>--}%
                                %{--<li class="footer">--}%
                                    %{--<a href="#">Ver todas as tarefas</a>--}%
                                %{--</li>--}%
                            %{--</ul>--}%
                        %{--</li>--}%
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <img class="user-image" alt="User Image" src="/assets/img/inside/avatar.png"/>
                                <span class="hidden-xs"><sec:username/></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header">
                                    <img src="/assets/img/inside/avatar.png" class="img-circle" alt="User Image">
                                    <p>
                                        <sec:username/>
                                        <small>Member since Sep. 2015</small>
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                %{--<li class="user-body">--}%
                                    %{--<div class="col-xs-4 text-center">--}%
                                        %{--<a href="#">Followers</a>--}%
                                    %{--</div>--}%
                                    %{--<div class="col-xs-4 text-center">--}%
                                        %{--<a href="#">Sales</a>--}%
                                    %{--</div>--}%
                                    %{--<div class="col-xs-4 text-center">--}%
                                        %{--<a href="#">Friends</a>--}%
                                    %{--</div>--}%
                                %{--</li>--}%
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="#" class="btn btn-default btn-flat">Perfil</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="/logout/index" class="btn btn-default btn-flat">Sair</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>

        <!-- Left side column. contains the logo and sidebar -->
        <aside class="main-sidebar">
            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar">
                <!-- Sidebar user panel -->
                <div class="user-panel">
                    <div class="pull-left image">
                        <img src="/assets/img/inside/avatar.png" class="img-circle" alt="User Image">
                    </div>
                    <div class="pull-left info">
                        <p><sec:username/></p>
                        <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                    </div>
                </div>
                <!-- search form -->
                <form action="#" method="get" class="sidebar-form">
                    <div class="input-group">
                        <input type="text" name="q" class="form-control" placeholder="Pesquisar...">
                        <span class="input-group-btn">
                            <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                </form>
                <!-- /.search form -->
                <!-- sidebar menu: : style can be found in sidebar.less -->
                <ul class="sidebar-menu">

                    <li class="header"><i class="glyphicon glyphicon-briefcase"></i>  Área de trabalho</li>

                    <li id="dashboard_page" class="treeview">
                        <a href="/dashboard">
                            <i class="fa fa-dashboard"></i> <span>Dashboard</span></i>
                        </a>
                    </li>
                    %{--<li id="reapersonalizavel_page" class="treeview">--}%
                        %{--<a href="/dashboard">--}%
                            %{--<i class="fa fa-edit"></i>--}%
                            %{--<span>R.E.A. personalizáveis </span>--}%
                            %{--<!-- <span class="label label-primary pull-right">4</span> -->--}%
                        %{--</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a  id="reapublicos_page" href="/dashboard">--}%
                            %{--<i class="fa fa-users"></i><span> R.E.A. públicos</span>--}%
                        %{--</a>--}%
                    %{--</li>--}%
                    <li id="meusrea_page" class="treeview">
                        <g:link controller="process" action="userProcesses">
                            <i class="fa fa-lock"></i>
                            <span>
                               Meus processos
                            </span>
                        </g:link>
                    </li>

                    <li id="tarefaspendentes_page" class="treeview">
                        %{--<a href="#">--}%
                         <g:link controller="process" action="pendingTasks" >
                            <i class="fa fa-list-alt"></i>
                            <span>Tarefas pendentes</span>
                         </g:link>
                        %{--</a>--}%
                    </li>
                </ul>
            </section>
            <!-- /.sidebar -->
        </aside>

        <div class="content-wrapper" style="min-height: 916px;">
            %{--<section class="content-header">--}%
                %{--<h1>Dashboard</h1>--}%
            %{--</section>--}%
            <artigle>
                <g:layoutBody/>
            </artigle>
        </div>

        <!-- jQuery 2.1.4 -->
        <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
        <!-- Bootstrap 3.3.5 -->
        <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
        <!-- AdminLTE App -->
        <script type="text/javascript" src="${resource(dir: 'assets/js/inside-scripts', file: 'app.js')}"></script>
        <!-- iCheck -->
        <script type="text/javascript" src="${resource(dir: 'assets/js/inside-scripts', file: 'icheck.js')}"></script>



        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>

    </div>

    </body>
</html>
