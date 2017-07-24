/**
 * Created by garciaph on 24/07/17.
 */

$(document).ready(function () {
    $( ".sortable" ).sortable({ connectWith: '.connected-sortable' });
    $( ".sortable" ).disableSelection();

    $("#available-molecules li")
        .mousedown(function() {
            $(this).css('cursor', 'move');
        })
        .mouseup(function() {
            $(this).css('cursor', 'pointer');
        })
        .click(function() {
            alert('clicked!');
        });
});


