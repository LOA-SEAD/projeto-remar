$(window).load(function(){
    $("#edit-group").click(function(){
        placeInput(this);
    });

    $(document).on("click","a#cancel-edit",function(){
        replaceTitle(this);
    });
    $(document).on("click","a#confirm-edit",function(){
        editName(this);
    });

    $(document).on("mouseenter","#confirm-edit",function(){
        $(this).children().removeClass("fa fa-check-circle-o");
        $(this).children().addClass("fa fa-check-circle");

    });

    $(document).on("mouseenter","#cancel-edit",function(){
        $(this).children().removeClass("fa fa-times-circle-o");
        $(this).children().addClass("fa fa-times-circle");

    });

    $(document).on("mouseleave","#confirm-edit",function(){
        $(this).children().removeClass("fa fa-check-circle");
        $(this).children().addClass("fa fa-check-circle-o");
    });

    $(document).on("mouseleave","#cancel-edit",function(){
        $(this).children().removeClass("fa fa-times-circle");
        $(this).children().addClass("fa fa-times-circle-o");

    });

    function placeInput(_this){
        var input = document.createElement("input");
        var form = document.createElement("form");
        form.id = "edit-name-form";
        input.id = "group-name-input";
        input.type = "text";
        input.name = "groupName";
        input.value = $("#group-name").html();
        $(input).addClass("left-align col s6 l8");
        $(form).append(input);

        var confirmButton = document.createElement("a");
        confirmButton.id = "confirm-edit";
        var confirmIcon = document.createElement("i");
        $(confirmIcon).addClass("fa fa-check-circle-o");
        $(confirmButton).css({"position":"relative","left":"0.6em","top":"-0.205em","color":"green","cursor":"pointer"});
        $(confirmButton).append(confirmIcon);

        var cancelButton = document.createElement("a");
        cancelButton.id = "cancel-edit";
        var cancelIcon = document.createElement("i");
        $(cancelIcon).addClass("fa fa-times-circle-o");
        $(cancelButton).css({"position":"relative","left":"0.4em","top":"-0.205em","color":"red","cursor":"pointer"});
        $(cancelButton).append(cancelIcon);

        $($(_this).parent().children()[0]).replaceWith(form);
        $($(_this).parent()).append(cancelButton);
        $($(_this).parent()).append(confirmButton);

        $("#delete-group").hide();
        $("#edit-group").hide();

    }

    function replaceTitle(_this){
        var editGroup = $("#edit-group");
        var span = document.createElement("span");
        span.id = "group-name";
        $(span).addClass("truncate");
        $(span).html(editGroup.attr("data-name"));
        $($(_this).parent().children()[0]).replaceWith(span);

        $("#confirm-edit").remove();
        $("#cancel-edit").remove();

        $("#delete-group").show();
        editGroup.show();

    }

    function editName(_this){
        var groupId = $("input[name='groupid']").val();
        var currentName = $("#edit-group").attr("data-name");
        var newName = $("#group-name-input").val();
        if(newName != currentName && newName != "") {
            $.ajax({
                type: "POST",
                url: "/group/edit",
                data: {groupId: groupId, newName: newName},
                success: function (data) {

                }, statusCode: {
                    200: function (response) {
                        $("#edit-group").attr("data-name", newName);
                        replaceTitle(_this);
                        Materialize.toast(response, 3000, "rounded");

                    }
                }
            });
        }else{
            replaceTitle(_this);
            Materialize.toast("Nome não alterado", 3000, "rounded");
        }
    }


});