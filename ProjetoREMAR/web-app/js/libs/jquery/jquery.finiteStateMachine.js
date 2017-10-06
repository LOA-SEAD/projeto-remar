/*
 Finite State Machine Plugin for jQuery (by Pedro Garcia)
 Version: 1.0
 http://phgarcia.com
 This plugin is offered under the MIT license.
 Copyright (c) 2017 Pedro Henrique Romaoli Garcia, http://phgarcia.mit-license.org
 */

(function ($) {

    $.fn.finiteStateMachine = function (options) {
        var settings = $.extend({
            stateSelector  : '.fsm-state',
            nextSelector   : '.fsm-next',
            prevSelector   : '.fsm-prev',
            initialSelector: '.fsm-initial',
            finalSelector  : '.fsm-final',
            fadeSpeed      : 300,
            linear         : false,
            before         : null,
            after          : null,
            callback       : null
        }, options);

        var $fsm         = this;
        var $states      = $fsm.find(settings.stateSelector);
        var $next_button = $(settings.nextSelector);
        var $prev_button = $(settings.prevSelector);

        var stateData = $states.map(function () {
            return $(this).hide().data('state');
        }).get();

        var stateStack = []; // for complex machine behavior

        if (settings.linear) {
            // Simple machine behavior
            var start      = Math.min.apply(Math, stateData);
            var end        = Math.max.apply(Math, stateData)
            var curr_state = start;

            $fsm.getState(curr_state).show();
            $prev_button.prop('disabled', true);

            $next_button.click(function () {
                if (settings.before)
                    settings.before();

                $prev_button.prop('disabled', false);

                $fsm.getState(curr_state).fadeOut(settings.fadeSpeed, function () {
                    do {
                        curr_state++;
                    } while ($fsm.getState(curr_state).length == 0);

                    if (settings.after)
                        settings.after();

                    $fsm.getState(curr_state).fadeIn(settings.fadeSpeed);

                    if (curr_state == end)
                        $next_button.prop('disabled', true);

                    if (settings.callback)
                        settings.callback();
                });
            });

            $prev_button.click(function () {
                if (settings.before)
                    settings.before();

                $next_button.prop('disabled', false);

                $fsm.getState(curr_state).fadeOut(settings.fadeSpeed, function () {
                    do {
                        curr_state--;
                    } while ($fsm.getState(curr_state).length == 0);

                    if (settings.after)
                        settings.after();

                    $fsm.getState(curr_state).fadeIn(settings.fadeSpeed);

                    if (curr_state == start)
                        $prev_button.prop('disabled', true);

                    if (settings.callback)
                        settings.callback();
                });
            });
        } else {
            // Complex machine behavior
            var $curr_state = $fsm.find(settings.initialSelector);
            $curr_state.show();
            $prev_button.prop('disabled', true);

            $next_button.click(function () {
                if (settings.before)
                    settings.before();

                stateStack.push($curr_state);
                $prev_button.prop('disabled', false);

                var next_state = window[$curr_state.data('evaluator')]();
                $curr_state.fadeOut(settings.fadeSpeed, function () {
                    $curr_state = $fsm.getState(next_state);

                    if (settings.after)
                        settings.after();

                    $curr_state.fadeIn(settings.fadeSpeed);

                    if ($(settings.finalSelector).is($curr_state))
                        $next_button.prop('disabled', true);

                    if (settings.callback)
                        settings.callback();
                });
            });

            $prev_button.click(function () {
                if (settings.before)
                    settings.before();

                $next_button.prop('disabled', false);

                var $next_state = stateStack.pop();
                $curr_state.fadeOut(settings.fadeSpeed, function () {
                    $curr_state = $next_state;

                    if (settings.after)
                        settings.after();

                    $curr_state.fadeIn(settings.fadeSpeed);

                    if ($(settings.initialSelector).is($curr_state))
                        $prev_button.prop('disabled', true);

                    if (settings.callback)
                        settings.callback();
                });
            });
        }

        $fsm.addClass('fsmachined');
    };

    $.fn.getState = function (index) {
        return this.find('.fsm-state[data-state="' + index + '"]');
    };

    $.fn.getCurrentState = function () {
        return this.find('.fsm-state:visible');
    };

}(jQuery));