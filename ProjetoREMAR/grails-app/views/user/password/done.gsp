<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>REMAR</title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="card white z-depth-2 col s12 m6 l4 offset-m2 offset-l4">
            <div class="card-content" style="padding: 20px !important;">
                <div class="card-image" style="padding-bottom: 20px;">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <div class="center">
                    <span class="card-title black-text">Senha alterada com sucesso :)</span>
                </div>
            </div> <!-- card-content -->
            <div class="card-action">
                <a href="/login">login</a>
            </div>
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->
</body>
</html>