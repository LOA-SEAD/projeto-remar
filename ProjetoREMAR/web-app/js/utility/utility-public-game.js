/**
 * Created by lucasbocanegra on 17/05/16.
 */
/*
* Script contém o código que controla a busca e o pagination da
* página publicGames
* */


$(function(){
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

                addMaterializeDepedences();
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

                addMaterializeDepedences();
            },
            error: function () {
                alert("error");
            }
        });
    });

    $(".next-page").click(listerNextPage);

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

                addMaterializeDepedences();

                goToByScroll("title-page");
            },
            error: function () {
                alert("error");
            }
        });
    }
});

function addMaterializeDepedences(){

    //inicializa componentes bootstrap
    $('.dropdown-button').dropdown();
    $('.tooltipped').tooltip({delay: 50});
}