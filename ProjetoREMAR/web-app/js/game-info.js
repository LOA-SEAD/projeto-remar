/**
 * Created by Rener on 11/04/16.
 */

$(document).ready(function() {
    $('.tooltipped').tooltip({delay: 35});

    $('.collapsible').collapsible({
        accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
    });

    var mySwiper = new Swiper ('.swiper-container', {
        // Optional parameters
        direction: 'horizontal',

        // Navigation arrows
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',

        slidesPerView: 'auto',

        spaceBetween: 5,

        centeredSlides: true,

        //simulateTouch: false,

        slideToClickedSlide: true,

        paginationHide: true,

        hashnav: true,

        onSlideChangeEnd: function (swiper) {
            fillTable($('.swiper-slide-active').attr('data-hash'));
        }
    });

    //$('#game-stat')
    fillTable($('.swiper-slide-active').attr('data-hash'));

    function fillTable(resourceId) {
        $.ajax({
            url: '/exported-resource/_table.gsp',
            type: 'POST',
            data: { resourceId: resourceId },
            success: function(data, status) {
                $('.game-stat').html(data);
            },
            error: function(data) {
            }
        });
    }

});