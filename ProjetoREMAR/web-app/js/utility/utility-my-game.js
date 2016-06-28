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

    $("#search-game").on("keyup",function(){
        var formData = new FormData();
        formData.append('typeSearch','name');
        formData.append('text', $(this).val());

        console.log($(this).val());

        $.ajax({
            url: "/exported-resource/searchMyGame",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {

                $(".cardGames").remove();
                $("#showCards").append(response);

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

    $("#search-processes").on("keyup",function(){
        var formData = new FormData();
        formData.append('typeSearch','processes');
        formData.append('text', $(this).val());

        console.log($(this).val());

        $.ajax({
            url: "/exported-resource/searchProcesses",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {

                $(".cardProcess").remove();
                $("#showCardsProcess").append(response);

                $(".tab-next-page").each(function() {
                    $(this).on("click",listerTabNextPage);
                });

                addMaterializeDepedences();
            },
            error: function () {
                console.log("Error on search processes");
            }
        });
    });

    $(select).change(function(){
        var catSelected = $(select).val();
        $("#search-game").val("");

        var formData = new FormData();
        formData.append('typeSearch','category');
        formData.append('text', catSelected);

        console.log($(this).val());

        $.ajax({
            url: "/exported-resource/searchMyGame",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {

                $(".cardGames").remove();
                console.log(response);
                $("#showCards").append(response);

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

    $(".tab-next-page").click(listerTabNextPage);

    function listerNextPage(){
        var formData = new FormData();
        formData.append('typeSearch','name');
        formData.append('text', $("#search-game").val());

        console.log("max="+$(this).attr("data-max"));
        console.log("offset="+$(this).attr("data-offset"));

        $.ajax({
            url: "/exported-resource/searchMyGame?max="+$(this).attr("data-max")+"&offset="+$(this).attr("data-offset"),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                $(".cardGames").remove();
                $("#showCards").append(response);

                $(".next-page").each(function() {
                    $(this).on("click",listerNextPage)
                });

                //inicializa componentes materialize
                addMaterializeDepedences();

                goToByScroll("title-page");
            },
            error: function () {
                alert("error");
            }
        });
    }


    function listerTabNextPage(){
        var formData = new FormData();
        formData.append('typeSearch','name');
        formData.append('text', $("#search-game").val());

        console.log("tMax="+$(this).attr("data-max"));
        console.log("tOffset="+$(this).attr("data-offset"));

        $.ajax({
            url: "/exported-resource/searchMyGame?max="+$(this).attr("data-max")+"&offset="+$(this).attr("data-offset"),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                $(".cardProcesses").remove();
                $("#showCardsProcess").append(response);

                $(".tab-next-page").each(function() {
                    $(this).on("click",listerTabNextPage)
                });

                //inicializa componentes materialize
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