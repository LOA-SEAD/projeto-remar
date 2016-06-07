$(document).ready(function(){

    $('.modal-trigger').leanModal();

    $('#save').on("click",function(){
        var formData = new FormData();
        formData.append('name',$("#name").val());

        $.ajax({
            type: 'POST',
            url: location.origin + "/category/save",
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                // console.log(data);
                console.log(data);
                Materialize.toast('Categoria salva com sucesso!', 3000, 'rounded');
                $("table").append("<tr>" +
                                        "<td>"+data.name+"</td>" +
                                        "<td>"+
                                            "<a href=\"#!\" id=\"edit\" data-category-id=\""+data.id+"\">"+
                                                "<i class=\"material-icons\">mode_edit</i></a>"+
                                            "<a class=\"delete\" href=\"#!\" data-category-id=\""+data.id+"\"><i class=\"material-icons\">delete_forever</i></a>"+
                                        "</td>"+
                                  "</tr>");
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
            }
        });
    });

    $(".delete").on("click",function(){
        console.log("executou");
        $.ajax({
            type: 'POST',
            url: location.origin + "/category/delete/"+$(this).attr("data-category-id"),
            data: {_method: 'DELETE'},
            success: function (data) {
                console.log(data);
                Materialize.toast('Categoria removida!', 3000, 'rounded');
                $(this).eq(2).find("<tr>").remove();
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
            }
        });
    });

});
          