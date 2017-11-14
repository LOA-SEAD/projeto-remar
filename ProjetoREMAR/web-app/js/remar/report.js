/**
 * Created by garciaph on 27/10/17.
 */

$(document).ready(function () {
    $('#report-fsm-cancel').click(resetFormStateMachine);

    $('#ss-btn').click(initHTML2canvas);

    $('#report-modal form').on('submit', function (e) {
        // catch submit event and prevent it, not refreshing the page
        e.preventDefault();

        $.ajax({
            url    : $(this).attr('action'),
            type   : 'POST',
            data   : {
                type: $('[type="radio"]:checked', '#report-modal').val(),
                description: $('[name="description"]', '#report-modal').val(),
                url: window.location.href,
                browser: detectBrowser(),
                screenshot: $('#img-val', '#report-modal').val()
            }
        });
    });

    $('#report-fsm-finish').click(function() {
        $('#report-modal form').submit();
        resetFormStateMachine();
    });
});

function initHTML2canvas() {
    var el = $('#target').get(0);

    $('#sidenav-overlay').attr('data-html2canvas-ignore', 'true');
    $('.lean-overlay').attr('data-html2canvas-ignore', 'true');
    $('.drag-target').attr('data-html2canvas-ignore', 'true');

    html2canvas(el, {
        onrendered: function (canvas) {
            $('#img-val').val(canvas.toDataURL('image/png'));
            $('div.screenshot-preview', '#report-form').html(canvas);
        }
    });
}

function resetFormStateMachine() {
    $('#report-modal .fsm').finiteStateMachine('reload');
    $('#report-modal #report-fsm-finish').hide();
    $('#report-modal #report-fsm-next').hide();
    $('#report-modal #report-fsm-prev').hide();
    $('#report-modal canvas').addClass('screenshot-preview-placeholder');

    $('#ss-btn').click(initHTML2canvas);
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
    }
}