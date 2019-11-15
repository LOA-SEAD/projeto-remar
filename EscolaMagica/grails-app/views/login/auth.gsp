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

        </div>
        <div class="col-xs-4">
            <button type="submit" id="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>
        </div>
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




</body>
</html>


