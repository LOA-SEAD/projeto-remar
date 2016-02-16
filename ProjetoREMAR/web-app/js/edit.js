/**
 * Created by matheus on 6/27/15.
 */
$(function(){

    var name = document.getElementById("name");
    var description = document.getElementById("description");

    //var name = $("#name");
    var nameErr = $("#name-error");
    //var desc = $("#description");
    var descErr = $("#desc-error");


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
            $("#img-1-text").prop('placeholder',"Carregue uma nova imagem!");

            $("#img2Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-2");
            $("#img-2-text").prop('placeholder',"Carregue uma nova imagem!");

            $("#img3Preview").attr("src", "/data/resources/assets/"+data.uri+"/description-3");
            $("#img-3-text").prop('placeholder',"Carregue uma nova imagem!");
        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });

    $("#upload").on("click",function(){

        var ok = 0;
        var formData = new FormData();
        //var image1 = $("#img-1").prop('files')[0];
        //var image2 = $("#img-2").prop('files')[0];
        //var image3 = $("#img-3").prop('files')[0];
        //console.log(image1);
        //console.log(image2);
        //console.log(image3);
        //console.log($(this).data('id'));

        formData.append('name', document.getElementById("name").value);
        formData.append('description', document.getElementById("description").value);
        formData.append('img1',$("#img1Preview").attr("src"));
        formData.append('img2',$("#img2Preview").attr("src"));
        formData.append('img3',$("#img3Preview").attr("src"));

        if($(name).val()==null || $(name).val() == "") {
            $(nameErr).show(500);
            $(name).prev().hide();
            $(name).removeClass().addClass('invalid');
            ok = ok+1;
        }

        if($(description).val()==null || $(description).val()==""){
            $(descErr).show(500);
            $(description).prev().hide();
            $(description).removeClass('valid').addClass('invalid');
            ok = ok+1;
        }

        if(ok == 0) {
            $.ajax({
                url: "/resource/update/" + $("#hidden").val(),
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    //window.location.href = "../index";
                    Materialize.toast('Informações salva com sucesso!', 3000, 'rounded');

                    $(name).removeClass().addClass("valid");
                    $(name).prev().show(500);

                    $(description).addClass("valid");
                    $(description).prev().show(500);
                },
                error: function () {

                }
            });
        }
    });

});

