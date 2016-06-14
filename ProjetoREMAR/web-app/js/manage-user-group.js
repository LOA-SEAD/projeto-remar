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
        $("membertoken").validate();
    });

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
        var ul = $(".collection");
        var url;
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
                success: function(data,textStatus){
                    console.log(data);
                    console.log(textStatus);
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