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
        var catSelected = $(select).val();
        var formData = new FormData();
        formData.append('text', $(this).val());
        formData.append('category', catSelected);
        $.ajax({
            url: "/exported-resource/searchMyGames",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                $(".cardGames").remove();
                $("#showCards").append(response);
                $(".next-page").on("click",listerNextPage);
                addMaterializeDepedences();
            },
            error: function () {
                alert("error");
            }
        });
    });

    $(select).change(function(){
        var catSelected = $(select).val();
        var text = $("#search").val();
        var formData = new FormData();
        formData.append('category', catSelected);
        formData.append('text', text);
        $.ajax({
            url: "/exported-resource/searchMyGames",
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                $(".cardGames").remove();
                $("#showCards").append(response);
                $(".next-page").on("click",listerNextPage);
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
        var catSelected = $(select).val();
        var text = $("#search").val();
        var formData = new FormData();
        formData.append('category', catSelected);
        formData.append('text', text);
        console.log("category= "+ $(this).attr("category"));
        console.log("max="+$(this).attr("data-max"));
        console.log("offset="+$(this).attr("data-offset"));
        $.ajax({
            url: "/exported-resource/searchMyGames?max="+$(this).attr("data-max")+"&offset="+$(this).attr("data-offset"),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                $(".cardGames").remove();
                $("#showCards").append(response);
                $(".next-page").on("click",listerNextPage);
                //inicializa componentes materialize
                addMaterializeDepedences();
                goToByScroll("title-page");
            },
            error: function (response) {
                alert("error");
                console.log(response);
            }
        });
    }

    function listerTabNextPage(){
        var catSelected = $(select).val();
        var text = $("#search").val();
        var formData = new FormData();
        formData.append('category', catSelected);
        formData.append('text', text);
        console.log("tMax="+$(this).attr("data-max"));
        console.log("tOffset="+$(this).attr("data-offset"));
        $.ajax({
            url: "/exported-resource/searchMyGames?max="+$(this).attr("data-max")+"&offset="+$(this).attr("data-offset"),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                $(".cardProcesses").remove();
                $("#showCardsProcess").append(response);
                $(".tab-next-page").on("click",listerTabNextPage);
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

$(".user-profile").click(function() {
    var id = $(this).attr("id").substr(8);
    var url = location.origin + "/user/userProfile/" + id;
    $.ajax({
        type: 'GET',
        url:  url,
        data: null,
        processData: false,
        contentType: false,
        success: function (data) {
            $("#userDetailsModal").html(data);
            $("#userDetailsModal").openModal();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log(textStatus + "\n" + errorThrown);
        }
    });
});
