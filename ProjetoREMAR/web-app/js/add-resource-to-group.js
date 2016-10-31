/**
 * Created by deniscapp on 6/9/16.
 */
$(window).load(function() {

    $("button").click(function(){
        addToGroups(this);
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
                    Materialize.toast("Compartilhado com sucesso! :)", 5000, "rounded");
                },statusCode: {
                    405: function (response) {
                        Materialize.toast(response.responseText, 5000, "rounded");
                    }
                }
            })
        }else
            Materialize.toast("Por favor, selecione pelo menos um grupo", 5000, "rounded");

    }

    $('.modal-trigger').leanModal({
            dismissible: true, // Modal can be dismissed by clicking outside of the modal
            opacity: .5, // Opacity of modal background
            in_duration: 300, // Transition in duration
            out_duration: 200, // Transition out duration
            ready: function() {  }, // Callback for Modal open
            complete: function() {
                $(".lean-overlay").remove();
                $("input[name='groupsid']:checked").removeAttr('checked');
            } // Callback for Modal close
        }
    );


});
