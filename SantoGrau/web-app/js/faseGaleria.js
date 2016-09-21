/**
 * Created by leticia on 31/08/16.
 */

var tr;
var id;

window.onload = function() {
    var checkboxes = document.getElementsByTagName('input');

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].type == 'radio') {
            checkboxes[i].checked = false;
        }
    }

    $('.collapsible').collapsible({
        accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });

    $(".delete").click(function() {
        tr = $(this).parent().parent();
        id = $(tr).attr("data-id");

        $('#deleteModal').openModal();
    });

    $("#myForm").submit(function() {
        var select = false;
        var checkboxes = document.getElementsByTagName('input');
        var i = 0;
        while (select == false && i < checkboxes.length) {
            if ((checkboxes[i].type == 'radio') && (checkboxes[i].checked == true)) {
                select = true;
                console.log("SELECIONOU");
            }
            i++;
        }
        if (select == false || $("#orientacao").val() == "") {
            $("#erroSubmitModal").openModal();
            return false;
        }
    });
};

function _delete() {
    var data = {_method: 'DELETE'};
    var url = "deleteTheme/" + id;
    $.ajax({
        type: 'POST',
        data: data,
        url: url,
        success: function () {
            $(tr).hide();
            $(tr).remove();

            var myThemes = document.getElementsByClassName("myTheme");
            if (myThemes.length == 0) {
                window.location.reload();
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        }
    });
}

function _save() {
    var select = false;
    var checkboxes = document.getElementsByTagName('input');
    var i = 0;
    while (select == false && i < checkboxes.length) {
        if ((checkboxes[i].type == 'radio') && (checkboxes[i].checked == true)) {
            select = true;
            console.log("SELECIONOU");
        }
        i++;
    }
    if (select == false) {
        //$("#erroSubmitModal").openModal();
        alert("Você deve selecionar ao menos um tema.");
    }
    else {
        var themeId = document.forms["formName"].elements["radio"].value
        var data = {_method: 'POST', orientacao: $("#orientacao").val(), themeId: themeId};
        var url = "/santograu/faseGaleria/exportLevel";
        $.ajax({
            type: 'POST',
            data: data,
            url: url,
            success: function () {

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
}