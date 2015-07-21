<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Cadastro REMAR</title>

    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
</head>
<body>
    <div class="container container-create">
        <header class="row">
            <div class="col-md-12">
                <h1>logo</h1>
            </div>
        </header>
        <article class="row">
            <div class="col-md-12">
                <section>
                    <h3 class="title-style">Recuperar sua conta</h3>
                    <div class="divider"></div>
                </section>
                <section>
                    <g:if test='${flash.message}'>
                        <div class='login_message'>${flash.message}</div>
                    </g:if>
                    <g:form action="confirmEmail" controller="user" method='POST' class='cssform' autocomplete='off'>
                        <div class="form-group">
                            <label class="label-form" for="firstName">
                                <g:message code="user.email.label" default="Digite o email cadastrado: " />
                            </label>
                            <input type="text" class="form-control" name="email" id="email" placeholder="nome@exemplo.com" required=""/>
                        </div>
                        <div class="form-group captcha">
                            <div class="g-recaptcha" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"></div>
                            <recaptcha:script/>
                        </div>
                        <div class="form-group">
                            <input type='submit' id="submit" class="btn btn-primary btn-block btn-create" value="Enviar"/>
                        </div>
                    </g:form>
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
    %{--<h1> Página de Login</h1>--}%
%{--</div>--}%
%{--<div class="main-content">--}%
    %{--<div class="widget">--}%
        %{--<h3 class="section-title first-title"><i class="icon-user"></i> Confirme o email</h3>--}%
        %{--<div class="widget-content-white glossed">--}%
            %{--<div class="padded">--}%

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
