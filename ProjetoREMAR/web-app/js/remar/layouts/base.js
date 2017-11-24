// Initialization of base elements, like materialize components

$(document).ready(function () {
    $('.dropdown-button').dropdown({alignment: 'left'});
    $('.tooltipped').tooltip({delay: 50});
    $('.collapsible').collapsible();
    $('.material-select').material_select();
    $('.materialboxed').materialbox();
    $('.button-collapse').sideNav();
    $('.modal-trigger').leanModal({
        dismissible: false
    });
});

function startWizard() {
    if (window.innerWidth > 992) { //desktop
        introJs().start();
    }
}