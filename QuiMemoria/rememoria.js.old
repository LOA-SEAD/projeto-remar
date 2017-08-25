/* Created by garciaph */
var difficultyList = ['', 'Fácil', 'Médio', 'Difícil'];

$(document).ready(function() {
    // Initialize materialize elements
    $('.tooltipped').tooltip({
        delay: 50,
        position: 'top',
        tooltip: $(this).data('tooltip-msg')
    });

    $('select').material_select();

    // Initially load list with easy difficulty
    var difficulty = 1; // 1 = Easy; 2 = Medium; 3 = Hard
    $('#difficulty-level').html('Fácil');
    renderSelect(difficulty);

    $('#decrease-level').click(function() {
        if (difficulty > 1) {
            // Set difficulty level
            difficulty = difficulty - 1;
            $('#tile-display-container').html('').animate({height: 0}, 600, 'easeOutBounce');
            $('#difficulty-level').html(difficultyList[difficulty]);
            renderSelect(difficulty);
        }
    });

    $('#increase-level').click(function() {
        if (difficulty < 3) {
            // Set difficulty level
            difficulty = difficulty + 1;
            $('#tile-display-container').html('').animate({height: 0}, 600, 'easeOutBounce');
            $('#difficulty-level').html(difficultyList[difficulty]);
            renderSelect(difficulty);
        }
    });

    // Textarea behavior
    $('textarea')
        // stops accepting input after reaching it's maximum length
        .keypress(function(e) {
            if (e.which < 0x20) {
                // e.which < 0x20, then it's not a printable character
                // e.which === 0 - Not a character
                return;     // Do nothing
            }
            if (this.value.length == $(this).attr('length')) {
                e.preventDefault();
            } else if (this.value.length > $(this).attr('length')) {
                // Maximum exceeded
                this.value = this.value.substring(0, $(this).attr('length'));
            }
        })
        // slices input if pasted content exceeds character limit
        .on('paste', function(e) {
            e.clipboardData.getData('text/plain').slice(0, $(this).attr('length'));
        });

    // Change which model the user will download based on what tile presentation option was chosen
    // Since it's a checkbox, it has checked or not checked states (true or false)
    // True = Horizontal
    // False = Vertical
    $('.switch :checkbox').change(function() {
        if (this.checked) {
            $('#model-download').attr('href', '/quimemoria/samples/tilesample_h.zip');
        } else {
            $('#model-download').attr('href', '/quimemoria/samples/tilesample_v.zip');
        }
    });

    // Send all tiles to controller
    $('#send').click(function() {
        // Orientation of tiles. Same as above.
        var orientation = $('.switch :checkbox').checked ? 'h' : 'v';

        // Check if there the minimum tile number is achieved for each difficulty
        // If is its valid, proceed to the json file generation (controller)
        // Otherwise, show modal with error
        $.ajax({
            type: 'GET',
            data: {orientation: orientation},
            url: "validate",
            success: function (resp) {
                $('#fail-modal .modal-content p').html(resp);
                $('#fail-modal').openModal();
            },
            error: function (request, status, error) {
                console.log('ERROR');
            }
        });
    });
});

function renderSelect (difficulty) {
    var $container = $('#difficulty-select-container');

    // Get the tile list of given difficulty
    $.ajax({
        type: 'GET',
        data: {difficulty: difficulty},
        url: "listByDifficulty",
        success: function (resp) {
            $container.html(resp);
            $container.children('select').material_select();

            // After selecting the desired tile from the select in index.gsp,
            // we get the information of that tile and show it in the tile display
            $('#difficulty-select-container select').change(function() {
                var id = $(this).val();
                renderTile(id);
            });
        },
        error: function (request, status, error) {
            console.log(error);
        }
    });
}

function renderTile (tileId) {
    var $container = $('#tile-display-container');

    $.ajax({
        type: 'POST',
        data: {id: tileId},
        url: "show",
        success: function (resp) {
            $container.html(resp);
            $container.animate({height: '300'}, 600, 'easeOutBounce');
        },
        error: function (request, status, error) {
            console.log(error);
        }
    });
}