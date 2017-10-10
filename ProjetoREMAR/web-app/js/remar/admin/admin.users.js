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