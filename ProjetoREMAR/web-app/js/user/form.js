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
                equalTo: "As senhas não coincidem"
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

//    if($(el).siblings('select').attr('name') != "gender" && $(el).attr('data-done') !== "true") {
//        $('<i class="material-icons suffix green-text">done</i>').insertBefore(el);
//        $(el).attr('data-done', true);
//    }
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

var jcrop;

$('#file').on('change', function() {
    var file = $(this).prop('files')[0];
    var fr = new FileReader();

    fr.readAsDataURL(file);
    fr.onload = function(event) {
        var image = new Image();
        image.src = event.target.result;
        image.onload = function() {
            var el = $('#crop-preview');
            $(el).attr('src', event.target.result);
            $("#modal-profile-picture").openModal({
                complete: function () {
                    jcrop.destroy();
                    $(".jcrop-holder").remove();
                    $(el).removeAttr("style");

                    var formData = new FormData();
                    var coordinates = jcrop.tellSelect();
                    formData.append('photo', file);
                    formData.append('x', coordinates.x);
                    formData.append('y', coordinates.y);
                    formData.append('w', coordinates.w);
                    formData.append('h', coordinates.h);

                    $.ajax({
                        type: 'POST',
                        url: "user/crop-profile-picture",
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            $('#profile-picture').attr("src", "/data/tmp/" + data);
                            $('#srcImage').attr("value", "/data/tmp/" + data);
                        },
                        error: function(req, res, err) {
                            console.log(req);
                            console.log(res);
                            console.log(err);
                        }
                    })


                }
            });
            $(el).Jcrop({
                aspectRatio: 1,
                setSelect: [0, 0, Math.max(this.width, this.height), Math.max(this.width, this.height)],
                boxHeight: 500,
                trueSize: [this.width, this.height]
            }, function () {
                jcrop = this;
            });
        }
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