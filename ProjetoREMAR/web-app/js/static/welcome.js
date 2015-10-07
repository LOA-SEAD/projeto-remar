/**
 * Created by matheus on 10/7/15.
 */
$(window).load(function() {
    setInterval(countdown, 1000);
    setTimeout(redirect, 3000);
});

function countdown() {
    var countdown = $("#countdown");
    $(countdown).html(parseInt($(countdown).html()) -1 );
}

function redirect() {
    window.location.href = "/dashboard";
}