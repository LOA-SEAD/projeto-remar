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
            alert("Extensão do arquivo inválida. Por favor selecione um arquivo .war");
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

});
