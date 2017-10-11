/* Created by garciaph */

// TODO: implementar loading screen de 0.5~1,0 segundo para permitir o carregamento das imagens sem mostrar uma animação 'bugada' para o usuário

var difficultyList = ['', 'Fácil', 'Médio', 'Difícil'];

$(document).ready(function() {
    // Pre-defined loading time
    setTimeout(function() {
        $('#loading-screen').fadeOut(1000, function() {
            $(this).hide();
        });
    }, 1000);

    // initialize materialize elements
    $('.tooltipped').tooltip({
        delay: 50,
        position: 'top',
        tooltip: $(this).data('tooltip-msg')
    });
    $('select').material_select();

    // initially load list with easy difficulty
    var difficulty = 1; // 1 = Easy; 2 = Medium; 3 = Hard
    $('#difficulty-level').html('Fácil');
    renderSelect(difficulty);
    $('#decrease-level').attr('disabled', 'disabled')

    $('#decrease-level').click(function() {
        if (difficulty > 1) {
            // Set difficulty level
            difficulty = difficulty - 1;
            renderSelect(difficulty);

            if (difficulty <= 1) $('#decrease-level').attr('disabled', 'disabled');
            if (difficulty < 3) $('#increase-level').removeAttr('disabled');
        }
    });

    $('#increase-level').click(function() {
        if (difficulty < 3) {
            // set difficulty level
            difficulty = difficulty + 1;
            renderSelect(difficulty);

            if (difficulty >= 3) $('#increase-level').attr('disabled', 'disabled');
            if (difficulty > 1) $('#decrease-level').removeAttr('disabled');
        }
    });


    // change which model the user will download based on what tile presentation option was chosen
    // since it's a checkbox, it has checked or not checked states (true or false)
    // true = horizontal
    // false = vertical
    $('.switch :checkbox').change(function() {

        if ($('.switch :checkbox').prop('checked')) {
            fadeInOut($('#model-orientation'), 'horizontal');
            $('#model-download').attr('href', '/memoria/samples/tilesample_h.zip');
            sessionStorage.setItem("SessionOrientation", "h");
        } else {
            fadeInOut($('#model-orientation'), 'vertical');
            $('#model-download').attr('href', '/memoria/samples/tilesample_v.zip');
            sessionStorage.setItem("SessionOrientation", "v");
        }
    });

    // if the user had set the orientation to "h" before, we should forcely click
    // the switch via code whenever the page loads
    if (sessionStorage.getItem("SessionOrientation") == "h")
        $('.switch :checkbox').click();


    // send all tiles to controller
    $('#send').click(function() {
        // orientation of tiles. Same as above.
        var orientation = $('.switch :checkbox').prop('checked') ? 'h' : 'v';
        // activates load screen
        $('#loading-screen').show();

        // proceed to the img file generation (controller)
        // otherwise, show modal with error
        $.ajax({
            type: 'GET',
            async: false,
            data: {orientation: orientation},
            url: "validate",
            success: function (resp) {
                $('#loading-screen').hide();
                window.top.location.href = resp;
            },
            error: function (xhr, status, text) {
                $('#fail-modal .modal-content p').html(text);
                $('#fail-modal').modal('open');
                console.log(text);
            }
        });
    });


});

// show the selected difficulty select field with all the tiles options
function renderSelect (difficulty) {
    var $container = $('#difficulty-select-container');
    var $display = $('#tile-display');

    $container.empty(400);

    $('#difficulty-minimum').html(difficulty);
    $('#difficulty-level').html(difficultyList[difficulty]);

    // get the tile list of given difficulty
    $.ajax({
        type: 'GET',
        data: {difficulty: difficulty},
        url: 'listByDifficulty',
        success: function (resp) {
            $('#difficulty-select-message').fadeIn(0);
            $container.html(resp).fadeIn().find('select').material_select();

            // show first tile
            renderTile($("select option:first").val());

            // after selecting the desired tile from the select in index.gsp,
            // we get the information of that tile and show it in the tile display
            $('#difficulty-select-container select').change(function () {
                var id = $(this).val();
                renderTile(id);
            });

            // update total counter
            $('#difficulty-total').html($('select option').size());
        },
        error: function (xhr, status, text) {
            switch (xhr.status) {
                case 412:
                    // show warning message if there aren't any tiles
                    $('#difficulty-select-message').fadeOut(0);
                    fadeInOut($display, xhr.responseText);
                    break;
                default:
                    console.log(text);
                    break;
            }
        }
    });
}

// renders tile pair information inside specified display element
function renderTile (tileId) {
    var $display = $('#tile-display');

    $.ajax({
        type: 'POST',
        data: {id: tileId},
        url: 'show',
        success: function (resp) {
            fadeInOut($display, resp, function() {
                // resize images orientation-wise
                var width = $('#default-image-sizes').css('width');
                var height = $('#default-image-sizes').css('height');

                $('.materialboxed').materialbox().each(function () {
                    resizeImageOrientationWise($(this), height, width);
                });

                // initialize Modal
                $('#delete-modal').modal();

                // Initializing tooltips
                $('#tile-options-column').find('.tooltipped').each(function() {
                    console.log($(this));
                    $(this).tooltip({
                        delay: 50,
                        position: 'left',
                        tooltip: $(this).data('tooltip-msg')
                    });
                });
            });
        },
        error: function (request, status, error) {
            console.log(error);
        }
    });
}

// fade out, change content, do something with the content if necessary and then fade in
function fadeInOut ($el, content, callback) {
    // hide element
    $el.animate({opacity: 0}, function() {
        // update content
        $el.html(content);

        // if there is a callback function, execute it
        callback = callback || null;
        if (callback) callback();

        // show element with new content
        $el.animate({opacity: 1});
    });
}

function resizeImageOrientationWise($el, height, width) {
    $el.load(function () {
        var eWidth = $el.width();
        var eHeight = $el.height();

        // note that it must be $.attr instead of $.css because of materialize materialbox
        if (eWidth > eHeight) {
            // landscape
            $el.attr('width', width);
        } else {
            //portrait
            $el.attr('height', height);
        }
    });
}
