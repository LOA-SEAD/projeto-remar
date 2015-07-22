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
                    <h3 class="title-style">Seja bem-vindo!</h3>
                    <div class="divider"></div>
                </section>
                <section>
                    <h3 class="password-text-align">Cadastro liberado com sucesso!</h3>
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