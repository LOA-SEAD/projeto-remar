/**
 * Created by garciaph on 11/09/17.
 */

$(document).ready(function () {
    var $table        = $('#reports-table');
    var $tableButtons = $('.toggleable');

    $table.pageMe({
        pagerSelector  : '#reports-table-pager',
        activeColor    : '#5d4037',
        showPrevNext   : true,
        hidePageNumbers: false,
        perPage        : 5
    });
    
    $('.warning-box .btn-flat:nth-child(2)').click(function () {
        $('.warning-box').slideUp(500);
    });

    $('#select-all-checkbox').change(function () {
        var checked = this.checked;

        $('#reports-table td input[type="checkbox"]').each(function () {
            $(this).prop('checked', checked);
        });

        if (checked) $tableButtons.domEnable();
        else $tableButtons.domDisable();
    });

    $('#reports-table td input[type="checkbox"]').change(function () {
        var checkedCB   = $('#reports-table input:checkbox:checked').length;
        var totalCB     = $('#reports-table input:checkbox').length;
        var uncheckedCB = totalCB - checkedCB;

        if (!this.checked) {
            // if one box is unchecked after the 'select all checkbox' was checked, uncheck it too
            $('#select-all-checkbox').prop('checked', false);

            if (checkedCB == 0) $tableButtons.domDisable();
        } else {
            // if this is the last unchecked box, check the 'select all checkbox'
            if (uncheckedCB == 0) $('#select-all-checkbox').prop('checked', true);

            if ($tableButtons.attr('disabled') == 'disabled') $tableButtons.domEnable();
        }
    });

    $('')
});

$.fn.domDisable = function () {
    this.attr('disabled', 'disabled');
};

$.fn.domEnable = function () {
    this.removeAttr('disabled');
};
