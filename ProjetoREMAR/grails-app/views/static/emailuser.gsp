<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="new-main-external">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Cadastro REMAR</title>

    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
</head>
<body>
    <div class="row">
        %{--<header class="row logotipo" >--}%
            %{--<div class="logotipo" align="center" >--}%
                %{--<img  alt="logo remar" src="../assets/img/logo/logo-remar-v2.svg" height="50%" width="50%" />--}%
            %{--</div>--}%
        %{--</header>--}%
        <article class="row">
            <div class="col-md-12">
                <section>
                    <h3 class="title-style">Seja bem-vindo!</h3>
                </section>
                <section>
                    <h3 class="password-text-align">Cadastro liberado com sucesso!</h3>
                    <span class="footer-span" id="link-password"><g:link class="footer-span" controller="index" action="index">Home</g:link></span>
                </section>
            </div>
        </article>
    </div>
</body>
</html>