/**
 * Created by garciaph on 27/10/17.
 */

$(document).ready(function () {
    $('textarea', '#report-form').characterCounter();

    $('#report-form.fsm', '#report-modal').finiteStateMachine({
        nextSelector: '.report-fsm-next',
        prevSelector: '#report-fsm-prev'
    });

    $('#ss-btn').click(initHTML2canvas);

    $('#report-fsm-cancel').click(function() {
        resetFormStateMachine();
    });

    $('#report-fsm-prev').click(function() {
        // If it comes from state 2, it means that we are now at the initial state
        // So reload the machine
        if ($('.active-state', '#report-form').data('state') == 2) {
            $('#report-form').fadeOut(function() {
                resetFormStateMachine();
            });
        }
    });
});

$.fn.copy = function () {
    var $clone = this.clone();

    $clone.insertAfter(this);
    this.remove();

    return $clone;
};

function initHTML2canvas() {
    $('#sidenav-overlay').attr('data-html2canvas-ignore', 'true');
    $('.lean-overlay').attr('data-html2canvas-ignore', 'true');
    $('.drag-target').attr('data-html2canvas-ignore', 'true');

    html2canvas(document.body, {
        type: 'view',
        onrendered: function (canvas) {
            $('#img-val').val(canvas.toDataURL('image/png'));
            $('div.screenshot-preview', '#report-form').html(canvas);
        }
    });
}

function resetFormStateMachine() {
    // Reload buttons
    $('#report-fsm-prev').copy()
        .hide()
        .click(function() {
            if ($('.active-state', '#report-form').data('state') == 2) {
                $('#report-form').fadeOut(function () {
                    resetFormStateMachine();
                });
            }
        });
    $('#report-fsm-next').copy()
        .hide();
    $('#report-fsm-finish').hide();

    // Reload form state machine
    $('#report-form').finiteStateMachine('reload');

    // New canvas
    $('canvas', '#report-modal').remove();
    $('.screenshot-preview', '#report-modal').append('<canvas class="screenshot-preview-placeholder" width="1855" height="985"></canvas>');
    $('canvas', '#report-modal').addClass('screenshot-preview-placeholder');

    // Reinitialize screenshot button
    $('#ss-btn')
        .unbind()
        .click(initHTML2canvas);

    // Clear fields
    $('textarea', '#report-form').val('');


    // GAMBIARRA
    $('.fsm-initial', '#report-form').removeAttr('style');
    $('#report-final-message').removeClass('hide');
    $('#report-modal .modal-footer').removeClass('hide');
    $('#report-loading').addClass('hide');
    $('.error-box', '#report-form').addClass('hide');
    // END OF GAMBIARRA

    $('#report-form').fadeIn();
}

function detectBrowser() {
    var ua = navigator.userAgent, tem,
        M  = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if (/trident/i.test(M[1])) {
        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
        return 'IE ' + (tem[1] || '');
    }
    if (M[1] === 'Chrome') {
        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
    }
    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
    return M.join(' ');
}

function fsmEval() {
    var type = null;

    // 1 - Type select
    // 2 - Description
    // 3 - Screenshot
    // 4 - Finish
    // X - Non-existent: do nothing
    switch ($('#report-form').finiteStateMachine('getCurrentState').data('state')) {
        case 1:
            return 2;
        case 2:
            if ($('input[type=radio]:checked', '#report-form').val() == 'comment')
                return 4;
            else
                return 3;
        case 3:
            return 4;
        case 4:
            if ($('[name="description"]', '#report-modal').val() == '') {
                $('.error-box', '#report-form').removeClass('hide');
                return 2;
            } else {
                $('#report-final-message').addClass('hide');
                $('.modal-footer', '#report-modal').addClass('hide');
                $('#report-loading').removeClass('hide');

                // send information via ajax
                $.ajax({
                    url    : $('#report-form').parent().attr('action'),
                    type   : 'POST',
                    data   : {
                        type       : $('[type="radio"]:checked', '#report-modal').val(),
                        description: $('[name="description"]', '#report-modal').val(),
                        url        : window.location.href,
                        browser    : detectBrowser(),
                        screenshot : $('#img-val', '#report-modal').val()
                    },
                    success: function (resp) {
                        // On success, just close modal and reset it afterwards
                        $('#report-modal').closeModal();
                        resetFormStateMachine();
                    }
                });

                return 'x';
            }
            break;
    }
}