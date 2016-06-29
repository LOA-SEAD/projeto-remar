<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>REMAR</title>
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

    %{--<!-- iCheck -->--}%
    %{--<link rel="stylesheet" href="plugins/iCheck/flat/blue.css">--}%
    %{--<!-- Morris chart -->--}%
    %{--<link rel="stylesheet" href="plugins/morris/morris.css">--}%
    %{--<!-- jvectormap -->--}%
    %{--<link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">--}%
    %{--<!-- Date Picker -->--}%
    %{--<link rel="stylesheet" href="plugins/datepicker/datepicker3.css">--}%
    %{--<!-- Daterange picker -->--}%
    %{--<link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css">--}%
    %{--<!-- bootstrap wysihtml5 - text editor -->--}%
    %{--<link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">--}%

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
            <a href="" class="logo">
                <!-- mini logo for sidebar mini 50x50 pixels -->
                <span class="logo-mini">ICON</span>
                <!-- logo for regular state and mobile devices -->
                <span class="logo-lg"><b>REMAR</b></span>
            </a>

            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                </a>


                <div>
                    <ul class="nav navbar-nav">
                        <li><a href="/dashboard">Espaço do Usuário  <span class="sr-only">(current)</span></a></li>
                        <li><a href="/resource/index">Espaço do Desenvolvedor<span class="sr-only">(current)</span></a></li>
                        <li><a href="#">Torne-se um Desenvolvedor<span class="sr-only">(current)</span></a></li>
                    </ul>
                </div>


            <!-- Navbar Right Menu -->
                <div class="navbar-custom-menu" style="display: block">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        <li class="dropdown messages-menu">

                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-envelope-o"></i>
                                <span class="label label-success">0</span>
                            </a>

                            <ul class="dropdown-menu">
                                <li class="header">Você tem 1 menssagem</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li><!-- start message -->
                                            <a href="#">
                                                <div class="pull-left">
                                                    <img src="http://myapp.dev:9090/assets/img/inside/avatar.png" class="img-circle" alt="User Image">                                              </div>
                                                <h4>
                                                    Fulano
                                                    <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                                </h4>
                                                <p>título</p>
                                            </a>
                                        </li><!-- end message -->
                                    ...
                                    </ul>
                                </li>
                                <li class="footer"><a href="#">Ver todas mensagens</a></li>
                            </ul>
                        </li>

                        <!-- Tasks: style can be found in dropdown.less -->
                        <li class="dropdown tasks-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-flag-o"></i>
                                <span class="label label-danger">1</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">Você tem tarefas pendentes</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li><!-- Task item -->
                                            <a href="#">
                                                <h3>
                                                    implementar Escola Mágica
                                                    <small class="pull-right">20%</small>
                                                </h3>
                                                <div class="progress xs">
                                                    <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">20% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                    ...
                                    </ul>
                                </li>
                                <li class="footer">
                                    <a href="#">Ver todas as tarefas</a>
                                </li>
                            </ul>
                        </li>
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <img class="user-image" alt="User Image" src="http://myapp.dev:9090/assets/img/inside/avatar.png"/>
                                <span class="hidden-xs">${userName}</span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header">
                                    <img src="http://myapp.dev:9090/assets/img/inside/avatar.png" class="img-circle" alt="User Image">
                                    <p>
                                        ${userName}
                                        <small>Member since Nov. 2012</small>
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
                        <img src="http://myapp.dev:9090/assets/img/inside/avatar.png" class="img-circle" alt="User Image">
                    </div>
                    <div class="pull-left info">
                        <p>${userName}</p>
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
                        <a href="http://myapp.dev:9090/dashboard">
                            <i class="fa fa-dashboard"></i> <span>Dashboard</span></i>
                        </a>
                    </li>
                    <li id="reapersonalizavel_page" class="treeview">
                        <a href="http://myapp.dev:9090/dashboard">
                            <i class="fa fa-edit"></i>
                            <span>R.E.A. personalizáveis </span> <small class="label pull-right bg-green">new</small>
                            <!-- <span class="label label-primary pull-right">4</span> -->
                        </a>
                    </li>
                    <li>
                        <a  id="reapublicos_page" href="http://myapp.dev:9090/dashboard">
                            <i class="fa fa-users"></i><span> R.E.A. públicos</span>
                        </a>
                    </li>
                    <li id="meusrea_page" class="treeview">
                        <g:link controller="process" action="userProcesses">
                            <i class="fa fa-lock"></i>
                            <span>
                               Meus R.E.A.
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

                    <!--  <li class="treeview">
                  <a href="#">
                    <i class="fa fa-folder"></i> <span>Examples</span>
                    <i class="fa fa-angle-left pull-right"></i>
                  </a>
                  <ul class="treeview-menu">
                    <li><a href="pages/examples/invoice.html"><i class="fa fa-circle-o"></i> Invoice</a></li>
                    <li><a href="pages/examples/profile.html"><i class="fa fa-circle-o"></i> Profile</a></li>
                    <li><a href="pages/examples/login.html"><i class="fa fa-circle-o"></i> Login</a></li>
                    <li><a href="pages/examples/register.html"><i class="fa fa-circle-o"></i> Register</a></li>
                    <li><a href="pages/examples/lockscreen.html"><i class="fa fa-circle-o"></i> Lockscreen</a></li>
                    <li><a href="pages/examples/404.html"><i class="fa fa-circle-o"></i> 404 Error</a></li>
                    <li><a href="pages/examples/500.html"><i class="fa fa-circle-o"></i> 500 Error</a></li>
                    <li><a href="pages/examples/blank.html"><i class="fa fa-circle-o"></i> Blank Page</a></li>
                  </ul>
                </li> -->

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
        <!-- Bootstrap 3.3.5 -->
        <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
        <!-- AdminLTE App -->
        <script type="text/javascript" src="${resource(dir: 'assets/js/inside-scripts', file: 'app.js')}"></script>

        %{--<script src="dist/js/app.min.js"></script>--}%
        %{--<!-- FastClick -->--}%
        %{--<script src="plugins/fastclick/fastclick.min.js"></script>       --}%
        %{--<!-- Sparkline -->--}%
        %{--<script src="plugins/sparkline/jquery.sparkline.min.js"></script>--}%
        %{--<!-- jvectormap -->--}%
        %{--<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>--}%
        %{--<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>--}%
        %{--<!-- SlimScroll 1.3.0 -->--}%
        %{--<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>--}%
        %{--<!-- ChartJS 1.0.1 -->--}%
        %{--<script src="plugins/chartjs/Chart.min.js"></script>--}%
        %{--<!-- AdminLTE dashboard demo (This is only for demo purposes) -->--}%
        %{--<script src="dist/js/pages/dashboard2.js"></script>--}%
        %{--<!-- AdminLTE for demo purposes -->--}%
        %{--<script src="dist/js/demo.js"></script>--}%

    </body>
</html>
