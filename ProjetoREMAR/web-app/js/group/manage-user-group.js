$(document).ready(function () {
    Materialize.updateTextFields();
    $('.modal-trigger').leanModal();
    $('.tooltipped').tooltip({delay: 50});

    $('input').on('input', function () {
        $(this).val(function (_, v) {
            return v.replace(/\s+/g, '');
        });
    });

    var usersCollection = $(".users-collection");

    $(usersCollection).on("click", ".manage-user", function () {
        manageAdmin(this);
    });

    $('form').validate({
        rules: {
            groupname: {
                required: true
            },
            grouptoken: {
                required: true,
                minlength: 5
            }
        },
        messages: {
            groupname: {
                required: "Por favor, dê um nome ao grupo"
            },
            grouptoken: {
                required: "É necessário haver um código de acesso para o grupo"
            }
        },
        errorElement: 'span',
        errorClass: 'invalid-input',
        highlight: highlight,
        unhighlight: unhighlight
    });

    // Remoção de usuários do grupo
    $('#remove-btn').click(function () {
        var usersToRemove = [];

        $('#in-group-form .user-list-container span input').each(function (index) {
            if ($(this).is(':checked'))
                usersToRemove.push($(this).data('user-id'));
        });

        $.ajax({
            url: '/group/removeUsers',
            data: {
                'users': JSON.stringify(usersToRemove),
                'groupid': $('#group-id').val()
            },
            success: function (resp) {
                location.reload();
            },
            error: function (request, status, error) {
                console.log(error);
            }
        });
    });

    // Adição de usuários ao grupo
    $('#add-btn').click(function () {
        var usersToAdd = [];

        $('#off-group-form .user-list-container span input').each(function (index) {
            if ($(this).is(':checked'))
                usersToAdd.push($(this).data('user-id'));
        });

        $.ajax({
            url: '/group/addUsers',
            data: {
                'users': JSON.stringify(usersToAdd),
                'groupid': $('#group-id').val()
            },
            success: function (resp) {
                location.reload();
            },
            error: function (request, status, error) {
                console.log(error);
            }
        });
    });
});

function unhighlight(el) {
    $(el).removeClass('invalid');
    $(el).addClass('valid');
}

function highlight(el) {
    $(el).removeClass('input-error');
    $(el).addClass('invalid');

    if ($(el).attr("data-done") == "true") {
        $(el).siblings(".suffix").remove();
        $(el).removeAttr("data-done");
    }
}

function manageAdmin(_this) {
    var userGroupId = $(_this).attr("data-user-group-id");
    var option = _this.id.substr(_this.id.charAt(0), _this.id.indexOf("n") + 1);
    var icon = $(_this).children("i")[0];
    var adminText = $("#admin-" + userGroupId + "-text");
    $.ajax({
        type: 'POST',
        url: "/user-group/manageAdmin",
        data: {
            userGroupId: userGroupId,
            option: option
        },
        success: function () {
            if (option == "make-admin") {
                $($(_this).prevUntil(".circle")[1]).html(" (Administrador)").fadeIn(400);
                $(icon).html("star");
                _this.id = "remove-admin-" + userGroupId;
                Materialize.toast("Administrador adicionado!", 1500, "rounded");
            }
            else if (option == "remove-admin") {
                $($(_this).prevUntil(".circle")[1]).fadeOut(400);
                $(icon).html("star_border");
                _this.id = "make-admin-" + userGroupId;
                Materialize.toast("Administrador removido!", 1500, "rounded");
            }
        }
    })
}