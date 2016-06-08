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
                console.log(data);
                Materialize.toast('Categoria salva com sucesso!', 3000, 'rounded');
                $("table").append("<tr class=\"action\">" +
                                        "<td class=\"category-name\">"+data.name+"</td>" +
                                        "<td>"+
                                            "<a href=\"#!\"  class=\"edit\" data-category-id=\""+data.id+"\">"+
                                                "<i class=\"material-icons\">mode_edit</i></a>"+
                                            "<a class=\"delete\" href=\"#!\" data-category-id=\""+data.id+"\"><i class=\"material-icons\">delete_forever</i></a>"+
                                        "</td>"+
                                  "</tr>");

                $(".delete").on("click", deleteCategory);
                $(".edit").on("click",editCategory);
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
            }
        });
    });

    $(".delete").on("click", deleteCategory);

    $(".edit").on("click",editCategory);

    $("#edit-save").on("click",function(){
        var id = $("#edit-name").attr("data-category-id");

        var formData = new FormData();
        formData.append('name',$("#edit-name").val());

        $.ajax({
            url: location.origin + "/category/update/"+id,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log(data);
                $('#edit-modal').closeModal();
                location.reload();
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
            }
        });
    });

});

function deleteCategory(){
    console.log("executou");
    var el = $(this);
    $.ajax({
        type: 'POST',
        url: location.origin + "/category/delete/"+$(this).attr("data-category-id"),
        data: {_method: 'DELETE'},
        success: function (data) {
            console.log(data);
            Materialize.toast('Categoria removida!', 3000, 'rounded');
            console.log($(el).parents().eq(1).find(".action"));
            $(el).parents().eq(1).remove();
        },
        error: function(req, res, err) {
            console.log(req);
            console.log(res);
            console.log(err);
        }
    });
}

function editCategory(){
    console.log("executou!");
    var el = $(this);
    var id = $(this).attr("data-category-id");

    $("#edit-name").attr("data-category-id",id)
                    .val($(el).parents().eq(1).find(".category-name").text())
                    .addClass("valid");

    $('#edit-modal').openModal();
}