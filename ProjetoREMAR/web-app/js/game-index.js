/**
 * Created by matheus on 6/27/15.
 */


function validateWar(){
    var inputFile = document.getElementById("war");
    var fileName = inputFile.value;

    if(fileName.length>0){
        var fileExtension = fileName.split('.').pop().toLowerCase();
        if(fileExtension=="war"){
            return true;
        }
        else {
            return false;
        }
    }
    else{
        return false;
    }
}


$(function(){
    /* carregar war, chamando o controlador e redirecionando para a mesma pagina*/

    var name = $("#name");
    var nameErr = $("#name-error");
    var desc = $("#description");
    var descErr = $("#desc-error");

    $(name).prev().hide();
    $(desc).prev().hide();
    $(nameErr).hide();
    $(descErr).hide();

    //console.log($(name).val());
    if($(name).val() != null && $(name).val() != ""){
        //console.log("entrou aki");
        $(name).removeClass().addClass("valid");
        $(name).prev().show(500);
    }

    if($(desc).val() != null && $(name).val() != ""){
        $(desc).addClass("valid");
        $(desc).prev().show(500);
    }

    console.log("carregou game-index");

    $('textarea#textarea1').characterCounter();
    $('select').material_select();
    $('.materialboxed').materialbox();
    $('.loaded-form').hide();
    $('#preloader-wrapper').hide();
    $('.send-icon').hide();

    $('.send').on('click', function() {


        if(validateWar()){
            var file = $("#war").prop('files')[0];
            console.log(file);
            var url = "/resource/save";
            var formData = new FormData();
            formData.append('war', file);

            $('#preloader-wrapper').show('fast');

            $.ajax({
                type: 'POST',
                url: url,
                data: formData,
                //xhr: function() {
                //    var myXhr = $.ajaxSettings.xhr();
                //    if(myXhr.upload){
                //        myXhr.upload.addEventListener('progress',progress, false);
                //    }
                //    return myXhr;
                //},
                processData: false,
                contentType: false,
                success: function (data) {

                    $('#preloader-wrapper').hide();
                    $('.send-icon').show('fast');
                    $('#info-add').trigger('click');


                    $('.loaded-form').show("slideDown");

                    $("#name").val(data.name)
                        .next().addClass("active");

                    $("#description").val(data.description);

                    //$(".icons-select select").val(data.category);
                    //$("#img-1").attr("src", "/data/resources/assets/"+data.uri+"/description-1");

                    //set hidden id
                    $("#hidden").val(data.id);

                },
                error: function(req, res, err) {
                    console.log(req);
                    console.log(res);
                    console.log(err);
                }
            });
        }

        else{
            Materialize.toast("Extensão do arquivo inválida. Por favor selecione um arquivo .war", 3000);
        }
    });

    function progress(e){

        if(e.lengthComputable){
            var max = e.total;
            var current = e.loaded;

            var Percentage = (current * 100)/max;

            $(".determinate").css("width",Percentage+"%");
            console.log(Percentage);

            if(Percentage >= 100)
            {
                $('.loaded-form').show("slideDown");
            }
        }
    }

    $('.review').on('click', function() {
        var id = $(this).data('id');
        var status = $(this).data('review');
        var _this = this;
        var img = $(this).parents().eq(5).find('img');
        var imgSrc = $(img).attr('src');
        console.log(imgSrc);

        $(img).attr('src', '/images/loading_spinner.gif');

        var url = location.origin + '/resource/review/' + id + "/" + status;

        $.ajax({
            type:'POST',
            url: url,
            success:function(data){
                console.log(data);
                var tr = $(_this).parents().eq(4);
                $(tr).removeClass('pending approved rejected');
                if (status == 'approve') {
                    $(tr).addClass('approved');
                } else {
                    $(tr).addClass('rejected');
                }
                $(img).attr('src', imgSrc);

            },
            error:function(req, status, err){
                console.log(req.responseText);
                $(img).attr('src', imgSrc);
            }});
    });

    $('.comment').on('focusout', function() {
        var url = location.origin + '/resource/review/' + $(this).data('id') + "?comment=" + encodeURIComponent($(this).val());
        $.ajax({
            type:'POST',
            url: url,
            success:function(data){
                console.log(data);
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});

    }).keyup(function(e) {
        if (e.keyCode == 13) {
            $(this).blur();
        }
    });

    $('.delete').on('click', function() {
        var el = $(this);
        var id = $(this).data('id');

        $.ajax({
            type: 'DELETE',
            url: location.origin + '/resource/delete/' + id,
            success: function(data) {
                console.log(data);
                console.log($(el).parents().eq(4).remove());
            },
            error: function(req, status, err) {
                console.log(req.responseText);
            }
        })
    });

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
                //$('#crop-preview').Jcrop();
                $("#modal-picture").openModal({
                    dismissible: false,
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
                    aspectRatio: 2,
                    setSelect: [0, 0, Math.max(this.width, this.height), Math.max(this.width, this.height)],
                    boxHeight: 500,
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
            url: "/resource/croppicture",
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

    $('#img-2').on('change', function() {
        cropPicture(this, "#img2Preview");
    });

    $('#img-3').on('change', function() {
        cropPicture(this, "#img3Preview");
    });

    $(name).on("focus",function() {
        $(name).prev().hide();
        $(nameErr).hide();
        $(name).removeClass();
    });

    $(desc).on("focus",function() {
        $(desc).prev().hide();
        $(descErr).hide();
        $(desc).removeClass().addClass("materialize-textarea");
    });

});