/**
 * Created by matheus on 5/7/15.
 */

$(function () {
    var nameErr = $("#name-error");
    var loader = $("#preloader-wrapper");
    var name = $("#name");
    var imgFile = $("#img-1-text");
    var plataforms = $("#plataforms");
    var tasks= $("#tasks");

    $(name).prev().hide();
    $(imgFile).prev().hide();
    nameErr.hide();
    loader.hide();
    plataforms.hide();
    tasks.hide();

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
                        formData.append('img1',$("#img1Preview").attr("src"));

                        console.log($(name).data("process-id"));

                        $.ajax({
                            type: 'POST',
                            url: location.origin + '/process/update/' + $(name).data("process-id"),
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

                                tasks.show();
                                $("#tasks-header").trigger('click');
                                goToByScroll("tasks-header");

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
                    url: location.origin + '/process/update/' + $(name).data("process-id"),
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        nameErr.hide(500);
                        $(name).removeClass().addClass("valid");
                        $(name).prev().show(500);

                        tasks.show();
                        $("#tasks-header").trigger('click');
                        goToByScroll("tasks-header");
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


    });

    var platforms = $('.platform');
    var web = $('#web');
    var moodle = $('#moodle');

    $(web).css('cursor', 'wait');
    $(platforms).css('cursor', 'wait');
    $(moodle).css('cursor', 'wait');

    //$.ajax({
    //    type: 'GET',
    //    url: location.origin + '/exported-resource/export/' + $(name).data("resource-id"),
    //    success: function (data) {
    //
    //        $('.plataforms-progress').hide();
    //        plataforms.show(500);
    //        $(web).css('cursor', '');
    //        $(platforms).css('cursor', '');
    //        $(moodle).css('cursor', '');
    //
    //        $(web).parent().attr('href', data['web']);
    //
    //        $(web).hover(function () {
    //            $(this).children().eq(1).text('Acessar ').append('<i class="fa fa-link"></i>').addClass('plataforms-link');
    //        }, function () {
    //            $(this).children().eq(1).text('Web').removeClass('plataforms-link');
    //        });
    //
    //        $(moodle).children().eq(1).text('Disponível no Moodle');
    //
    //        $(platforms).each(function () {
    //            $(this).parent().attr('href', data[$(this).data('name')]);
    //
    //            $(this).hover(function () {
    //               $(this).children().eq(1).text('Baixar ').append('<i class="fa fa-arrow-circle-down" aria-hidden="true"></i>').addClass('plataforms-link');
    //            }, function () {
    //               $(this).children().eq(1).text($(this).data('text')).removeClass('plataforms-link');
    //            });
    //        });
    //
    //    },
    //    error: function (XMLHttpRequest, textStatus, errorThrown) {
    //        console.log(':(');
    //    }
    //});


    function cropPicture(target, updateImg){
        var jcrop;
        console.log(target.toString());


        var file = $(target).prop('files')[0];
        var fr = new FileReader();

        fr.readAsDataURL(file);
        fr.onload = function(event) {
            var image = new Image();
            image.src = event.target.result;
            image.onload = function() {
                var el = $('#crop-preview');
                $(el).attr('src', event.target.result);
                $("#modal-picture").openModal({
                    dismissible: true,
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

                        saveCrop(formData, updateImg);
                    }
                });
                $(el).Jcrop({
                    aspectRatio: 1,
                    setSelect: [0, 0, Math.max(this.width, this.height), Math.max(this.width, this.height)],
                    boxHeight: 280,
                    trueSize: [this.width, this.height]
                }, function () {
                    jcrop = this;
                });
            }
        }

    }

    function saveCrop(FormData, updateImg)
    //FormData é o arquivo de imagem e as coordenadas para o corte
    //updateImg é a imagePreview que deve ser atualizada
    //Esta função salva a imagem em uma pasta temporária
    {
        $.ajax({
            type: 'POST',
            url: location.origin + "/exported-resource/croppicture",
            data: FormData,
            processData: false,
            contentType: false,
            success: function (data) {
                $(updateImg).attr("src", "/data/tmp/" + data);
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
            }
        })

    }

    $('#img-1').on('change', function() {
        cropPicture(this, "#img1Preview");
    });

    // This is a functions that scrolls to #{blah}link
    function goToByScroll(id){
        // Remove "link" from the ID
        id = id.replace("link", "");
        // Scroll
        $('html,body').animate({
                scrollTop: $("#"+id).offset().top},
            'slow');
    }

});


