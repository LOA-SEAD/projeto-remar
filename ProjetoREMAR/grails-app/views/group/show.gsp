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
        <div class="text-teal text-darken-3 left-align margin-bottom col l6 s8">
          ${group.name}
        </div>
        <div class="">
            <g:if test="${group.owner.id == session.user.id || group.admins.find { it.id == session.user.id}}">
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
            </g:if>
        </div>
    </div>

    <!-- Modal Structure -->
    <div id="modal-users" class="modal bottom-sheet">
        <div class="modal-content">
            <h4 class="left-align">Membros do grupo</h4>
            %{--<p>A bunch of text</p>--}%
            <ul class="collection">
                <g:if test="${group.userGroups.size()==0}">
                    <li class="collection-item">Nenhum usuário foi adicionado à este grupo.</li>
                </g:if>
                <g:else>
                    <g:each var="userGroup" in="${group.userGroups}">
                        <li class="collection-item avatar left-align">
                            <img alt src="/data/users/${userGroup.user.username}/profile-picture" class="circle">
                            <span class="title">${userGroup.user.firstName + " " + userGroup.user.lastName}</span>
                            <p class="" style="font-size: 0.6em;">Usuário: ${userGroup.user.username}</p>
                            <input id="user-group-id" type="hidden" value="${userGroup.id}" name="usergroupid">
                            <g:if test="${group.owner.id == session.user.id}">
                                <a  onclick="deleteGroupUser();" href=""  style="position: relative; top: -1.48em; left: -1em;" class="secondary-content"><i class="material-icons">delete</i></a>
                                <g:if test="${!group.admins.toList().contains(userGroup.user)}">
                                    <a onclick="manageAdmin(this.id);" id="make-admin" href="" class="secondary-content"><i class="material-icons">star_border</i></a>
                                </g:if>
                                <g:else>
                                    <a onclick="manageAdmin(this.id);" id="remove-admin" href="" class="secondary-content"><i class="material-icons">star</i></a>
                                </g:else>
                            </g:if>

                        </li>
                    </g:each>
                </g:else>
            </ul>
        </div>
        <div class="modal-footer">
            %{--<a href="" class=" modal-action modal-close waves-effect waves-green btn-flat">Agree</a>--}%
        </div>
    </div>
    <!-- Modal Structure -->
    <div class="divider"></div>
    <div style="left: 0.6em; position: relative">
        <a href="#modal-users" class="modal-trigger"><h5 class="right">Ver membros (${group.userGroups.size()})</h5></a>

        <p align="left" style="font-size: 0.6em;">Dono:
                <g:if test="${group.owner.id == session.user.id}">
                    Você
                </g:if>
                <g:else>
                    ${group.owner.firstName + " " + group.owner.lastName}
                </g:else><br>
                <g:if test="${group.admins.size() > 0}">
                    Admin(s):
                    <g:each status="i" var="admin" in="${group.admins}">
                            ${admin.firstName +" "+ admin.lastName}
                        <g:if test="${!(i == group.admins.size()-1)}">
                            /
                        </g:if>
                    </g:each>
                </g:if>
        </p>
    </div>


</div>




<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<script>
    $(document).ready(function(){
        // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
        $('.modal-trigger').leanModal();
    });
    function deleteGroupUser(){
        $.ajax({
            type:'POST',
            url:"/user-group/delete",
            data: {
                userGroupId: $("#user-group-id").val()
            },
            success: function(data) {
                console.log(data);
                console.log("success");
//                window.location.reload();
            }
        })
    }

    function manageAdmin(option){
        $.ajax({
            type:'POST',
            url:"/user-group/manageAdmin",
            data: {
                userGroupId: $("#user-group-id").val(),
                option: option
            },
            success: function(data) {
                console.log(data);
//                console.log("success");
//                window.location.reload();
            }
        })
    }


</script>

<script>

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