/**
 * Created by matheus on 5/7/15.
 */

$(function () {
    var nameErr = $("#name-error");
    var loader = $("#preloader-wrapper");
    var name = $("#name");
    var imgFile = $("#img-1-text");

    $(name).prev().hide();
    $(imgFile).prev().hide();
    nameErr.hide();
    loader.hide();

    $(name).on("focus", function () {
        $(this).prev().hide();
    });

    $("#send").on("click", function () {
        if ($(name).val()) {
            var file = $("#img-1").prop('files')[0];
            if (file != null) {
                var fr = new FileReader();
                fr.readAsDataURL(file);
                fr.onload = function (event) {
                    var image = new Image();
                    if (file != null) {
                        image.src = event.target.result;
                    } else {
                        image.src = $("#img1Preview")[0].getAttribute("src");
                    }
                    image.onload = function () {
                        var formData = new FormData();
                        formData.append('banner', file);
                        formData.append('name', $(name).val());

                        $.ajax({
                            type: 'POST',
                            url: location.origin + '/exported-resource/update/' + $(name).data("resource-id"),
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function (data) {
                                //console.log("resource name updated");
                                nameErr.hide(500);
                                $(name).removeClass().addClass("valid");
                                $(name).prev().show(500);
                                Materialize.toast('Informações salvas com sucesso!', 3000, 'rounded');

                                $(imgFile).removeClass().addClass("valid");
                                $(imgFile).prev().show(500);
                            },
                            error: function (req, status, err) {
                                //alert("Esse nome já existe!");
                                nameErr.show(500);
                                $(name).prev().hide(500);
                                $(name).removeClass().addClass("invalid");
                                $(name).focus();
                            }
                        });
                    }
                }
            } else { //atualiza somente o nome
                var formData = new FormData();
                //formData.append('banner', file);
                formData.append('name', $(name).val());

                $.ajax({
                    type: 'POST',
                    url: location.origin + '/exported-resource/update/' + $(name).data("resource-id"),
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        nameErr.hide(500);
                        $(name).removeClass().addClass("valid");
                        $(name).prev().show(500);
                        Materialize.toast('Informações salvas com sucesso!', 3000, 'rounded');
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        nameErr.show(500);
                        $(name).prev().hide(500);
                        $(name).removeClass().addClass("invalid");
                        $(name).focus();
                    }
                });
            }
        }

        $(".checkbox-platform").each(function () {
            if (this.checked) {
                $(this).removeClass('checkbox-platform');
                $(this).addClass('compiling');
                var id = this.id;
                this.disabled = true;
                var label = $('label[for="' + id + '"]');
                ajax(id, label);
                loader.show();
            }
        });
    });

    function ajax(endpoint, label) {
        $.ajax({
            type: 'GET',
            url: location.origin + '/exported-resource/' + endpoint + "?id=" + $(label).data("id") + "&type=" + $("input[name=type]:checked").val(),
            success: function (data) {
                $("#" + endpoint).removeClass('compiling');
                if ($('.compiling').length == 0) {
                    loader.hide();
                }
                if (endpoint == "moodle") {
                    $(label).after(" <span class='chip center'>" +
                        "Jogo disponível no Moodle" +
                        "</span>");
                } else {
                    $(label).after(" <span class='chip center'>" +
                        "<a target='_blank' href='" + data + "'>Acessar </a>" +
                        "<i class='fa fa-link'></i>" +
                        "</span>");
                }

                $(label).effect("pulsate", {}, 3000);
                $(label).next().effect("pulsate", {}, 3000);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#" + endpoint).removeClass('compiling');
                if ($('.compiling').length == 0) {
                    loader.hide();
                }
            }
        });
    }
});


