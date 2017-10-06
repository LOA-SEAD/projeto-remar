<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Recuperar conta</title>
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
                            <input id="password_confirmation" name="password_confirmation" type="password"/>
                            <label for="password_confirmation">Confirme sua senha</label>
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
<g:javascript src="libs/jquery/jquery.validate.js"/>
<script>
    $(function () {
        var existUser = false;
        var existEmail = false;
        $('form').validate({
            rules: {
                password: {
                    minlength: 8,
                    required: true
                },
                password_confirmation: {
                    required: true,
                    equalTo: "#password"
                }
            },
            messages: {
                password: {
                    required: "Por favor digite uma senha",
                    minlength: "A senha deve ter no minimo 8 caracteres"
                },
                password_confirmation: {
                    required: "Por favor confirme sua senha",
                    minlength: "Sua senha deve ter no minimo 8 caracteres",
                    equalTo: "As senhas não coincidem"
                }
            },

            errorElement: 'span',
            errorClass: 'invalid-input',

            errorPlacement: errorPlacement,

            highlight: highlight,
            unhighlight: unhighlight,

            success: function(el) {

            }
        });
    });

    function unhighlight(el) {
        $(el).removeClass('invalid');
        $(el).addClass('valid');

        if($(el).siblings('select').attr('name') != "gender" && $(el).attr('data-done') !== "true") {
            $('<i class="material-icons suffix green-text">done</i>').insertBefore(el);
            $(el).attr('data-done', true);
        }
    }

    function highlight(el) {
        $(el).removeClass('input-error');
        $(el).addClass('invalid');

        if($(el).attr("data-done") == "true") {
            $(el).siblings(".suffix").remove();
            $(el).removeAttr("data-done");
        }
    }

    function errorPlacement(err, el) {
        err.insertAfter($(el).next());
    }
</script>
</body>
</html>