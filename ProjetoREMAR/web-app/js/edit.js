/**
 * Created by matheus on 6/27/15.
 */
$(function(){



    $.ajax({
        type: 'POST',
        url: location.origin + "/resource/getResourceInstance/"+$("#hidden").val(),
        data: null,
        processData: false,
        contentType: false,
        success: function (data) {
           // console.log(data);
            $("#name").val(data.name)
                .next().addClass("active");

            $("#description").val(data.description)
                .next().addClass("active");

            $("#img1Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-1");
            $("#img-1-text").val("Imagem carregada!");

            $("#img2Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-2");
            $("#img-2-text").val("Imagem carregada!");

            $("#img3Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-3");
            $("#img-3-text").val("Imagem carregada!");
        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });

});

