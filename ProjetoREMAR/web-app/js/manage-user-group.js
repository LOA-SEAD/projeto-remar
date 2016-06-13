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

    $("button.add-user").click(function(){
        addUser(this)
    });

    function addUser(_this){
        var ul = $(".collection");
            $.ajax({
               type:'POST',
                url:'/group/addUserAutocomplete',
                data: {
                    groupid: $("input[name='groupid']").val(),
                    userid: $("input[name='userid']").val()
                },
                success: function(data){
                    window.location.reload();
                    //console.log("data:"+ JSON.parse(data))  ;
                    //
                    //
                    //$(ul).append('<li id="user-group-card-${newUser.id}" class="collection-item avatar left-align"> ' +
                    //    '<img alt src="/data/users/${newUser.user.username}/profile-picture" class="circle">' +
                    //    '' +
                    //    '' +
                    //    '</li>')
                }
            });

    }

    function manageAdmin(_this){
        var userGroupId = $(_this).attr("data-user-group-id");
        var option = _this.id.substr(_this.id.charAt(0),_this.id.indexOf("n")+1);
        var icon = $(_this).children("i")[0];
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
                    _this.id = "remove-admin-"+userGroupId;
                    Materialize.toast("Administrador adicionado!", 1500, "rounded");
                }
                else if(option == "remove-admin") {
                    $(icon).html("star_border");
                    _this.id = "make-admin-"+userGroupId;
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
                    text.attr("data-group-size",groupSize);
                    text.html("Ver membros ("+groupSize+")");
                    groupSize = 0;
                });
                Materialize.toast("Usuário removido!", 3000, "rounded");

            }
        })
    }


});