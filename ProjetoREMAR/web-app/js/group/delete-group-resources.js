/**
 * Created by deniscapp on 6/9/16.
 */
$(window).load(function() {

    $(document).on("click","a.remove-resource",function(){
        deleteResource(this);
    });
    function deleteResource(_this) {
        var resourceId = $(_this).attr("data-resource-id");
        if(typeof resourceId !== undefined) {
            var card = $("#card-group-exported-resource-"+resourceId);
            $.ajax({
                type: 'POST',
                url: "/group-exported-resources/delete",
                data: {
                    id: resourceId
                },
                beforeSend: function() {
                    card.animate({'backgroundColor':'#fb6c6c'},300);
                },
                success: function (data, textStatus) {
                    card.slideUp(300,function() {
                        card.remove();
                    });
                    Materialize.toast("Deletado com sucesso! :)", 5000, "rounded");

                }
            });
        }
    }

});