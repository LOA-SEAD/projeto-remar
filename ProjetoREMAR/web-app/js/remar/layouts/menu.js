/**
 * Created by garciaph on 29/09/17.
 */

$(document).ready(function() {
    $('.sidenav li a[href="' + window.location.pathname + '"]').parent().addClass('active');
});