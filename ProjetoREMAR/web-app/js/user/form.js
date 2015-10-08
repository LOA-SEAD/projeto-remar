/**
 * Created by matheus on 10/4/15.
 */
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
                remote: "/user/email-available"
            },
            username: {
                minlength: 3,
                maxlength: 16,
                required: true,
                remote: "/user/username-available"
            },
            password: {
                minlength: 8,
                required: true
            },
            confirm_password: {
                required: true,
                equalTo: "#password"
            },
            agree: "required"
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
            username: {
                required: requiredMsg,
                minlength: "O nome de usuário deve ter no mínimo 3 caracteres",
                maxlength: "O nome de usuário deve ter no máximo 16 caracteres",
                remote: "Esse nome de usuário já está em uso"
            },
            password: {
                required: requiredMsg,
                minlength: "A senha deve ter no mínimo 8 caracteres"
            },
            confirm_password: {
                required: requiredMsg,
                equalTo: "As senhas não são coincidem"
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

    setInterval(verifyRecaptcha, 500);

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

$('select').on('change', function() {
    var el = $('#profile-picture');
    if(this.value == "male") {
        $(el).attr('src', '/images/avatars/male.png');
    } else {
        $(el).attr('src', '/images/avatars/female.png');
    }
});

$('#file').on('change', function() {
    var fr = new FileReader();

    fr.readAsDataURL($(this).prop('files')[0]);
    fr.onload = function(event) {
        $('#profile-picture').attr('src', event.target.result);
    }
});

$('#submit').on('click', function() {
    if(!grecaptcha.getResponse().length) {
        $('form').validate();
        return false;
    }
});

function verifyRecaptcha() {
    if(grecaptcha.getResponse().length) {
        $('.tooltipped').tooltip('remove');
    }
}