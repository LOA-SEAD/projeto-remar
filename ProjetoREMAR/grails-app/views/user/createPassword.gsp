<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="new-main-external">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Recuperar conta</title>

    <link href="${resource(dir: 'assets/css', file: 'icomoon.css')}" rel="stylesheet" >
    %{--<g:javascript src="recaptcha.js" />--}%

    <g:javascript src="../assets/js/jquery.min.js" />
    <g:javascript src="../assets/js/jquery.validate.js" />

    <script>
        $(function() {
            var existUser = false;
            var existEmail = false;
            $('form').validate({
                rules: {
                    newPassword: {
                        minlength: 5,
                        required: true
                    },
                    confirm_password: {
                        required: true,
                        minlength: 5,
                        equalTo: "#newPassword"
                    }
                },
                messages: {
                    newPassword: {
                        required: "Por favor digite uma senha",
                        minlength: "A senha deve ter no minimo 5 caracteres"
                    },
                    confirm_password: {
                        required: "Por favor confirme sua senha",
                        minlength: "Sua senha deve ter no minimo 5 caracteres",
                        equalTo: "As senhas não coincidem"
                    }
                },
                highlight: function (element) {
                    $(element).closest('.form-group')
                            .addClass('has-error');
                },
                unhighlight: function (element) {
                    if (existUser == false && existEmail == false) {
                        $(element).closest('.form-group').removeClass('has-error');
                        $('#span-error').remove();
                    }
                },
                errorElement: 'span',
                errorClass: 'help-block help-block-create',
                errorPlacement: function (error, element) {
                    error.insertAfter(element.parent());
                }
            });
        });
    </script>

</head>
<body>
<div class="row">
    %{--<header class="row logotipo" >--}%
        %{--<div class="logotipo" align="center" >--}%
            %{--<img  alt="logo remar" src="../../assets/img/logo/logo-remar-v2.svg" height="50%" width="50%" />--}%
        %{--</div>--}%
    %{--</header>--}%
    <article class="row">
        <div class="col-md-12">
            <section>
                <h3 class="">Redefinir senha</h3>
            </section>
            <section>
                <g:if test='${flash.message}'>
                    <div class='login_message'>${flash.message}</div>
                </g:if>

                <form action="/user/password/reset" method='POST' class='cssform' autocomplete='off'>
                    <div class="form-group">
                        <label for="password">Nova senha:</label>
                        <input type="password" class="form-control input-form" name="password" id="password" required=""/>
                    </div>
                    <div class="form-group">
                        <label for="password-confirmation">Confirme Nova Senha:</label>
                        <input type="password" class="form-control input-form" name="password_confirmation" id="password-confirmation" required=""/>
                    </div>
                    <input type="hidden" name="token" value="${token}" />
                    <div>
                        <p>
                            <input type='submit' id="submitBtn" class="btn btn-primary btn-block btn-create" value="Enviar"/>
                            %{--value='${message(code: "springSecurity.login.button")}--}%
                        </p>
                    </div>
                </form>
            </section>
        </div>
    </article>
    <footer class="row">
        <div class="col-md-12">
        </div>
    </footer>
</div>
</body>
</html>











%{--<html>--}%
%{--<head>--}%
%{--<meta name='layout' content='main'/>--}%
%{--<title><g:message code="springSecurity.login.title"/></title>--}%

%{--</head>--}%

%{--<body>--}%
%{--<div class="page-header">--}%
%{--<h1> Nova senha</h1>--}%
%{--</div>--}%
%{--<div class="main-content">--}%
%{--<div class="widget">--}%
%{--<h3 class="section-title first-title"><i class="icon-user"></i> Criação de Nova Senha</h3>--}%
%{--<div class="widget-content-white glossed">--}%
%{--<div class="padded">--}%
%{--<g:if test='${flash.message}'>--}%
%{--<div class='login_message'>${flash.message}</div>--}%
%{--</g:if>--}%
%{--<g:form action="newPassword" controller="user" method='POST' class='cssform' autocomplete='off'>--}%
%{--<div class="form-group">--}%
%{--<label for="newPassword">Nova senha:</label>--}%
%{--<input type="password" class="form-control" name="newPassword" id="newPassword" required=""/>--}%
%{--</div>--}%
%{--<div class="form-group">--}%
%{--<label for="confirmPassword">Confirme Nova Senha:</label>--}%
%{--<input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required=""/>--}%
%{--</div>--}%
%{--<input type="hidden" name="userid" value="${user}" />--}%
%{--<div>--}%
%{--<p>--}%
%{--<input type='submit' id="submit" class="btn btn-info btn-lg" value="Enviar"/>--}%
%{--value='${message(code: "springSecurity.login.button")}--}%
%{--</p>--}%
%{--</div>--}%
%{--</g:form>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%

%{--<script type="text/javascript">--}%
%{--$(function() {--}%
%{--document.getElementById('menu-latera').style.display = "none";--}%
%{--});--}%
%{--</script>--}%
%{--</body>--}%
%{--</html>--}%