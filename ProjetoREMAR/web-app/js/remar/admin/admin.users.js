/**
 * Created by garciaph on 11/09/17.
 */

$(document).ready(function() {
    var $table = $('#users-table');
    var $tableButtons = $('.toggleable');

    $tableButtons.domDisable();

    $table.pageMe({
        pagerSelector: '#users-table-pager',
        activeColor: '#5d4037',
        showPrevNext: true,
        hidePageNumbers: false,
        perPage: 5
    });

    $('#search-user').keyup(function () {
        var $el   = $(this);
        var value = $el.val().toLowerCase();

        $table.children('tr').each(function() {
            var $this    = $(this);
            var name     = $this.children('.user-name').first().text();
            var username = $this.children('.user-username').first().text();

            var nameMatches     = (name.toLowerCase().indexOf(value) !== -1);
            var usernameMatches = (username.toLowerCase().indexOf(value) !== -1);

            if (!nameMatches && !usernameMatches) $this.addClass('hidden');
            else $this.removeClass('hidden');
        });

        $table.reloadMe();
    });

    $('a[id^="remove-user"]').click(function () {
        var $row = $(this).closest('tr');
        var name = $row.children('.user-name').text();
        var id = $row.data('user-id');
        $('#warning-box-message').html(' <span id="warning-user">' + GMS.DISABLE_USER_WARNING_MSG + name + '</span> ?');
        $('.warning-box .btn-flat:first-child').unbind().click(function () {
            $.ajax({
                url: GMS.REMOVE_USER_URL,
                type: 'post',
                data: {id: id},
                success: function (resp) {
                    location.reload();
                    Materialize.toast(GMS.USER_REMOVE_MSG, 2000);
                    $('.warning-box').slideUp(500);
                }
            });
        });
        $('.warning-box').slideDown(500);
    });

    $('a.dev-toggle').click(function() {
        var $button = $(this);
        var name = $(this).closest('tr').children('.user-name').text();
        var id = $button.closest('tr').data('user-id');
        $.ajax({
            url: GMS.TOGGLE_DEVELOPMENT_ROLE_LINK,
            type: 'get',
            data: {id: id},
            success: function (resp) {
                $button.tooltip('remove');
                $button.toggleClass('active');

                var tooltipMessage = (resp == 'true') ? GMS.DEVELOPMENT_ROLE_OFF_MSG : GMS.DEVELOPMENT_ROLE_OFF_MSG;
                $button.attr('data-tooltip', tooltipMessage);
                $button.tooltip();

                var toastMessage = (resp == 'true') ? GMS.DEVELOPMENT_ROLE_GRANTED_MSG : GMS.DEVELOPMENT_ROLE_REVOKED_MSG;
                Materialize.toast(toastMessage, 2000);
            }
        });
    });

    $('a#batch-remove-button').click(function() {
        $('#warning-box-message').html(GMS.DISABLE_USER_BATCH_WARNING_MSG);
        $('.warning-box .btn-flat:first-child').unbind().click(function () {
            var userIdList = [];

            $('#users-table input:checkbox:checked').closest('tr').each(function() {
                //$(this).remove();
                userIdList.push($(this).data('user-id'));
            });

            $.ajax({
                url: GMS.DISABLE_USER_BATCH_LINK,
                type: 'get',
                data: {userIdList: JSON.stringify(userIdList)},
                success: function (resp) {
                    //$('#users-table').reloadMe();
                    Materialize.toast(GMS.DISABLED_USER_BATCH_MSG, 2000);
                    $('.warning-box').slideUp(500);
                }
            });
        });
        $('.warning-box').slideDown(500);
    });

    $('a#submit-export').click(function(e) {
        var userIdList = JSON.stringify(
            $('#users-table input:checkbox:checked').closest('tr').map(function() {
                return $(this).data('user-id');
            }).get()
        );
        var extension = $('#format-select').val();

        var url = GMS.EXPORT_USERS_LINK
            + '?userIdList=' + userIdList
            + '&ext=' + extension;

        window.open(url, '_blank');
    });

    $('.warning-box .btn-flat:nth-child(2)').click(function () {
        $('.warning-box').slideUp(500);
    });

    $('#select-all-checkbox').change(function() {
        var checked = this.checked;

        $('#users-table td input[type="checkbox"]').each(function() {
            $(this).prop('checked', checked);
        });

        if (checked) $tableButtons.domEnable();
        else $tableButtons.domDisable();
    });

    $('#users-table td input[type="checkbox"]').change(function() {
        var checkedCB = $('#users-table input:checkbox:checked').length;
        var totalCB = $('#users-table input:checkbox').length;
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

    $('#export-button').click(function() {
        $('#user-export').slideDown(500);
        $('#user-import').slideUp(500);
    });

    $('#cancel-export').click(function() {
        $('#user-export').slideUp(500);
    });

    $('#import-button').click(function() {
        $('#user-export').slideUp(500);
        $('#user-import').slideDown(500);
    });

    $('#cancel-import').click(function() {
        $('#user-import').slideUp(500);
    });

    $(".user-profile").click(function () {
        var id  = $(this).attr("id").substr(8);
        var url = location.origin + "/user/userProfile/" + id;
        $.ajax({
            type       : 'GET',
            url        : url,
            data       : null,
            processData: false,
            contentType: false,
            success    : function (data) {
                $("#userDetailsModal").html(data);
                $("#userDetailsModal").openModal();
            },
            error      : function (XMLHttpRequest, textStatus, errorThrown) {
                console.log(textStatus + "\n" + errorThrown);
            }
        });
    });
});

$.fn.domDisable = function() {
    this.attr('disabled', 'disabled');
};

$.fn.domEnable = function() {
    this.removeAttr('disabled');
};