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
                    <p class="title-style">Recuperar sua conta</p>
                </section>
                <section>
                    <p class="password-text-align">Um link para criar uma nova senha foi enviado para o email informado </p>
                    <span class="footer-span" id="link-password"><g:link class="footer-span" controller="index" action="index">Home</g:link></span>
                </section>
            </div>

    </div>
</body>
</html>