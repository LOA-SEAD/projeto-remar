<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="new-main-external">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Recuperar conta</title>

    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
</head>
<body>
<div class="row">
        <div class="col-md-12">
            <section>
                <h3 class="title-style">Recuperar sua conta</h3>
            </section>
            <section>
                <p class="password-text-align">Senha alterada com sucesso!</p>
                <span class="footer-span" id="link-password"><g:link class="footer-span" controller="index" action="index">Home</g:link></span>
            </section>
        </div>
</div>
</body>
</html>
