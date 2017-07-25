/**
 * Created by garciaph on 24/07/17.
 */

var DELETE_URL = "/quimolecula/molecule/delete";

$(document).ready(function () {
    $( '.sortable' ).sortable({ connectWith: '.connected-sortable' });
    $( '.sortable' ).disableSelection();

    $( '#available-molecules li' )
        .mousedown(function() {
            $(this).css('cursor', 'move');
        })
        .mouseup(function() {
            $(this).css('cursor', 'pointer');
        })
        .click(function() {
            $(this).toggleClass('active');

            if ($( '#available-molecules li.active' ).length > 0) {
                $( '#deleteMoleculeButton' ).removeClass('disabled');
            } else {
                $( '#deleteMoleculeButton' ).addClass('disabled');
            }
        });

    // Delete button click function
    $("#deleteMoleculeButton").click(function() {
        $(".molecule-list-box li.active").each(function(){
            var deleteData = {};
            deleteData.id = $(this).data("moleculeId");
            deleteData.ownerId = $(this).data("ownerId");
            deleteData._method = "DELETE"

            $.ajax({
                type:"DELETE",
                url: DELETE_URL + "/" + deleteData.id,
                data: deleteData,
                success: function(response) {
                    console.log("Molecula removida com sucesso.");
                    console.log(response);
                },
                error: function(error) {
                    console.log("Um erro ocorreu.");
                    console.log(error);
                }
            });
        });
        window.location.reload(true);
    });
});


