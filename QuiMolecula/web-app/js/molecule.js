/**
 * Created by garciaph on 24/07/17.
 */

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
                $( '#delete-btn' ).removeClass('disabled');
            } else {
                $( '#delete-btn' ).addClass('disabled');
            }
        });
});


