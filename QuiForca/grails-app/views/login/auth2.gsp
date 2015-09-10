
<%--
Created by IntelliJ IDEA.
User: lucasbocanegra
Date: 09/09/15
Time: 10:57
--%>
<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Entrar</title>
    <link rel="shortcut icon" href="${resource(dir: 'assets/img/logo', file: 'icone-remar_v2.ico')}" type="image/x-icon">
    <link href='http://fonts.googleapis.com/css?family=Ropa+Sans' rel='stylesheet'>
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel='stylesheet'>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js" ></script>

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

    <link href="${resource(dir: 'assets/css', file: 'bootstrap.css')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'bootstrap-social.css')}" rel="stylesheet" >
    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >

    <g:javascript src="../assets/js/jquery.min.js" />
    <g:javascript src="../assets/js/jquery.validate.js" />

    <script type="text/javascript">
        window.fbAsyncInit = function() {
            FB.init({
                appId      : '1621035434837394',
                xfbml      : true,
                version    : 'v2.4'
            });
        };

        (function(d, s, id){
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {return;}
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

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

    <script>
        $(function() {
            $('form').validate({
                rules: {
                    j_username: {
                        minlength: 2,
                        required: true
                    },
                    j_password: {
                        minlength: 5,
                        required: true
                    }
                },
                messages:{
                    j_username: {
                        required: "Por favor digite seu nome de usuario",
                        minlength: "Seu username deve ter no minimo 2 caracteres"
                    },
                    j_password: {
                        required: "Por favor digite sua senha",
                        minlength: "Sua senha deve ter no minimo 5 caracteres"
                    }
                },
                highlight: function(element) {
                    $(element).closest('.form-group').addClass('has-error');
                },
                unhighlight: function(element) {
                    $(element).closest('.form-group').removeClass('has-error');
                },
                errorElement: 'span',
                errorClass: 'help-block',
                errorPlacement: function(error, element) {
                    error.insertAfter(element.parent());
                }
            });
        });

    </script>

    <fbg:resources />

</head>
<body>
<facebook:initJS appId="${facebookContext.app.id}" />
<div class="container">
    <header class="row">
        <header class="row logotipo" >
            <div class="logotipo" align="center" >
                <img  alt="logo remar" src="../assets/img/logo/logo-remar-v2.svg" height="100%" width="100%" />
            </div>
        </header>
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
            <form action='${postUrl}' method='POST' class="form center-block login" >

                <div class="divider">
                    <strong class="">ou</strong>
                </div>
                <div class="form-group">
                    <div id="input-username" class="">
                        <input type="text" class="form-control input-lg" placeholder="Nome de usu&aacute;rio" name='j_username'>
                        <span class="icon"><i class="fa fa-user"></i></span>
                    </div>
                </div>
                <div class="form-group">
                    <div id="input-password" class="">
                        <input type="password" class="form-control input-lg" placeholder="Senha" name='j_password'>
                        <span class="icon"><i class="fa fa-lock"></i></span>
                    </div>
                </div>
                <div class="form-group clearfix">
                    <div class="ck-style">
                        <input type="checkbox" name="${rememberMeParameter}" checked='checked'>
                        <span class="footer-span">Lembre-me</span>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block btn-login" >Entrar</button>
                </div>
                <div class="form-group">

                    <div id="aux"></div>
                    <g:if test='${flash.message}'>
                        <script>
                            $('.form-group').addClass('has-error');

                            $('#input-username').append($("<div/>")
                                    .addClass("help-block")
                                    .text("Usuário e senha não coincidem"));

                            $('#input-password').append($("<div/>")
                                    .addClass("help-block")
                                    .text("Usuário e senha não coincidem"));

                            $("input").focus(function(){
                                $('.form-group').removeClass('has-error');
                                $('.help-block').remove();
                                $('input').off("focus");
                            });
                        </script>
                    </g:if>
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