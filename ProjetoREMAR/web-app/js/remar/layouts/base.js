// Initialization of base elements, like materialize components

$(document).ready(function () {
    $('.dropdown-button').dropdown({alignment: 'left'});
    $('.tooltipped').tooltip({delay: 50});
    $('.collapsible').collapsible();
    $('.material-select').material_select();
    $('.materialboxed').materialbox();
    $('.button-collapse').sideNav();
    $('.modal-trigger').leanModal();

    $('.fsm').finiteStateMachine({
        nextSelector: '.report-fsm-next',
        prevSelector: '#report-fsm-prev'
    });
});

function startWizard() {
    if (window.innerWidth > 992) { //desktop
        introJs().start();
    }
}