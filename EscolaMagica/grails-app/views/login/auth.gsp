<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta name="layout" content="new-main-external">
    <meta charset="utf-8">
    <meta name="generator" content="Bootply" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Entrar</title>

    <g:javascript src="../assets/js/jquery.min.js" />
    <g:javascript src="../assets/js/jquery.validate.js" />

    %{--<script type="text/javascript">--}%
        %{--window.fbAsyncInit = function() {--}%
            %{--FB.init({--}%
                %{--appId      : '1621035434837394',--}%
                %{--xfbml      : true,--}%
                %{--version    : 'v2.4'--}%
            %{--});--}%
        %{--};--}%

        %{--(function(d, s, id){--}%
            %{--var js, fjs = d.getElementsByTagName(s)[0];--}%
            %{--if (d.getElementById(id)) {return;}--}%
            %{--js = d.createElement(s); js.id = id;--}%
            %{--js.src = "//connect.facebook.net/en_US/sdk.js";--}%
            %{--fjs.parentNode.insertBefore(js, fjs);--}%
        %{--}(document, 'script', 'facebook-jssdk'));--}%

        %{--function facebookLogin() {--}%
            %{--FB.getLoginStatus(function(response) {--}%
                %{--if (response.status === 'connected') {--}%
                    %{--console.log("Conectado");--}%
                    %{--// logged in and connected user, someone you know--}%
                    %{--window.location ="${createLink(controller:'facebook', action:'auth')}";--}%
                %{--}--}%
                %{--else{--}%
                    %{--console.log("nao conectado");--}%
                %{--}--}%
            %{--});--}%
        %{--}--}%
    %{--</script>--}%

</head>
<body>
<form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
    <div class="form-group has-feedback">
        <input type="text" class="form-control-remar" placeholder="Nome de usuário" name="j_username" id="username" >
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
    </div>
    <div class="form-group has-feedback">
        <input type="password" class="form-control-remar" placeholder="Senha" name='j_password' id='password'>
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
    </div>
    <div class="row">
        <div class="col-xs-8">
            %{--<div class="checkbox icheck">--}%
            %{--<label>--}%
            %{--<input type="checkbox"> Lembre-me--}%
            %{--</label>--}%
            %{--</div>--}%
        </div><!-- /.col -->
        <div class="col-xs-4">
            <button type="submit" id="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>
        </div><!-- /.col -->
    </div>

    <g:if test='${flash.message}'>
        <script>
            console.log("teste");

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

</form>

%{--<div class="social-auth-links text-center">--}%
    %{--<!----}%
        %{--<p>- OR -</p>--}%
    %{--<fb:login-button perms="email,public_profile" scope="public_profile,email,publish_actions,user_about_me" onlogin="facebookLogin();" size="large">--}%
        %{--<g:message  code="Login por Facebook"/>--}%
    %{--</fb:login-button>--}%
        %{--<a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Entrar com o Facebook</a>--}%
        %{---->--}%
%{--</div>--}%


</body>
</html>


