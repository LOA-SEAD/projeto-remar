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
                <h3 class="">Crie um cadastro</h3>
            </section>
            <section>
                <g:if test='${flash.message}'>
                    <div class='login_message'>${flash.message}</div>
                </g:if>

                <g:form action="newPassword" controller="user" method='POST' class='cssform' autocomplete='off'>
                    <div class="form-group">
                        <label for="newPassword">Nova senha:</label>
                        <input type="password" class="form-control input-form" name="newPassword" id="newPassword" required=""/>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirme Nova Senha:</label>
                        <input type="password" class="form-control input-form" name="confirmPassword" id="confirmPassword" required=""/>
                    </div>
                    <input type="hidden" name="userid" value="${user}" />
                    <div>
                        <p>
                            <input type='submit' id="submit" class="btn btn-primary btn-block btn-create" value="Enviar"/>
                            %{--value='${message(code: "springSecurity.login.button")}--}%
                        </p>
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
    %{--<h1> Nova senha</h1>--}%
%{--</div>--}%
%{--<div class="main-content">--}%
    %{--<div class="widget">--}%
        %{--<h3 class="section-title first-title"><i class="icon-user"></i> Criação de Nova Senha</h3>--}%
        %{--<div class="widget-content-white glossed">--}%
            %{--<div class="padded">--}%
                %{--<g:if test='${flash.message}'>--}%
                    %{--<div class='login_message'>${flash.message}</div>--}%
                %{--</g:if>--}%
                %{--<g:form action="newPassword" controller="user" method='POST' class='cssform' autocomplete='off'>--}%
                    %{--<div class="form-group">--}%
                        %{--<label for="newPassword">Nova senha:</label>--}%
                        %{--<input type="password" class="form-control" name="newPassword" id="newPassword" required=""/>--}%
                    %{--</div>--}%
                    %{--<div class="form-group">--}%
                        %{--<label for="confirmPassword">Confirme Nova Senha:</label>--}%
                        %{--<input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required=""/>--}%
                    %{--</div>--}%
                        %{--<input type="hidden" name="userid" value="${user}" />--}%
                    %{--<div>--}%
                        %{--<p>--}%
                            %{--<input type='submit' id="submit" class="btn btn-info btn-lg" value="Enviar"/>--}%
                            %{--value='${message(code: "springSecurity.login.button")}--}%
                        %{--</p>--}%
                    %{--</div>--}%
                %{--</g:form>--}%
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
