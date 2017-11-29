/**
 * Created by matheus on 5/7/15.
 */

$(function () {
    var nameErr = $("#name-error");
    var loader = $("#preloader-wrapper");
    var name = $("#name");
    var imgFile = $("#img-1-text");
    var publish = $("#publish");
    var tasks = $("#tasks");
    var info = $("#info");

    $(name).prev().hide();
    $(imgFile).prev().hide();
    nameErr.hide();
    loader.hide();
    publish.addClass("disabled");

    $(name).on("focus", function () {
        $(this).prev().hide();
    });

    $("#send").on("click", function () {

        goToByScroll("start");

        if ($(name).val()) {
            var file = $("#img-1").prop('files')[0];
            if (file != null) { //se a imagem de preview foi mudada
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

                        $.ajax({
                            type: 'POST',
                            url: location.origin + '/process/update/' + $(name).data("process-id"),
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function (data) {
                                //console.log("resource name updated");
                                nameErr.hide(500);
                                window.location = location.pathname.split("?")[0];
                                window.location.pathname.reload();


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
                        window.location = location.pathname.split("?")[0];
                        window.location.pathname.reload();

                        $(name).removeClass().addClass("valid");
                        $(name).prev().show(500);
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
        $("#info-header").parents("li").hide();
        $("#tasks-header").parents("li").show();
    });


    $('#content-area').on('input', function() {
        var contentArea = $('#content-area').val() ;
        if(contentArea!=""){
            $("#content-area-error").hide();
            $('#content-area').removeClass("invalid").addClass("valid");
        }
        else{
            $("#content-area-error").show();
            $('#content-area').removeClass().addClass("invalid");

        }
        validatePublish();

    });

    $('#specific-content').on('input', function() {
        var specificContent = $("#specific-content").val();
        if(specificContent!=""){
            $("#specific-content-error").hide();
            $('#specific-content').removeClass("invalid").addClass("valid");
        }
        else{
            $("#specific-content-error").show();
            $('#specific-content').removeClass().addClass("invalid");

        }
        validatePublish();

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
        $('html,body').animate({ scrollTop: $("#"+id).offset().top}, 'slow');
    }

    if(tasks.data("all-tasks-completed") != null &&
        tasks.data("all-tasks-completed").toString() == "true"){

        $("#send").hide();
        console.log("removendo disabled button");
        $("#submitButtonDisabled").removeClass("hide");
        $("#row-content-area").removeClass("hide");
        $("#row-specific-content").removeClass("hide");
    }


    if(info.data("basic-info") != null &&
        info.data("basic-info").toString() == "true") {

        $(name).removeClass().addClass("valid");

        //se a imagem de preview foi alterada
        if(imgFile.text() != "" && imgFile.text() != null){
            $(imgFile).removeClass().addClass("valid");
        }

        Materialize.toast('Informações básicas salvas com sucesso!', 3000)
    }

    if($("#specific-content").val()!=null || $("#content-area").val()!=null){
        validatePublish();
    }

});

function validatePublish(){
    var contentArea = $('#content-area').val() ;
    var specificContent = $("#specific-content").val();

    if(contentArea!="" && contentArea!=null){
        if(specificContent!="" && specificContent!=null){
            $("#submitButton").removeClass('hide');
            $("#submitButtonDisabled").addClass('hide');
            $("#specific-content-error").hide();
            $('#specific-content').removeClass("invalid").addClass("valid");
            $("#content-area-error").hide();
            $('#content-area').removeClass("invalid").addClass("valid");
            return true
        }
        else{
            $("#submitButton").addClass("hide");
            $("#submitButtonDisabled").removeClass('hide');
            $("#specific-content-error").show();
            $('#specific-content').removeClass("valid").addClass("invalid");
            return false;
        }
    }
    else{
        $("#submitButton").addClass("hide");
        $("#submitButtonDisabled").removeClass('hide');
        $("#content-area-error").show();
        $('#content-area').removeClass("valid").addClass("invalid");
        return false;
    }
}

function finishGame() {
    var formData = new FormData();
    var name = $("#name");
    var contentArea = $('#content-area').val();
    var specificContent = $("#specific-content").val();
    window.location = location.origin +  "/process/finish?name=" + name.val() + "&&id=" + $("#processId").val() + "&&contentArea=" + contentArea + "&&specificContent=" + specificContent;

}


//testanto função de hide and click collapsible
function hideTeste(){
    $('#info-header').toggleClass("collapsed");
    $('#tasks-header').toggleClass("expanded");
  /* $("#info-header").click(function () {
        $(this).toggleClass("collapsed");
    });
    $('#tasks-header').click(function () {
        $(this).toggleClass("expanded");
    });*/

}
