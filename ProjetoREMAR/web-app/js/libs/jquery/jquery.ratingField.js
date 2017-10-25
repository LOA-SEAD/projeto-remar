/**
 * Created by garciaph on 23/10/17.
 */

$.fn.ratingField = function(opt) {
    var $field      = $(this);
    var $el         = $('<i class="material-icons small score-icon"></i>');
    var scoreClass  = 'rating--score';
    var newClass    = 'rating--new';
    var bgClass     = 'rating--background';
    var userRating  = $field.data('user-rating') ? parseFloat($field.data('user-rating')) : 0;

    switch (opt) {
        case 'init':
            init();
            break;
        case 'reload':
            reload(userRating);
            break;
        default:
            console.log('not a valid option');
            break;
    }

    function initializeStars(rating) {
        // Star initialization
        var ratingInteger = Math.floor(rating);
        console.log(rating);
        if (ratingInteger == rating) /* if rating is x.0 */ {
            // fill stars entirely up to the x-th star
            for (i = 1; i <= rating; i++) {
                $el
                .clone(true)
                .html('star')
                .addClass(scoreClass)
                .data('score', i)
                .appendTo($field);
            }

            // don't fill any stars from the (x + 1)-th upwards
            for (i = rating + 1; i <= 5; i++) {
                $el
                .clone(true)
                .html('star_border')
                .addClass(bgClass)
                .data('score', i)
                .appendTo($field);
            }
        } else /* if rating is x.xx */ {
            // fill stars entirely up to the x-th star
            for (i = 1; i <= ratingInteger; i++) {
                $el
                .clone(true)
                .html('star')
                .addClass(scoreClass)
                .data('score', i)
                .appendTo($field);
            }

            // fill half of (x + 1)-th star
            $el
            .clone(true)
            .html('star_half')
            .addClass(scoreClass)
            .data('score', i)
            .appendTo($field);

            // don't fill any stars from the (x + 2)-th upwards
            for (i = (ratingInteger + 2); i <= 5; i++) {
                $el
                .clone(true)
                .html('star_border')
                .addClass(bgClass)
                .data('score', i)
                .appendTo($field);
            }

        }
    }

    function init() {
        var i = 0;

        $el.addClass(scoreClass);
        $el.addClass('rating-editable');

        $field.mouseleave(function () {
            reload(userRating);
        });

        $el.mouseenter(function () {
            var rating = $(this).data('score');

            for (i = 1; i <= rating; i++) {
                $('.score-icon:nth-child(' + i + ')')
                .html('star')
                .removeClass(bgClass)
                .addClass(newClass);
            }

            for (i = rating + 1; i <= 5; i++) {
                $('.score-icon:nth-child(' + i + ')')
                .html((userRating >= i) ? 'star' : 'star_border')
                .removeClass(newClass)
                .addClass((userRating >= i) ? scoreClass : bgClass);
            }
        });

        $el.click(function () {
            var rating = $(this).data('score');
            var url    = (userRating > 0) ? '/resource/asyncUpdateRating' : '/resource/asyncSaveRating';
            console.log(url);

            $.ajax({
                type   : 'POST',
                url    : url,
                data   : {
                    userid    : $field.data('user-id'),
                    resourceid: $field.data('resource-id'),
                    rating    : rating * 10
                },
                success: function (resp) {
                    Materialize.toast('Obrigado por sua avaliação!', 1000);

                    reload(rating);
                }
            });
        });

        initializeStars(userRating);
    }

    function reload(rating) {
        userRating = rating;
        $field.empty();
        initializeStars(rating);
    }

};