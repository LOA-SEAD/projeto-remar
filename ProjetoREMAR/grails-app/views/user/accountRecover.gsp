<%--
  Created by IntelliJ IDEA.
  User: marcus
  Date: 27/04/16
  Time: 10:59
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="base">
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title>Reativar conta</title>


    <g:javascript src="jquery/jquery.validate.js"/>
    <recaptcha:script/>
    <g:javascript src="remar/recaptcha.js"/>
    <g:javascript src="../assets/js/jquery.min.js" />
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
        <div class="card white col s12 m6 l6 offset-m3 offset-l3 offset-vertical-2" style="margin-top: 30px;">
            <div class="card-content" style="padding: 20px !important;">
                <div class="card-image" style="padding-bottom: 20px;">
                    <img src="/assets/img/logo/logo-remar-preto-transparente.png">
                </div> <!-- card-image -->
                <h4 class="title-style center">Reativar conta</h4>


                <g:form method='POST' controller="user" action="recoverUserAccount"  class='cssform' autocomplete='on'>
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
                                <div class="g-recaptcha text-center" data-sitekey="6Le6wh8UAAAAAP9Gs9OkQEWIZZBcQJDHWht_zYpG"> </div>
                            </div>
                        </div>
                        <div class="col s12">
                            <div class="input-field center-align">
                                <button class="btn waves-effect waves-light tooltiped my-orange" type="submit">Enviar</button>
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
</body>
</html>
