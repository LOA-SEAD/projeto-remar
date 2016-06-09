/**
 * Created by deniscapp on 6/9/16.
 */
$(document).ready(function() {

    $("button").click(function(){
        addToGroups(this);

    });
    function addToGroups(_this) {
        var arr = $.map($("input[name='groupsid']:checked"), function (e, i) {
            return +e.value;
        });
        $.ajax({
            type: 'POST',
            url: "/group-exported-resources/addGroupExportedResources",
            data: {
                exportedresource: $(_this).attr("data-instance-id"),
                groupsid: arr.toString()
            },
            success: function (data, textStatus) {
                if (textStatus == "success") {
                    $("input[name='groupsid']:checked").prop("disabled", "disabled");
                    Materialize.toast("Compartilhado com sucesso! :)", 5000, "rounded");
                }
            }
        })
    }

});
