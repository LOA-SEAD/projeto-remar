/**
 * Created by garciaph on 29/09/17.
 */

$(document).ready(function() {
    $('.modal-trigger').leanModal({
        dismissable: true,
        complete   : function () {
            $('.lean-overlay').remove();
        }
    });
    $('.sidenav li a[href="' + window.location.pathname + '"]').parent().addClass('active');
});