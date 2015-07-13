<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 01/07/15
  Time: 09:10
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="SHIELD - Free Bootstrap 3 Theme">
    <meta name="author" content="Carlos Alvarez - Alvarez.is - blacktie.co">
   <!-- <link rel="shortcut icon" href="assets/ico/favicon.png"> -->
    <link href='http://fonts.googleapis.com/css?family=Sniglet' rel='stylesheet' type='text/css'>

    <title>REMAR</title>

    <!-- Bootstrap core CSS -->
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${resource(dir: 'assets/css', file: 'addStyles.css')}" rel="stylesheet">
    <link href="${resource(dir: 'assets/css', file: 'icomoon.css')}"  rel="stylesheet">
    <link href="${resource(dir: 'assets/css', file: 'animate-custom.css')}" rel="stylesheet">



    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway:400,300,700' rel='stylesheet' type='text/css'>

    <script src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'assets/js', file: 'modernizr.custom.js')}"></script>

    <g:layoutHead />

</head>

<body data-spy="scroll" data-offset="0" data-target="#navbar-main">


    <div id="navbar-main" style="font-family: 'Sniglet', cursive;">
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
                        <li><a href="#home" class="smoothScroll">Home</a></li>
                        <li> <a href="#about" class="smoothScroll">Sobre</a></li>
                        <li> <a href="#services" class="smoothScroll">Servi&ccedil;os</a></li>
                        <li> <a href="#team" class="smoothScroll">Equipe</a></li>
                        <!--<li> <a href="#portfolio" class="smoothScroll"> Portfolio</a></li>
                    <li> <a href="#blog" class="smoothScroll"> Blog</a></li> -->
                        <li><a href="#contact" class="smoothScroll">Contato</a></li>
                        <li><a data-toggle="modal" href="#myModal">Login</a></li>
                </div><!--/.nav-collapse -->
            </div>
        </div>
    </div>

    <!-- MODAL SHOW THE PORTFOLIO IMAGE. In this demo, all links point to this modal. You should create
             a modal for each of your projects. -->

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Sign in</h4>
                </div>

                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="col-lg-12">
                                <input type="email" class="form-control" id="inputEmail1" placeholder="Nome de usu&aacute;rio">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <input type="password" class="form-control" id="inputPassword" placeholder="Senha">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <button type="submit" class="btn btn-success col-lg-5">Entrar</button>
                                <p class="col-lg-7" style="font-size: 12px"> N&atilde;o possui cadastro? <a href="#"> Inscreva-se j&aacute;</a>
                            </div>
                        </div>
                    </form><!-- form -->

                </div>

            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <g:layoutBody/>

</body>
</html>