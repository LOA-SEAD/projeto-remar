/**
 * Created by lucas on 22/01/16.
 */

$(document).ready(function() {
    var select = $("select");

    $(select).material_select();

    $("#search").on("keyup",function(){
        var formData = new FormData();
        formData.append('typeSearch','name');
        formData.append('text', $(this).val());

        console.log($(this).val());

        $.ajax({
            url: "/exported-resource/searchGame",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {

                $(".cardGames").remove();
                $(".show.cards").append(response);

                $(".next-page").each(function() {
                    $(this).on("click",listerNextPage)
                });
            },
            error: function () {
                alert("error");
            }
        });
    });

    $(select).change(function(){
        var catSelected = $(select).val();
        $("#search").val("");

        var formData = new FormData();
        formData.append('typeSearch','category');
        formData.append('text', catSelected);

        console.log($(this).val());

        $.ajax({
            url: "/exported-resource/searchGame",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {

                $(".cardGames").remove();
                $(".show.cards").append(response);

                $(".next-page").each(function() {
                    $(this).on("click",listerNextPage)
                });
            },
            error: function () {
                alert("error");
            }
        });
    });

    $('.rating-card').each(function() {
        $(this).rateYo({
            readOnly: true,
            precision: 0,
            maxValue: 100,
            starWidth: "13px",
            rating: Number($(this).attr("data-stars"))
        });
    });


    $(".next-page").click(listerNextPage);

});

function deleteResource(id){
    console.log(id);
    if(confirm("Deseja mesmo excluir este jogo?")){
        window.location.href = " /exported-resource/delete/"+id;
    }
}

function listerNextPage(){
    var formData = new FormData();
    formData.append('typeSearch','name');
    formData.append('text', $("#search").val());

    console.log("max="+$(this).attr("data-max"));
    console.log("offset="+$(this).attr("data-offset"));

    $.ajax({
        url: "/exported-resource/searchGame?max="+$(this).attr("data-max")+"&offset="+$(this).attr("data-offset"),
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (response) {
            $(".cardGames").remove();
            $(".show.cards").append(response);

            $(".next-page").each(function() {
                $(this).on("click",listerNextPage)
            });

            goToByScroll("title-page");
        },
        error: function () {
            alert("error");
        }
    });
}

// This is a functions that scrolls to #{blah}link
function goToByScroll(id){
    // Remove "link" from the ID
    id = id.replace("link", "");
    // Scroll
    $('html,body').animate({
            scrollTop: $("#"+id).offset().top},
        'slow');
}