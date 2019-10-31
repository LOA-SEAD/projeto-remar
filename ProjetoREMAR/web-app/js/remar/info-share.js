$(document).ready(function () {
    id = $('.infos-exportedResource').data('instance_id');

    var url = location.origin + "/exportedResource/cardInfos/" + id;

    $.ajax({
        type: 'GET',
        url:  url,
        data: null,
        processData: false,
        contentType: false,
        success: function (data) {
            $("#share-container").html(data);
            $("#share-container h4").remove();
        },
        error: function (request, status, error) {
            console.log(error);
        }
    });
});