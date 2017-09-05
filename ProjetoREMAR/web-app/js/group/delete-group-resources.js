/**
 * Created by garcia-pedro-hr on 02/09/2017.
 */

$(document).ready(function() {
    $('.remove-resource').click(function() {
        var resourceId = $(this).data('resource-id');
        var $card = $('#card-group-exported-resource-' + resourceId)

        $.ajax({
            type: 'POST',
            url: '/group-exported-resources/deleteGroupExportedResources/',
            data: {exportedresource: resourceId},
            success: function (data, textStatus) {
                location.reload();
            }
        });

    });
});