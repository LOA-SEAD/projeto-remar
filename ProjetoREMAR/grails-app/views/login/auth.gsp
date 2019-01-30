<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <title>REMAR – Login</title>
    <style>
        body {
            background-color: #F2F2F2;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="card white col s12 m6 l4 offset-m3 offset-l4 offset-vertical-2" style="margin-top: 30px;">
            <div class="card-content" style="padding: 20px !important;">
                <div class="card-image" style="padding-bottom: 20px;">
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
                        <div class="row no-margin-bottom">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">account_circle</i>
                                <input id="username" name="j_username" type="text">
                                <label for="username">Usuário</label>
                            </div> <!-- input-field -->
                        </div>
                        <div class="row no-margin-bottom">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">lock</i>
                                <input id="password" name="j_password" type="password">
                                <label for="password">Senha</label>
                            </div> <!-- input-field -->
                        </div>
                        <div class="row">
                            <div class="input-field center col s12">
                                <button type="submit" class="btn waves-effect waves-light my-orange">Entrar</button>
                            </div>
                        </div>
                        <g:if test="${grailsApplication.config.sp.url}">
                            <div class="row no-margin-bottom">
                                <div class="input-field center col s12">
                                    <a class="btn waves-effect waves-light my-orange" href="${grailsApplication.config.sp.url}">Entrar via CAFe</a>
                                </div>
                            </div>
                        </g:if>
                        <div class="row no-margin-bottom">
                            <div class="input-field col s6 m6 l6">
                                <g:link class="margin" mapping="resetPassword">Não consigo acessar!</g:link> <br>
                            </div>
                            <div class="input-field col s6 m6 l6 right-align">
                                <g:link mapping="signup">Cadastre-se</g:link>
                            </div>
                        </div> <!-- input field -->

                    </div> <!-- row -->
                </form>
            </div> <!-- card-content -->
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->
</body>
</html>
