/**
 * Created by matheus on 5/7/15.
 */
//var nameErr =

$(function(){
    var nameErr = $("#name-error");
    var loader = $("#preloader-wrapper");
    var name = $("#name");
    var imgFile = $("#img-1-text");

    $(name).prev().hide();
    $(imgFile).prev().hide();
    nameErr.hide();
    loader.hide();

    $(name).on("focus",function(){
        $(this).prev().hide();
    });

    $("#send").on("click", function() {
        //save new resource name


        if ($(name).val()) {

            var file = $("#img-1").prop('files')[0];
            if(file != null){
                var fr = new FileReader();
                fr.readAsDataURL(file);
                fr.onload = function(event) {
                    var image = new Image();
                    if(file != null){
                        image.src = event.target.result;
                    }else{
                        image.src = $("#img1Preview")[0].getAttribute("src");
                    }
                    image.onload = function() {
                        var formData = new FormData();
                        formData.append('banner', file);
                        formData.append('name', $(name).val());

                        $.ajax({
                            type: 'POST',
                            url: location.origin + '/exported-resource/update/' + $(name).data("resource-id"),
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function(data) {
                                //console.log("resource name updated");
                                nameErr.hide(500);
                                $(name).removeClass().addClass("valid");
                                $(name).prev().show(500);
                                Materialize.toast('Informações salva com sucesso!', 3000, 'rounded');

                                $(imgFile).removeClass().addClass("valid");
                                $(imgFile).prev().show(500);
                            },
                            error: function(req, status, err){
                                //alert("Esse nome já existe!");
                                nameErr.show(500);
                                $(name).prev().hide(500);
                                $(name).removeClass().addClass("invalid");
                                $(name).focus();
                            }
                        });
                    }
                }
            }else{ //atualiza somente o nome
                var formData = new FormData();
                //formData.append('banner', file);
                formData.append('name', $(name).val());

                $.ajax({
                    type: 'POST',
                    url: location.origin + '/exported-resource/update/' + $(name).data("resource-id"),
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(data) {
                        nameErr.hide(500);
                        $(name).removeClass().addClass("valid");
                        $(name).prev().show(500);
                        Materialize.toast('Informações salva com sucesso!', 3000, 'rounded');
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        nameErr.show(500);
                        $(name).prev().hide(500);
                        $(name).removeClass().addClass("invalid");
                        $(name).focus();
                    }
                });
            }
        }

        $("input[type='checkbox']").each(function() {
            if (this.checked && !this.disabled) {
                $(this).removeClass('checkbox-platform');
                var id = this.id;
                this.disabled = true;
                var el = $('label[for="' + id + '"]');
                var originalText = $(el).html();
                var intervalId = setInterval(function() {etc(el)}, 500);
                ajax(id, intervalId, el, originalText);
            }
        });
    });


    function ajax(endpoint, intervalId, el, originalText) {
        /*if (endpoint == "moodle") {
         window.location.href = location.origin + "/exported-resource/accountConfig/" + $(el).data("resource-id");
         }
         else {*/
        $.ajax({
            type:'GET',
            url: location.origin + '/exported-resource/' + endpoint + "?id=" + $(el).data("resource-id") + "&type=" + $("input[name=type]:checked").val(),
            success:function(data){
                loader.hide(500);
                if (endpoint == "moodle" ) {
                    clearInterval(intervalId);
                    $(el).html(originalText +
                            " <span class='chip center'>"+
                            "Utilize o jogo no seu Moodle."+
                            "</span>");
                    return
                }
                clearInterval(intervalId);
                $(el).html(originalText +
                           " <span class='chip center'>"+
                                 "<a target='_blank' href='"+ data +"'> Acessar </a>"+
                                 "<i class='fa fa-link'></i>"+
                            "</span>");
                    //<a target=\"_blank\" href=\"" + data + "\">Acessar</a>");
                $(el).effect("pulsate", {}, 3000);
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){}});
        //}
    }

    function etc(el) {
        var html = $(el).html();

        loader.show(500);

        //if(html != "Processando..." && html.indexOf("Processando") > -1) {
        //    html += ".";
        //} else if (!html.indexOf("Processando") > -1 || html.indexOf("...") > -1) {
        //    html = "Processando.";
        //}
        //
        //$(el).html(html);
    }

});


