/**
 * Created by garciaph on 11/09/17.
 *
 *
 * ALL VARIABLES STARTING WITH "m_" ARE DECLARED IN THE .GSP FILE
 */

$(document).ready(function () {
    var $table        = $('#reports-table');
    var $archiveTable = $('#archived-reports-table');
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

    // Remove Button Behaviour
    $('a[id^="remove-report"]').click(function () {
        var $row           = $(this).closest('tr');
        var id             = $row.data('report-id');
        var warningMessage = m_adminReportsWarning + '&nbsp;<strong>' + id + '</strong>?';

        $('#warning-box-message').html(warningMessage);
        $('.warning-box .btn-flat:first-child').unbind().click(function () {
            $.ajax({
                url    : "/admin/deleteReport",
                type   : 'post',
                data   : {id: id},
                success: function (resp) {
                    $row.remove();
                    $('#reports-table').reloadMe();
                    Materialize.toast(m_adminReportsRemoved, 2000);
                    $('.warning-box').slideUp(500);
                }
            });
        });
        $('.warning-box').slideDown(500);
    });

    // Batch Remove Button Behaviour
    $('a#batch-remove-button').click(function () {
        $('#warning-box-message').html(m_adminReportsWarningBatch);
        $('.warning-box .btn-flat:first-child').unbind().click(function () {
            var reportIdList = [];

            $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
                $(this).remove();
                reportIdList.push($(this).data('report-id'));
            });

            $.ajax({
                url    : '/admin/deleteReportBatch',
                type   : 'get',
                data   : {reportIdList: JSON.stringify(reportIdList)},
                success: function (resp) {
                    $('#reports-table').reloadMe();
                    Materialize.toast(m_adminReportsRemovedBatch, 2000);
                    $('.warning-box').slideUp(500);
                }
            });
        });
        $('.warning-box').slideDown(500);
    });

    // Seen Toggle Behaviour
    $('.seen-toggle', '#reports-table').click(function () {
        var $button      = $(this);
        var $row         = $(this).closest('tr');
        var $statusField = $row.find('.solved-field');
        var id           = $row.data('report-id');

        $.ajax({
            url    : '/report/toggleSeenStatus',
            type   : 'post',
            data   : {id: id},
            success: function (resp) {
                if (resp == 'seen') {
                    $row.addClass('grey-text text-darken-1');
                    $button.addClass('active');
                    Materialize.toast(m_adminReportsMarkedAsSeenToast, 2000);
                } else if (resp == 'unseen') {
                    $row.removeClass('grey-text text-darken-1');
                    $button.removeClass('active');

                    if ($('.solved-toggle', $row).hasClass('active')) {
                        $('.solved-toggle', $row).removeClass('active');

                        $statusField.fadeOut(function () {
                            $statusField.html('<i class="material-icons remar-red-text">close</i>');
                            $statusField.fadeIn();
                        });
                    }

                    Materialize.toast(m_adminReportsMarkedAsUnseenToast, 2000);
                }
            },
            error  : function (xhr, text, error) {
                if (xhr.status == 422)
                    Materialize.toast(m_adminReportsToggleSeenFailToast, 2000);
            }
        });
    });

    // Solved Toggle Behaviour
    $('.solved-toggle', '#reports-table').click(function () {
        var $button      = $(this);
        var $row         = $(this).closest('tr');
        var $statusField = $row.find('.solved-field');
        var id           = $row.data('report-id');

        $.ajax({
            url    : '/report/toggleSolvedStatus',
            type   : 'post',
            data   : {id: id},
            success: function (resp) {
                if (resp == 'solved') {
                    $row.addClass('grey-text text-darken-1');
                    $button.addClass('active');

                    $statusField.fadeOut(function () {
                        $statusField.html('<i class="material-icons remar-green-text">check</i>');
                        $statusField.fadeIn();
                    });

                    if (!$('.seen-toggle', $row).hasClass('active'))
                        $('.seen-toggle', $row).addClass('active');

                    Materialize.toast(m_adminReportsMarkedAsSolvedToast, 2000);
                } else if (resp == 'unsolved') {
                    $button.removeClass('active');
                    $statusField.fadeOut(function () {
                        $statusField.html('<i class="material-icons remar-red-text">close</i>');
                        $statusField.fadeIn();
                    });
                    Materialize.toast(m_adminReportsMarkedAsUnsolvedToast, 2000);
                }
            },
            error  : function (xhr, text, error) {
                if (xhr.status == 422)
                    Materialize.toast(m_adminReportsToggleSolvedFailToast, 2000);
            }
        });
    });

    // Batch Mark as Seen Behaviour
    $('#batch-markAsSeen-button').click(function () {
        var reportIdList = [];

        $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
            $(this).addClass('grey-text text-darken-1');
            $('.seen-toggle', this).addClass('active');
            reportIdList.push($(this).data('report-id'));
        });

        $.ajax({
            url    : '/report/batchMarkAsSeen',
            type   : 'get',
            data   : {reportIdList: JSON.stringify(reportIdList)},
            success: function (resp) {
                var $toastContent = $('<span>' + resp + ' ' + m_adminReportsMarkAsSeenBatch + '</span>');
                Materialize.toast($toastContent, 2000);
            }
        });
    });

    // Batch Mark as Unseen Behaviour
    $('#batch-markAsUnseen-button').click(function () {
        var reportIdList = [];

        $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
            var $statusField = $('.solved-status-field', this);

            $(this).removeClass('grey-text text-darken-1');
            $('.seen-toggle', this).removeClass('active');

            if ($('.solved-toggle', this).hasClass('active')) {
                $('.solved-toggle', this).removeClass('active');

                $statusField.fadeOut(function () {
                    $statusField.html('<i class="material-icons remar-red-text">close</i>');
                    $statusField.fadeIn();
                });
            }

            reportIdList.push($(this).data('report-id'));
        });

        $.ajax({
            url    : '/report/batchMarkAsUnseen',
            type   : 'get',
            data   : {reportIdList: JSON.stringify(reportIdList)},
            success: function (resp) {
                var $toastContent = $('<span>' + resp + ' ' + m_adminReportsMarkAsUnseenBatch + '</span>');
                Materialize.toast($toastContent, 2000);
            }
        });
    });

    // Batch Mark as Solved Behaviour
    $('#batch-markAsSolved-button').click(function () {
        var reportIdList = [];

        $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
            var $statusField = $('.solved-status-field', this);

            $(this).addClass('grey-text text-darken-1');
            $('.solved-toggle', this).addClass('active');

            $statusField.fadeOut(function () {
                $statusField.html('<i class="material-icons remar-green-text">check</i>');
                $statusField.fadeIn();
            });

            if (!$('.seen-toggle', this).hasClass('active'))
                $('.seen-toggle', this).addClass('active');

            reportIdList.push($(this).data('report-id'));
        });

        $.ajax({
            url    : '/report/batchMarkAsSolved',
            type   : 'get',
            data   : {reportIdList: JSON.stringify(reportIdList)},
            success: function (resp) {
                var $toastContent = $('<span>' + resp + ' ' + m_adminReportsMarkAsSolvedBatch + '</span>');
                Materialize.toast($toastContent, 10000);
            }
        });
    });

    // Batch Mark as Unsolved Behaviour
    $('#batch-markAsUnsolved-button').click(function () {
        var reportIdList = [];

        $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
            var $statusField = $('.solved-status-field', this);

            $statusField.fadeOut(function () {
                $statusField.html('<i class="material-icons remar-red-text">close</i>');
                $statusField.fadeIn();
            });

            reportIdList.push($(this).data('report-id'));
        });

        $.ajax({
            url    : '/report/batchMarkAsUnsolved',
            type   : 'get',
            data   : {reportIdList: JSON.stringify(reportIdList)},
            success: function (resp) {
                var $toastContent = $('<span>' + resp + ' ' + m_adminReportsMarkAsUnsolvedToast + '</span>');
                Materialize.toast($toastContent, 2000);
            }
        });
    });

    // Archive Button Behaviour
    $('.archive-button', '#reports-table').click(function () {
        var $row = $(this).closest('tr');
        var id   = $row.data('report-id');

        $.ajax({
            url    : '/report/archive',
            type   : 'post',
            data   : {id: id},
            success: function () {
                $row.remove();
                $('#reports-table').reloadMe();
                Materialize.toast(m_adminReportsArchived, 2000);
            },
            error  : function () {
                if (xhr.status == 422)
                    Materialize.toast(m_adminReportsToggleArchivedFailToast, 2000);
            }
        });
    });

    // Unarchive Button Behaviour
    $('.unarchive-button', '#reports-table').click(function () {
        var $row = $(this).closest('tr');
        var id   = $row.data('report-id');

        $.ajax({
            url    : '/report/unarchive',
            type   : 'post',
            data   : {id: id},
            success: function () {
                $row.remove();
                $('#reports-table').reloadMe();
                Materialize.toast(m_adminReportsUnarchived, 2000);
            },
            error  : function () {
                if (xhr.status == 422)
                    Materialize.toast(m_adminReportsToggleArchivedFailToast, 2000);
            }
        });
    });

    // Batch Archive Button Behaviour
    $('#batch-archive-button').click(function() {
        var reportIdList = [];

        $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
            $(this).remove();
            reportIdList.push($(this).data('report-id'));
        });

        $.ajax({
            url    : '/report/batchArchive',
            type   : 'get',
            data   : {reportIdList: JSON.stringify(reportIdList)},
            success: function (resp) {
                var $toastContent = $('<span>' + resp + ' ' + m_adminReportsArchiveBatch + '</span>');
                Materialize.toast($toastContent, 2000);
            }
        });
    });

    // Batch Unarchive Button Behaviour
    $('#batch-unarchive-button').click(function () {
        var reportIdList = [];

        $('input:checkbox:checked', '#reports-table').closest('tr').each(function () {
            $(this).remove();
            reportIdList.push($(this).data('report-id'));
        });

        $.ajax({
            url    : '/report/batchUnarchive',
            type   : 'get',
            data   : {reportIdList: JSON.stringify(reportIdList)},
            success: function (resp) {
                var $toastContent = $('<span>' + resp + ' ' + m_adminReportsUnarchiveBatch + '</span>');
                Materialize.toast($toastContent, 2000);
            }
        });
    });

    // Select all checkbox behaviour
    $('#select-all-checkbox').change(function () {
        var checked = this.checked;

        $('td input[type="checkbox"]', '#reports-table').each(function () {
            $(this).prop('checked', checked);
        });

        if (checked) $tableButtons.domEnable();
        else $tableButtons.domDisable();
    });

    $('td input[type="checkbox"]', '#reports-table').change(function () {
        var checkedCB   = $('input:checkbox:checked', '#reports-table').length;
        var totalCB     = $('input:checkbox', '#reports-table').length;
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
        var $row = $(this).closest('tr');
        var $button = $('.seen-toggle', $row);

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

                // Mark as seen
                $.ajax({
                    url: '/report/markAsSeen',
                    type: 'get',
                    data: {id: reportId},
                    success: function (resp) {
                        $row.addClass('grey-text text-darken-1');
                        $button.addClass('active');
                    }
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
