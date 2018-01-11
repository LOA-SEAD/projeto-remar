/**
 * Created by lucas pessoa on 11/10/17.
 */

$(document).ready(function() {
    $('#type-announcement').material_select();

    var $table = $('#annoucements-table');
    var $tableButtons = $('.toggleable');

    $tableButtons.domDisable();

    $table.pageMe({
        pagerSelector: '#annoucements-table-pager',
        activeColor: '#5d4037',
        showPrevNext: true,
        hidePageNumbers: false,
        perPage: 5
    });

    $('#search-announcement').keyup(function () {
        var $el   = $(this);
        var value = $el.val().toLowerCase();

        $table.children('tr').each(function() {
            var $this    = $(this);
            var name     = $this.children('.announcement-name').first().text();
            var nameMatches     = (name.toLowerCase().indexOf(value) !== -1);

            if (!nameMatches) $this.addClass('hidden');
            else $this.removeClass('hidden');
        });

        $table.reloadMe();
    });

    $('.warning-box .btn-flat:nth-child(2)').click(function () {
        $('.warning-box').slideUp(500);
    });

    $('#select-all-checkbox').change(function() {
        var checked = this.checked;

        $('#annoucements-table td input[type="checkbox"]').each(function() {
            $(this).prop('checked', checked);
        });

        if (checked) $tableButtons.domEnable();
        else $tableButtons.domDisable();
    });

    $('#annoucements-table td input[type="checkbox"]').change(function() {
        var checkedCB = $('#annoucements-table input:checkbox:checked').length;
        var totalCB = $('#annoucements-table input:checkbox').length;
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

    // Função para adicionar um novo anúncio
    $('#saveAnnouncement').on("click",function(){
        var formData = new FormData();

        formData.append('title',$("#title-announcement").val());
        formData.append('body',$("#body-announcement").val());
        formData.append('type',$("#type-announcement").val());

        $.ajax({
            type: 'POST',
            url: location.origin + "/admin/saveAnnouncement",
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                location.reload();
                Materialize.toast('Anúncio salvo com sucesso!', 3000);
            },
            error: function(req, res, err) {
                Materialize.toast('Problema na criação do anúncio.', 3000);
            }
        });
    });

    $("#saveEditAnnouncement").on("click",function(){
        var id = $("#editAnnouncement").attr("modal-announcement-id");

        var formData = new FormData();
        formData.append('title',$("#title-announcement").val());
        formData.append('body',$("#body-announcement").val());

        $.ajax({
            url: location.origin + "/admin/editAnnouncement/"+id,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log(data);
                // Trocar o reload por alterar a td respectiva com o novo valor
                location.reload();
                Materialize.toast('Ańuncio editado com sucesso!', 3000);
            },
            error: function(req, res, err) {
                console.log(req);
                console.log(res);
                console.log(err);
                Materialize.toast('Problema na edição do anúncio.', 3000);
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