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
                    <h3 class="password-text-align">Um link para criar uma nova senha foi enviado para o email informado </h3>
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