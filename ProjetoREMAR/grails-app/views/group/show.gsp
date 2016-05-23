<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 5/18/16
  Time: 5:24 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div class="cluster-header">
    <div class="row">
        <div class="text-teal text-darken-3 left-align margin-bottom col l6 s8 offset-s3">
          ${group.name}
        </div>
        <div class="">
        <g:form controller="group" action="addUser">
            <div class="input-field col l3">
                <input name="term" id="search-user" type="text" required>
                <label for="search-user"><i class="fa fa-search"></i></label>
                <input type="hidden" value="${group.id}" name="groupid">
                <input type="hidden" value="" id="user-id" name="userid">
            </div>
            <div class="col l3">
                <button style="font-size: 0.5em; top: 1.2em; position:relative;" class="btn waves-effect waves-light" type="submit" name="action">Adicionar
                    <i class="material-icons right">group_add</i>
                </button>
            </div>
        </g:form>
        </div>
    </div>

    <div class="divider"></div>

    <div class="center-align">
        <p align="center" style="font-size: 0.6em;">Dono(s):
            <g:each var="owner" in="${group.owners}">
                %{--<g:if test="${owner.id == session.user.id}">--}%
                    %{--Você--}%
                %{--</g:if>--}%
                ${owner.firstName +' '+ owner.lastName}
            </g:each>
        </p>
    </div>
</div>
<div class="row">
    <div class="col l3 offset-l11 s4">
        <h5>Membros</h5>
    </div>
    <div class="row">
        <g:each var="groupUser" in="${groupUsers.user}">
            <div style="overflow: visible !important;" class="card white col l3 s5 offset-l10">
                <div class="card-image">
                    <div class="col l4 s4 left-align">
                        <img src="/data/users/${groupUser.username}/profile-picture" class="circle responsive-img">
                    </div>
                </div>
                <div class="card-content">
                    <div>
                        <p class="left-align" style="top: 0.4em; position: relative;">${groupUser.firstName + " " + groupUser.lastName}</p>
                    </div>
                    <div class="col l1 s1 offset-l6 offset-s10">
                        <a class="dropdown-button" id="drop" href="#" data-activates="dropdown-user-${groupUser.id}" style="color: black"><span class="material-icons">more_vert</span></a>
                    </div>
                    <ul style="font-size: 0.4em" id="dropdown-user-${groupUser.id}" class="dropdown-content">
                        <li><a href="/group/delete/${groupUser.id}">Excluir</a></li>
                        <li><a href="">Tornar Dono(a)</a></li>
                    </ul>
                </div>
            </div>
        </g:each>
    </div>

</div>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<script>
    $('.dropdown-button').dropdown({
                inDuration: 300,
                outDuration: 225,
                constrain_width: false, // Does not change width of dropdown to that of the activator
                gutter: 0, // Spacing from edge
                belowOrigin: true, // Displays dropdown below the button
                alignment: 'left' // Displays dropdown with edge aligned to the left of button
            }
    );

    $("#search-user").autocomplete({
        source: function(request,response){
            $.ajax({
                type:'GET',
                url:"/user/autocomplete",
                data: {
                    query: request.term,
                    group: ${group.id}
                },
                success: function(data) {
                    response(data);
                }
            })
        },
        select: function(event, ui) {
            event.preventDefault();
            $("#user-id").val(ui.item.value);

        },
        focus: function(event, ui) {
            event.preventDefault();
            $(this).val(ui.item.label);
        },
        messages: {
            noResults: '',
            results: function() {}
        },
        minLength: 3
    });

</script>

</body>
</html>