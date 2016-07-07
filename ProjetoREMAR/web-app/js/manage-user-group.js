/**
 * Created by deniscapp on 6/9/16.
 */
$(window).load(function(){
    $('.modal-trigger').leanModal();
    $('.tooltipped').tooltip({delay: 50});

    var usersCollection = $(".users-collection");

    $(usersCollection).on("click",".delete-user",function(){
        deleteUserGroup(this);
    });

    $(usersCollection).on("click",".manage-user",function(){
        manageAdmin(this);
    });

    $(document).on("click",".show-stats",function(){
        showStats(this);
    });

    $(usersCollection).on("click",".add-user",function(){
        //$("membertoken").validate();
    });

    function showStats(_this){
        $.ajax({
            type: "POST",
            url: "/group/show-stats",
            data: {
                groupid: $("input[name='groupid']").val(),
                exportedresourceid: $(_this).attr("data-exported-resource-id") },
            success: function(data){
            }
        })
    }

    function deleteUserGroup(_this){
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
                $(_this).parents().eq(0).fadeOut(300,function(){
                    $(this).remove();
                    groupSize--;
                    text.attr("data-group-size",groupSize);
                    text.html("Ver membros ("+groupSize+")");
                    if(groupSize == 0){
                        console.log("if");
                        var noUsers = document.createElement("li");
                        noUsers.setAttribute("id","no-users");
                        $(noUsers).addClass("collection-item");
                        $(noUsers).html("Nenhum usuário foi adicionado à este grupo.");
                        $(usersCollection).append(noUsers).fadeIn(300);
                    }
                });


                Materialize.toast("Usuário removido!", 3000, "rounded");

            }
        });

    }


    $("#add-user-form").validate({
        rules: {

            membertoken: {
                required: true,
                minlength: 10,
                maxlength: 10
            }
            ,term: {
                required: true
            }

        },
        messages: {
            membertoken: {
                required: "Digite uma senha de acesso",
                minlength: "Senha muito pequena!",
                maxlength: "Senha muito longa!"
            },
            term: {
                required: "Digite um nome"
            }

        },
        errorElement : 'div',
        errorPlacement: function(error, element) {
            var placement = $(element).data('error');
            if (placement) {
                $(placement).append(error)
            } else {
                error.insertAfter(element);
            }
        },
        submitHandler: function(form){
            addUser();
            return false;
        }
    });


    function addUser(){
        var url;
        var noUsers = $("#no-users");
        var text = ($(".group-size"));
        var groupSize = text.attr("data-group-size");
        var ul = $(".users-collection");
        var token = $("#member-token");
        if($(token).val() != null)
            url = "/group/addUserByToken";
        else
            url = "/group/addUserAutocomplete";
            $.ajax({
               type:'POST',
                url:url,
                data: {
                    groupid: $("input[name='groupid']").val(),
                    userid: $("input[name='userid']").val(),
                    membertoken: $(token).val()
                },
                success: function(data){
                    groupSize++;
                    text.attr("data-group-size",groupSize);
                    text.html("Ver membros ("+groupSize+")");
                    $("#add-user-form")[0].reset();
                    if(noUsers) {
                        noUsers.fadeOut(300);
                        noUsers.remove();
                    }
                    $(ul).append(data);
                    Materialize.toast("Usuário adicionado!", 3000, "rounded");

                }, statusCode: {
                    403: function(response){
                        $("#modal-message").html(response.responseText);
                        $('#modal-user-in-group').openModal();
                    },
                    404: function(response){
                        $("#modal-message").html(response.responseText);
                        $('#modal-user-in-group').openModal();
                    }
                }
            });

    }

    function manageAdmin(_this){
        var userGroupId = $(_this).attr("data-user-group-id");
        var option = _this.id.substr(_this.id.charAt(0),_this.id.indexOf("n")+1);
        var icon = $(_this).children("i")[0];
        var adminText = $("#admin-"+ userGroupId +"-text");

        $.ajax({
            type:'POST',
            url:"/user-group/manageAdmin",
            data: {
                userGroupId: userGroupId,
                option: option
            },
            success: function() {

                if(option == "make-admin") {
                    $($(_this).prevUntil(".circle")[2]).html(" (Administrador)").fadeIn(400);
                    $(icon).html("star");
                    _this.id = "remove-admin-"+userGroupId;
                    Materialize.toast("Administrador adicionado!", 1500, "rounded");
                }
                else if(option == "remove-admin") {
                    $($(_this).prevUntil(".circle")[2]).fadeOut(400);
                    $(icon).html("star_border");
                    _this.id = "make-admin-"+userGroupId;
                    Materialize.toast("Administrador removido!", 1500, "rounded");


                }
            }
        })
    }

});