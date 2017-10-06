$(document).ready(function() {

    $('.user-profile-anchor').click(function() {
        var id = $(this).data('user-id');
        var url = location.origin + "/user/userProfile/" + id;

        $.ajax({
            type: 'GET',
            url:  url,
            data: null,
            processData: false,
            contentType: false,
            success: function (data) {
                $("#userDetailsModal").html(data);
                $("#userDetailsModal").openModal();
            },
            error: function (request, status, error) {
                console.log(error);
            }
        });
    });

});
