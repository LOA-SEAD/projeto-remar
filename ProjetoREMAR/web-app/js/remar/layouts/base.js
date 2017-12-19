// Initialization of base elements, like materialize components

$(document).ready(function () {
    $('.dropdown-button').dropdown({alignment: 'left'});
    $('.tooltipped').tooltip({delay: 50});
    $('.collapsible').collapsible();
    $('.material-select').material_select();
    $('.materialboxed').materialbox();
    $('.button-collapse').sideNav();
    $('.modal').modal({
        dismissible: false
    });

    // Close warning-boxes
    $('button.close-warning').click(function() {
        $(this).closest('.warning-box').slideUp();
    });
});

function startWizard() {
    if (window.innerWidth > 992) { //desktop
        introJs().start();
    }
}