$(document).ready(function() {
    var requiredMsg = "Este campo é obrigatório";
    $('select').material_select();

    $('form').validate({
        rules: {
            firstName: {
                required: true
            },
            lastName: {
                required: true
            },
            email: {
                email: true,
                required: true,
                remote: {
                    url: "/user/update-email-verifier",
                    type: 'POST',
                    data: {
                        email: function() {
                            return $('#email').val();
                        },
                        userId: $("form").attr("data-user-id")
                    }
                }
            },
            password: {
                minlength: 8
            },
            confirm_password: {
                equalTo: "#password"
            }
        },
        messages: {
            firstName: {
                required: requiredMsg
            },
            lastName: {
                required: requiredMsg
            },
            email: {
                required: requiredMsg,
                email: "Digite um email no formato nome@exemplo.com",
                remote: "Esse email já está em uso"
            },
            password: {
                minlength: "A nova senha deve ter no mínimo 8 caracteres"
            },
            confirm_password: {
                equalTo: "As novas senhas não são coincidem"
            },
            gender: {
                required: requiredMsg
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
<<<<<<< HEAD
=======

    if($(el).siblings('select').attr('name') != "gender" && $(el).attr('data-done') !== "true") {
       // $('<i class="material-icons suffix green-text">done</i>').insertBefore(el); //É O CHECK DO FORM QUE APARECE DENTRO DO BOTÃO
        $(el).attr('data-done', true);
    }
>>>>>>> 36790f3e98ee1e3fa4fcd138589409821cfc6c49
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
