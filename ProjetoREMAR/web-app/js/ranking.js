$(document).ready(function() {
    $('.modal').modal();

    $('.user-profile-anchor').click(function() {
        var id = $(this).data('user-id')
        var url = location.origin + "/user/userProfile/" + id

        console.log('user ' + id);
        /*
        $.ajax({
            type: 'GET',
            url:  url,
            data: null,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log(data);
                $(".modal").modal();
                $(".modal .modal-content").html(data);
                $(".modal").modal('open');
            },
            error: function (request, status, error) {
                console.log(error);
            }
        });

    });
    */
});
