$(document).ready(function() {

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
