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

    $('.id-field a').click(function() {
        var reportId = $(this).data('id');
        $.ajax({
            url    : '/report/getReport',
            type   : 'get',
            data   : {id: reportId},
            dataType: 'json',
            success: function (resp) {
                $('#modal-report-id').html(reportId);
                $('#modal-report-user').html(resp.who);
                $('#modal-report-date').html(resp.date);
                $('#modal-report-browser').html(resp.browser);
                $('#modal-report-url').html(resp.url);
                $('#modal-report-type').html(resp.type);
                $('#modal-report-description').html(resp.description);

                Materialize.updateTextFields();

                if (resp.hasScreenshot) {
                    var filename = '/data/report-screenshots/' + reportId + '.png';
                    var downloadFilename = reportId +'-screenshot.png';

                    $('#modal-report-ss').attr('src', filename);
                    $('a', '#modal-report-ss-container')
                        .attr('href', filename)
                        .attr('download', downloadFilename);
                    $('#modal-report-ss-container').show();
                } else {
                    $('#modal-report-ss-container').hide();
                }

                $('#report-information-modal').openModal({
                    dismissible: false
                });
            }
        });
    });

    $('[name="sort-reports"]').change(function() {
        var $table = $('#reports-table').parent(),
            tableFields = [
                'date-field',       // 0
                'id-field',         // 1
                'name-field',       // 2
                'browser-field',    // 3
                'type-field',       // 4
                'solved-field',     // 5
                'action-field'      // 6
            ],
            keySelector = 'td.';

        if (this.value < 5) {
            keySelector += tableFields[this.value];

            $table.tableSort({
                keySelector: keySelector
            });
        } else if (this.value < 7) {
            // Sort by 'solved' and 'not solved'
            keySelector += tableFields[5];

            $table.tableSort({
                keySelector: keySelector,
                mode: (this.value == 5) ? 'decreasing' : 'increasing',
                origin: 'data',
                dataLabel: 'solved'
            });
        } else {
            // Sort by 'seen' and 'not seen'
            keySelector += tableFields[6];

            $table.tableSort({
                keySelector: keySelector,
                mode: (this.value == 7) ? 'decreasing' : 'increasing',
                origin: 'data',
                dataLabel: 'seen'
            });
        }


    });
});

$.fn.domDisable = function () {
    this.attr('disabled', 'disabled');
};

$.fn.domEnable = function () {
    this.removeAttr('disabled');
};
