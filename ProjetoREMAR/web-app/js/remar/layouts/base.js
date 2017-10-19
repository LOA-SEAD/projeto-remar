$(document).ready(function () {
    // Materialize Inits
    $('.modal-trigger').leanModal();
    $('.tooltipped').tooltip({delay: 50});
    $(".button-collapse").sideNav();
    $('.dropdown-button').dropdown({
        alignment: 'left'
    });
    $('.collapsible').collapsible();
    $('.material-select').material_select();

    var $prevState;
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