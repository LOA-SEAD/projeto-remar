<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Recuperar conta</title>


    <link href="${resource(dir: 'assets/css', file: 'external-styles.css')}" rel="stylesheet" >
    <g:javascript src="recaptcha.js"/>
    <g:javascript src="../assets/js/jquery.min.js" />
    <g:javascript src="../assets/js/jquery.validate.js" />


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
<div class="container container-create">
    <header class="row logotipo" >
        <div class="logotipo" align="center" >
            <img  alt="logo remar" src="../assets/img/logo/logo-remar-v2.svg" height="50%" width="50%" />
        </div>
    </header>
    <article class="row">
        <div class="col-md-12">
            <section>
                <h3 class="title-style">Recuperar sua conta</h3>
                <div class="divider"></div>
            </section>
            <section>

                <g:form action="confirmEmail" controller="user" method='POST' class='cssform' autocomplete='off'>
                    <div id="div-email" class="form-group">
                        <label class="label-form" for="firstName">
                            <g:message code="user.email.label" default="Digite o email cadastrado: " />
                        </label>
                        <input type="text" class="form-control" name="email" id="email" placeholder="nome@exemplo.com" required=""/>
                    </div>
                    <div class="form-group captcha">
                        <div class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"></div>
                        <recaptcha:script/>
                    </div>
                    <div class="form-group">
                        <input type='submit' id="submitBtn"  class="btn btn-primary btn-block btn-create" value="Enviar"/>
                    </div>
                </g:form>

                <g:if test='${flash.message}'>
                    <script>
                        $('#div-email').addClass('has-error')
                                .after($("<div/>")
                                        .attr("id","div-email-error")
                                        .addClass("help-block")
                                        .addClass("help-block-create")
                                        .text("Esse email não está cadastrado"));

                        $("#email").focus(function(){
                            $('#div-email').removeClass('has-error');
                            $('.help-block').remove();
                            $('#email').off("focus");
                        });

                    </script>
                </g:if>

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
