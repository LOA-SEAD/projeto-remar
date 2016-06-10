/**
 * Created by deniscapp on 6/9/16.
 */
$(window).load(function(){
    $('.modal-trigger').leanModal();
    $('.tooltipped').tooltip({delay: 50});

    $("a.delete-user").click(function(){
        deleteGroupUser(this);
    });

    $("a.manage-user").click(function(){
        manageAdmin(this);
    });

    function manageAdmin(_this){
        var userGroupId = $(_this).attr("data-user-group-id");
        var option = _this.id.substr(_this.id.charAt(0),_this.id.indexOf("n")+1);
        var icon = $(_this).children("i")[0]
        console.log(icon);

        $.ajax({
            type:'POST',
            url:"/user-group/manageAdmin",
            data: {
                userGroupId: userGroupId,
                option: option
            },
            success: function() {

                if(option == "make-admin") {
                    $(icon).html("star");
                    _this.id = "remove-admin-"+userGroupId
                    Materialize.toast("Administrador adicionado!", 1500, "rounded");
                }
                else if(option == "remove-admin") {
                    $(icon).html("star_border");
                    _this.id = "make-admin-"+userGroupId
                    Materialize.toast("Administrador removido!", 1500, "rounded");


                }
            }
        })
    }

    function deleteGroupUser(_this){
        var userGroupId = $(_this).attr("data-user-group-id");
        var card = $("#user-group-card-"+userGroupId);
        var text = ($(".group-size"));
        var groupSize = text.attr("data-group-size");
        console.log(groupSize);
        $.ajax({
            type:'POST',
            url:"/user-group/delete",
            data: {
                userGroupId: userGroupId
            },
            success: function() {
                card.fadeOut(300,function(){
                    card.remove();
                    groupSize--;
                    text.html("Ver membros ("+groupSize+")");
                });
                Materialize.toast("Usuário removido!", 3000, "rounded");

            }
        })
    }


});