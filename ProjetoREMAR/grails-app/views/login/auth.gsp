<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <title>REMAR – Login</title>
</head>
<body>
<div class="external-container">
    <div class="row">
        <div class="card white z-depth-4 col s12 m6 l4 offset-m3 offset-l4 offset-vertical-15">
            <div class="card-content">
                <div class="card-image">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <form action="/j_spring_security_check" method="POST">
                    <g:if test="${flash.message}">
                    <div class="input-field" id="input-login-error">
                        <i class="material-icons small red-text">error</i><span class="align-with-icon-small red-text">
                        Usuário ou senha inválidos</span>
                        <div class="divider"></div>
                    </div>
                    </g:if>
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">account_circle</i>
                            <input id="username" name="j_username" type="text">
                            <label for="username">Usuário</label>
                        </div> <!-- input-field -->

                        <div class="input-field col s12">
                            <i class="material-icons prefix">lock</i>
                            <input id="password" name="j_password" type="password">
                            <label for="password">Senha</label>
                        </div> <!-- input-field -->
                        <div class="input-field center col s12">
                            <button type="submit" class="btn waves-effect waves-light">Entrar</button>
                        </div>
                        <div class="input-field center col s12">
                            <g:link class="margin" mapping="resetPassword">Esqueceu sua senha?</g:link><br>
                            <g:link mapping="signup">Cadastre-se</g:link>
                        </div> <!-- input field -->
                    </div> <!-- row -->
                </form>
            </div> <!-- card-content -->
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->
</body>
</html>