<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Recuperar conta</title>

    <g:javascript src="jquery/jquery.validate.js"/>

    <script>
        $(function () {
            var existUser = false;
            var existEmail = false;
            $('form').validate({
                rules: {
                    newPassword: {
                        minlength: 8,
                        required: true
                    },
                    confirm_password: {
                        required: true,
                        minlength: 8,
                        equalTo: "#newPassword"
                    }
                },
                messages: {
                    newPassword: {
                        required: "Por favor digite uma senha",
                        minlength: "A senha deve ter no minimo 8 caracteres"
                    },
                    confirm_password: {
                        required: "Por favor confirme sua senha",
                        minlength: "Sua senha deve ter no minimo 8 caracteres",
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
<div class="container">
    <div class="row">
        <div class="card white z-depth-2 col s12 m6 l4 offset-m2 offset-l4">
            <div class="card-content" style="padding: 20px !important;">
                <div class="card-image" style="padding-bottom: 20px;">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <form action="/user/password/reset" method="POST">
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">lock</i>
                            <input id="password" name="password" type="password"/>
                            <label for="password">Senha</label>
                        </div>

                        <div class="input-field col s12">
                            <i class="material-icons prefix">lock</i>
                            <input id="password-confirmation" name="password_confirmation" type="password"/>
                            <label for="password-confirmation">Confirme sua senha</label>
                        </div>

                        <input type="hidden" name="token" value="${token}"/>

                        <div class="clearfix"></div>
                        <div class="input-field center-align">
                            <button id="submit" class="btn waves-effect waves-light tooltiped my-orange"
                                    type="submit">Enviar</button>
                        </div>
                    </div> <!-- row -->
                </form>
            </div> <!-- card-content -->
        </div> <!-- card -->
    </div> <!-- row -->
</div> <!-- container -->
</body>
</html>