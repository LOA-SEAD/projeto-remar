<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta name="layout" content="new-main-external">
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Entrar</title>
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">


    %{--<link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >--}%

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

    %{--<script>--}%
        %{--$(function() {--}%
            %{--$('form').validate({--}%
                %{--rules: {--}%
                    %{--j_username: {--}%
                        %{--minlength: 2,--}%
                        %{--required: true--}%
                    %{--},--}%
                    %{--j_password: {--}%
                        %{--minlength: 5,--}%
                        %{--required: true--}%
                    %{--}--}%
                %{--},--}%
                %{--messages:{--}%
                    %{--j_username: {--}%
                        %{--required: "Por favor digite seu nome de usuario",--}%
                        %{--minlength: "Seu username deve ter no minimo 2 caracteres"--}%
                    %{--},--}%
                    %{--j_password: {--}%
                        %{--required: "Por favor digite sua senha",--}%
                        %{--minlength: "Sua senha deve ter no minimo 5 caracteres"--}%
                    %{--}--}%
                %{--},--}%
                %{--highlight: function(element) {--}%
                    %{--$(element).closest('.form-group').addClass('has-error');--}%
                %{--},--}%
                %{--unhighlight: function(element) {--}%
                    %{--$(element).closest('.form-group').removeClass('has-error');--}%
                %{--},--}%
                %{--errorElement: 'span',--}%
                %{--errorClass: 'help-block',--}%
                %{--errorPlacement: function(error, element) {--}%
                    %{--error.insertAfter(element.parent());--}%
                %{--}--}%
            %{--});--}%
        %{--});--}%

    %{--</script>--}%

    <fbg:resources />

</head>
<body>
    <form action='/j_spring_security_check' method='POST'>
        <div class="form-group has-feedback">
            %{--<div id="input-username" class="">--}%
            <input type="text" class="form-control-remar" placeholder="Nome de usuário" name='j_username' >
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
            %{--<label class="control-label" for="emailError"><i class="fa fa-times-circle-o"></i> Usuário e senha não coincidem </label>--}%
            %{--</div>--}%
        </div>
        <div class="form-group has-feedback">

            <input type="password" class="form-control-remar" placeholder="Senha" name='j_password'>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-8">
                <div class="checkbox icheck">
                    <label>
                        <input type="checkbox"> Lembre-me
                    </label>
                </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
                <button type="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>
            </div><!-- /.col -->
        </div>
    </form>


    <div class="social-auth-links text-center">
        <!--
        <p>- OR -</p>
        %{--<fb:login-button perms="email,public_profile" scope="public_profile,email,publish_actions,user_about_me" onlogin="facebookLogin();" size="large">--}%
            %{--<g:message  code="Login por Facebook"/>--}%
        %{--</fb:login-button>--}%
        <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Entrar com o Facebook</a>
        -->
   </div>


    <div class="footer-span"><g:link class="footer-span" mapping="resetPassword">Esqueci a Senha!</g:link></div>
    <div class="footer-span">Ainda n&atilde;o est&aacute; cadastrado? <g:link class="footer-span" controller="user" action="create" >Registre-se</g:link> </div>

    <g:if test='${flash.message}'>
        <script>
            $('.form-group').addClass('has-error');

            $('.form-control-feedback').after($("<div />")
                                        .addClass("control-label")
                                        .text("Usuário e senha não coincidem"));

            $("input").focus(function(){
                $('.form-group').removeClass('has-error');
                $('.control-label').remove();
                $('input').off("focus");
            });
        </script>
    </g:if>

</body>
</html>