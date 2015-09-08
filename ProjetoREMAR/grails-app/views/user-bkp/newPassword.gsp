<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Recuperar conta</title>

    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
</head>
<body>
<div class="container container-create">
    <header class="row logotipo" >
        <div class="logotipo" align="center" >
            <img  alt="logo remar" src="../assets/img/logo/logo-remar-v2.svg" height="50%" width="50%" />
        </div>
    </header>
    <article class="row">
        <div class="col-md-12">
            <section>
                <h3 class="title-style">Recuperar sua conta</h3>
                <div class="divider"></div>
            </section>
            <section>
                <h3 class="password-text-align">Senha alterada com sucesso!</h3>
                <span class="footer-span" id="link-password"><g:link class="footer-span" controller="index" action="index">Home</g:link></span>
            </section>
        </div>
    </article>
    <footer class="row">
        <div class="col-md-12">
        </div>
    </footer>
</div>
</body>
</html>

%{--<html>--}%
%{--<head>--}%
    %{--<meta name='layout' content='main'/>--}%
    %{--<title><g:message code="springSecurity.login.title"/></title>--}%

%{--</head>--}%

%{--<body>--}%
%{--<div class="page-header">--}%
    %{--<h1> Nova senha</h1>--}%
%{--</div>--}%
%{--<div class="main-content">--}%
    %{--<div class="widget">--}%
        %{--<h3 class="section-title first-title"><i class="icon-user"></i> Criação de Nova Senha</h3>--}%
        %{--<div class="widget-content-white glossed">--}%
            %{--<div class="padded">--}%
               %{--<h2 class="section-title ">Senha alterada com sucesso! </h2>--}%
                %{--<g:link class="btn btn-success" controller="index" action="index">Home</g:link>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

%{--<script type="text/javascript">--}%

    %{--$(function() {--}%
        %{--document.getElementById('menu-latera').style.display = "none";--}%
    %{--});--}%
%{--</script>--}%
%{--</body>--}%
%{--</html>--}%
