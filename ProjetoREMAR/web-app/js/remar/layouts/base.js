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
        prevSelector: '#report-fsm-prev',
        before: function() {
            $prevState = $('.fsm').getCurrentState();
        },
        callback: function() {
            var $currentState = $('.fsm').getCurrentState();

            if ($prevState.hasClass('fsm-initial')) {
                fadeInOut($('#report-fsm-cancel'), $('#report-fsm-prev'));
            } else if ($prevState.hasClass('fsm-final')) {
                fadeInOut($('#report-fsm-finish'), $('#report-fsm-next'));
            } else if ($currentState.hasClass('fsm-initial')) {
                fadeInOut($('#report-fsm-prev'), $('#report-fsm-cancel'));
            } else if ($currentState.hasClass('fsm-final')) {
                fadeInOut($('#report-fsm-next'), $('#report-fsm-finish'));
            }
        }
    });

});

function startWizard() {
    if (window.innerWidth > 992) { //desktop
        introJs().start();
    }
}

function fadeInOut($foEl, $fiEl) {
    // hide element
    $foEl.fadeOut(500, function () {
        // update content
        $fiEl.fadeIn(500);
    });
}