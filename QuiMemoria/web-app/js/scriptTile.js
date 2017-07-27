/**
 * Created by hugo on 26/07/17.
 */

$(document).ready(function(){
    $('.collapsible').collapsible({
        accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });
});


window.onload = function(){
    console.log("ok");

    var checkboxes = document.getElementsByTagName('input');

    for (var i=0; i<checkboxes.length; i++)  {
        if (checkboxes[i].type == 'checkbox')   {
            checkboxes[i].checked = false;
        }
    }

    $(".save").click(function() {
        var tileToAdd = [];
        $('.myTile input').each(function (index) {

            if ($(this).is(':checked'))
                tileToAdd.push($(this).data('tileid'));
        });
        // TODO change to 18 (instead of 1)
        if (tileToAdd.length >= 1) {
            $.ajax({
                url: '/quimemoria/tile/choose/',
                type: "POST",
                data: {
                    'tiles': JSON.stringify(tileToAdd)
                },
                success: function (resp) {
                    console.log(resp);
                },
                error: function (request, status, error) {
                    console.log(error);
                }
            });
        }
        else {
            alert("Você deve selecionar no mínimo 18 peças antes de enviar.");
        }
    });


    $(".delete").click(function() {
        var tr = $(this).parent().parent();
        var id = $(tr).attr("data-id");
        var data = { _method: 'DELETE' };


        if(confirm("Deseja realmente excluir esta peça?")) {
            $.ajax({
                type: 'POST',
                data: data,
                url: "delete/" + id,
                success: function (data) {
                    console.log(data);
                    $(tr).hide();
                    $(tr).remove();

                    var myTiles = document.getElementsByClassName("myTile");
                    if(myTiles.length==0){
                        window.location.reload();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }
    });

};