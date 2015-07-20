<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Entrar</title>
    <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel='stylesheet'>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" ></script>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">


    <link href="${resource(dir: 'assets/css', file: 'jquery.min.js')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap-social.css')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
    <script type="text/javascript">
        window.fbAsyncInit = function() {
            FB.init({
                appId      : '1621035434837394',
                xfbml      : true,
                version    : 'v2.4'
            });
        };

        function facebookLogin() {
            FB.getLoginStatus(function(response) {
                if (response.status === 'connected') {
                    console.log("Conectado");
                    // logged in and connected user, someone you know
                    window.location ="${createLink(controller:'facebook', action:'auth')}";
                }
                else{
                    console.log("nao conectado");
                }
            });
        }
    </script>
    <fbg:resources />
    <script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body>
    <div class="container">
        <header class="row">
            <div class="col-md-12">
                <h1 class="text-center">REMAR</h1>
            </div>
        </header>
        <article class="row">
            <div class="col-md-12">
                <sec:ifAllGranted roles="ROLE_USER,ROLE_FACEBOOK">
                    <meta name="layout" content="main">
                </sec:ifAllGranted>
                <sec:ifNotGranted roles="ROLE_ADMIN,ROLE_USER_ROLE_FACEBOOK">

                </sec:ifNotGranted>
                <fb:login-button perms="email,public_profile" scope="public_profile,email,publish_actions,user_about_me" onlogin="facebookLogin();" size="large">
                    <g:message  code="Login por Facebook"/>
                </fb:login-button>
                <form action='/j_spring_security_check' method='POST' class="form center-block login" >
                    %{--<sec:ifNotGranted roles="ROLE_USER">--}%
                        %{--<facebookAuth:connect />--}%
                    %{--</sec:ifNotGranted>--}%
                    %{--<sec:ifAllGranted roles="ROLE_USER">--}%
                        %{--Welcome <sec:username/>! (<g:link uri="/j_spring_security_logout">Logout</g:link>)--}%
                    %{--</sec:ifAllGranted>--}%
                    <g:if test='${flash.message}'>
                        <div class="">${flash.message}</div>
                    </g:if>

                    <div class="divider">
                        <strong class="">ou</strong>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control input-lg" placeholder="Nome de usu&aacute;rio" name='j_username'>
                        <span class="icon"><i class="fa fa-user"></i></span>

                        <input type="password" class="form-control input-lg" placeholder="Senha" name='j_password'>
                        <span class="icon"><i class="fa fa-lock"></i></span>
                    </div>
                    <div class="form-group clearfix">
                        <div class="ck-style">
                            <input type="checkbox" name="remember">
                            <span class="footer-span">Lembre-me</span>
                        </div>
                        <div>

                            <div class="g-recaptcha" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"></div>

                        <recaptcha:script/>
                        </div>
                        <button class="btn btn-primary btn-block btn-login" >Entrar</button>
                    </div>


                </form>
            </div>
        </article>
        <footer class="row">
            <div class="col-md-12">
                <span class="footer-span"><g:link class="footer-span" mapping="resetPassword">Esqueci a Senha!</g:link></span> <br>
                <span class="footer-span">Ainda n&atilde;o est&aacute; cadastrado? <g:link class="footer-span" controller="user" action="create" >Registre-se</g:link> </span>
            </div>
        </footer>
    </div>
</body>
</html>