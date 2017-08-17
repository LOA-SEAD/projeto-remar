$(document).ready(function() {
    compartilhaJogo();
});

function compartilhaJogo() {
    $('input[type="checkbox"]').change(function () {
        var instanceId = $(this).attr("data-instance_id"); // pega o id do jogo
        var groupId = $(this).attr("data-group_id"); // pega o id do grupo

        var url = location.origin + "/group-exported-resources/addGroupExportedResources/";
        var url2 = location.origin + "/group-exported-resources/deleteGroupExportedResources/";

        if ($(this).is(':checked')) { // para compartilhar
            $.ajax({
                type: 'POST',
                url: url,
                data: {
                    exportedresource: instanceId, // envia o id do jogo
                    groupid: groupId // envia o id do grupo

                },
                success: function (data) {
                    Materialize.toast("Compartilhado com sucesso!", 5000);
                }, statusCode: {
                    405: function (response) {
                        Materialize.toast(response.responseText, 5000);
                    }
                }
            });
        } else { // para descompartilhar
            $.ajax({
                type: 'POST',
                url: url2,
                data: {
                    exportedresource: instanceId, // envia o id do jogo
                    groupid: groupId // envia o id do grupo
                },
                success: function (data) {
                    Materialize.toast("Descompartilhado com sucesso!", 5000);
                }, statusCode: {
                    405: function (response) {
                        Materialize.toast(response.responseText, 5000);
                    }
                }
            });
        }
    });
}













































/*function addToGroups(_this) {
    var arr = $.map($("input[name='groupsid']:checked"), function (e, i) {
        return +e.value;
    });
    if(arr.length > 0) {
        var instanceId = $(_this).attr("data-instance-id");
        $.ajax({
            type: 'POST',
            url: "/group-exported-resources/addGroupExportedResources",
            data: {
                exportedresource: instanceId,
                groupsid: arr.toString()
            },
            success: function (data, textStatus) {
                $("input[name='groupsid']:checked").prop("disabled", "disabled");
                $('#modal-group-'+instanceId).closeModal();
                $(".lean-overlay").remove();
                Materialize.toast("Compartilhado com sucesso!", 5000);
            }, statusCode: {
                405: function (response) {
                    Materialize.toast(response.responseText, 5000);
                }
            }
        })
    } else
        Materialize.toast("Por favor, selecione pelo menos um grupo", 5000);
}

/*
$(document).ready(function() {
    $("button").click( function() {
        addToGroups(this);
    });
});

function addToGroups(_this) {
        var arr = $.map($("input[name='groupsid']:checked"), function (e, i) {
            return +e.value;
        });
        if(arr.length > 0) {
            var instanceId = $(_this).attr("data-instance-id");
            $.ajax({
                type: 'POST',
                url: "/group-exported-resources/addGroupExportedResources",
                data: {
                    exportedresource: instanceId,
                    groupsid: arr.toString()
                },
                success: function (data, textStatus) {
                    $("input[name='groupsid']:checked").prop("disabled", "disabled");
                    $('#modal-group-'+instanceId).closeModal();
                    $(".lean-overlay").remove();
                    Materialize.toast("Compartilhado com sucesso!", 5000);
                }, statusCode: {
                    405: function (response) {
                        Materialize.toast(response.responseText, 5000);
                    }
                }
            })
        } else
            Materialize.toast("Por favor, selecione pelo menos um grupo", 5000);
}*/