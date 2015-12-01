
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Recuperar conta</title>


    <g:javascript src="jquery/jquery.validate.js"/>
    <recaptcha:script/>
    <g:javascript src="recaptcha.js"/>
    <g:javascript src="../assets/js/jquery.min.js" />
    <g:javascript src="../assets/js/jquery.validate.js" />
    <style>
        body {
            background-color: #F2F2F2;
        }
    </style>

    <script>
        $(function() {

            $('form').validate({
                rules: {
                    email: {
                        email: true,
                        required: true
                    }
                },
                messages: {
                    email: {
                        required: "Por favor digite um email",
                        email: "Digite um email no formato: nome@exemplo"
                    }
                },
                highlight: function (element) {
                    $(element).closest('.form-group')
                            .addClass('has-error');

                },
                unhighlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-error');
                    $('#span-error').remove();
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
            <div class="card white col s12 m6 l4 offset-m3 offset-l4 offset-vertical-2" style="margin-top: 30px;">
                <div class="card-content">
                    <div class="card-image" style="padding-bottom: 20px;">
                        <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                    </div> <!-- card-image -->
                    <h4 class="title-style center">Recuperar sua conta</h4>

                    <g:form action="confirmEmail" controller="user" method='POST' class='cssform' autocomplete='off'>
                        <div class="row" style="padding-top: 30px;">
                            <div class="input-field col s12">
                                <div id="div-email" class="">
                                    <i class="material-icons prefix">email</i>
                                    <input type="email" class="form-control" name="email" id="email" placeholder="nome@exemplo.com" required=""/>
                                    <label for="email">Email cadastrado</label>
                                </div>
                            </div>
                            <div class="col s12">
                                <div class="input-field col s12 center">
                                    <div class="g-recaptcha text-center" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"> </div>
                                </div>
                            </div>
                            <div class="col s12">
                                <div class="input-field center-align">
                                    <button id="submit" class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
                                </div>
                            </div>
                        </div>
                    </g:form>

                    <g:if test='${flash.message}'>
                        <script>
                            $('#div-email').addClass('has-error')
                                .after($("<div/>")
                                    .attr("id","div-email-error")
                                    .addClass("help-block")
                                    .text("Esse email não está cadastrado"));

                            $("#email").focus(function(){
                                $('#div-email').removeClass('has-error');
                                $('.help-block').remove();
                                $('#email').off("focus");
                            });

                        </script>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>