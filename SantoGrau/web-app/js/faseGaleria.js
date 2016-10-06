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

    $("#save").click(function( event) {
        event.preventDefault();
        var selectedTheme = $('input[name=radio]:checked', '#themeForm').val();
        var orientation = $("#orientacao").val();

        if (selectedTheme) {
            if (orientation) {
                var data = {_method: 'POST', orientacao: orientation, themeId: selectedTheme};
                var url = "/santograu/faseGaleria/exportLevel";
                $.ajax({
                    traditional: true,
                    type: 'POST',
                    data: data,
                    url: url,
                    success: function (response) {
                        window.top.location.href = response
                    },
                    error: function (response) {
                        alert("Error:\n" + response.responseText);
                    }
                });
            } else {
                $("#erroSubmitModal").openModal();
            }
        } else {
            $("#erroSubmitModal").openModal();
        }
    });

    $('.collapsible').collapsible({
        accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });

    $(".delete").click(function() {
        tr = $(this).parent().parent();
        id = $(tr).attr("data-id");

        $('#deleteModal').openModal();
    });
};

function _delete() {
    var data = {_method: 'DELETE'};
    var url = "deleteTheme/" + id;
    $.ajax({
        type: 'DELETE',
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