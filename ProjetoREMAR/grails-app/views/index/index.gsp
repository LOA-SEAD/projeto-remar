<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 26/08/15
  Time: 13:32
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>REMAR</title>

    <!-- Bootstrap Core CSS -->
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
    %{--<link href="${resource(dir: 'assets/css', file: 'grayscale.css')}" rel="stylesheet">--}%
    %{--<link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">--}%

    <!-- Custom CSS -->
    %{--<link href="../assets/css/logo-nav.css" rel="stylesheet">--}%

    <!-- Bootstrap 3.3.5 -->
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

    <!-- jQuery -->
    <script src="../assets/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/jquery.easing.1.3.js"></script>
    %{--<script type="text/javascript" src="${resource(dir: 'assets/js', file: 'grayscale.js')}"></script>--}%

    <!-- Theme style -->
    <link href="${resource(dir: 'assets/css/inside-style', file: 'AdminLTE.css')}" rel="stylesheet">
    <link href="${resource(dir: 'assets/css/inside-style', file: 'skin-black-light.css')}" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

<![endif]-->
</head>
<body class="hold-transition skin-black-light sidebar-mini">

<div class="wrapper">
    <header class="main-header">

        <a href="/index" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            %{--<span class="logo-mini">ICON</span>--}%
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg">
                <img src="http://myapp.dev:9090/assets/img/logo/remar-logo-transparente.png"
                     width="120" height="45" />
            </span>
        </a>

        %{--<a class="logo">--}%
            %{--<g:link controller="index" action="index" class="logo">--}%
                %{--<span class="logo-lg">--}%
                    %{--<img src="http://myapp.dev:9090/assets/img/logo/remar-logo-letra.png"--}%
                         %{--width="90" height="20" />--}%
                %{--</span>--}%
            %{--</g:link>--}%
        %{--</a>--}%

        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">

            <!-- Navbar Right Menu -->
            <div class="navbar-custom-menu" style="display: block">
                <ul class="nav navbar-nav">

                    <li class="dropdown messages-menu">
                        <a class="page-scroll" href="/index">GT-REMAR</a>
                    </li>

                    <li class="dropdown tasks-menu">
                        <a class="page-scroll" href="/index/info">Mais Informações</a>
                    </li>

                    <li class="dropdown user user-menu">
                        %{--<g:link class="btn btn-primary btn-block btn-flat" controller="login">Entrar</g:link>--}%
                        <g:link class="page-scroll" controller="login">Entrar</g:link>
                    </li>
                </ul>
            </div>
        </nav>
    </header>

    <div class="content-index" >
        <artigle>
            <!-- Page Content -->
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div style="margin-bottom: 30px;">
                            <a href="http://www.loa.sead.ufscar.br/" target="_blank">
                                <img src="../images/logo/loa-topo.png"/>
                            </a>
                        </div>
                        <h1 class="text-center" style="font-weight: bold">REMAR</h1>
                        <p class="text-center">Recursos Educacionais Multiplataforma Abertos na Rede</p>
                        %{--<p>Note: You may need to adjust some CSS based on the size of your logo. The default logo size is 150x50 pixels.</p>--}%

                        <h3 id="gt-remar" style="text-align: left;">GT-REMAR</h3>
                        <p style="text-align: justify">
                            Este projeto encontra-se no contexto dos grupos de trabalho (GTs) Temáticos em EAD (sub-tema: Universidade Aberta OnLine) da RNP.
                            O GT-REMAR tem como objetivo facilitar e ampliar a construção e o reuso de recursos educacionais abertos (REA), por meio de um serviço,
                            na forma de uma plataforma web, que ofereça ferramentas que facilitem a construção e a customização de REA, seguindo diretrizes que favoreçam
                            o reuso, a disponibilização desses recursos em diferentes plataformas, bem como a integração com ambientes virtuais de aprendizagem. Espera-se obter
                            como resultados: (i) um conjunto de diretrizes para o desenvolvimento de REA reutilizáveis, adaptáveis, multiplataforma e acessíveis; (ii) um protótipo
                            da plataforma, que deverá ser testado e validado por meio do desenvolvimento e adaptação de REA pelo grupo proponente, em conjunto com instituições parceiras.
                        </p>

                        <h3 id="description" style="text-align: left;">Descrição</h3>
                        <p style="text-align: justify">
                            O acesso aberto a recursos educacionais é um requisito essencial
                            para a educação democrática, de qualidade, sustentável e aberta,
                            em qualquer modalidade (presencial, a distância, híbrida) e em
                            todos os níveis de formação. Além do acesso, o reuso de recursos
                            educacionais deve ser promovido, considerando que o desenvolvimento
                            desses recursos, em geral, é um processo bastante dispendioso e requer
                            um trabalho conjunto entre especialistas do conteúdo e uma equipe
                            multidisciplinar, sobretudo quando consideramos os recursos educacionais
                            interativos e que integram diferentes mídias e tecnologias. Dessa
                            forma, este projeto tem como intuito ampliar o acesso aos recursos
                            educacionais abertos, por meio de um serviço, na forma de uma plataforma
                            web, que ofereça ferramentas que facilitem a construção e customização
                            de REA seguindo diretrizes que favoreçam o reuso, bem como a
                            disponibilização desses recursos em diferentes plataformas e a
                            integração com ambientes virtuais de aprendizagem.
                        </p>
                    </div>
                </div>
            </div>
            <!-- /.container -->

            <footer>
                <div class="container text-center" style="margin-top: 250px;">
                    <p>Copyright &copy; Your Website 2014</p>
                </div>
            </footer>
        </artigle>
    </div>

</div>


%{--<!-- Navigation -->--}%
    %{--<nav class="navbar navbar-inverse navbar-fixed-top" style="position: absolute;" role="navigation">--}%
        %{--<div class="container">--}%


            %{--<!-- Brand and toggle get grouped for better mobile display -->--}%
            %{--<div class="navbar-header">--}%
                %{--<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">--}%
                    %{--<span class="sr-only">Toggle navigation</span>--}%
                    %{--<span class="icon-bar"></span>--}%
                    %{--<span class="icon-bar"></span>--}%
                    %{--<span class="icon-bar"></span>--}%
                %{--</button>--}%
                %{--<a class="navbar-brand" href="#">--}%
                    %{--<img src="http://placehold.it/150x50&text=Logo" alt="">--}%
                %{--</a>--}%
            %{--</div>--}%
            %{--<!-- Collect the nav links, forms, and other content for toggling -->--}%
            %{--<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="float: right;">--}%
                %{--<ul class="nav navbar-nav">--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="/index">GT-REMAR</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#description">Descrição</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="/index/info">Mais Informações</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#team">Equipe</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#partners">Parceiros</a>--}%
                    %{--</li>--}%
                    %{--<li>--}%
                        %{--<a class="page-scroll" href="#contact">Contato</a>--}%
                    %{--</li>--}%
                    %{--<li id="login">--}%
                    %{--<li >--}%
                        %{--<g:link class="btn-login link-center" controller="login">Entrar</g:link>--}%
                        %{--<g:link class="btn btn-primary btn-block btn-flat" controller="login">Entrar</g:link>--}%
                    %{--</li>--}%
                %{--</ul>--}%
            %{--</div>--}%
            %{--<!-- /.navbar-collapse -->--}%
        %{--</div>--}%
        %{--<!-- /.container -->--}%
    %{--</nav>--}%



</body>
</html>
