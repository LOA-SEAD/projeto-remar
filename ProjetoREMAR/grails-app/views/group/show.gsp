<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 5/18/16
  Time: 5:24 PM
--%>

<%@ page import="br.ufscar.sead.loa.remar.Group; br.ufscar.sead.loa.remar.UserGroup" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
    <div class="row">
        <div class="col l4 s6 m5">
          <h5 class="left-align trucate">${group.name}  <g:if test="${group.owner.id == session.user.id}"> <a href="/group/delete/${group.id}" data-position="right" data-tooltip="Deletar grupo" class="tooltipped" style="color: black"><i style="position:relative; top: 0.145em;" class="material-icons">delete</i></a> </g:if>
              <g:else><a class="tooltipped" data-tooltip="Sair do grupo" style=" color: black;" href="/group/leave-group/${group.id}"><i class="fa fa-sign-out fa-1x" aria-hidden="true"></i></a></g:else><br>
              <g:if test="${group.owner.id == session.user.id}">
                  <span style="font-size: 0.6em;" class="left-align">Senha de acesso: ${group.token}</span><br>
              </g:if>
          </h5>
        </div>
            <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdmin(session.user,true)}">
                <form id="add-user-form">
                    <div class="input-field col l3 offset-l2 m4">
                        <input class="user-input" name="term" id="search-user" type="text" required>
                        <label for="search-user"><i class="fa fa-search"></i></label>
                        <input type="hidden" value="${group.id}" name="groupid">
                        <input type="hidden" value="" id="user-id" name="userid">
                    </div>
                    <div class="col l3">
                        <button style="font-size: 0.8em; top: 1.2em; position:relative;" class="btn waves-effect waves-light add-user" type="submit" name="action">Adicionar
                            <i class="material-icons right">group_add</i>
                        </button>
                    </div>
                </form>
            </g:if>


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
                        <li id="user-group-card-${userGroup.id}" class="collection-item avatar left-align">
                            <img alt src="/data/users/${userGroup.user.username}/profile-picture" class="circle">
                            <span class="title">${userGroup.user.firstName + " " + userGroup.user.lastName}</span>
                            <p class="">Usuário: ${userGroup.user.username}</p>
                            <g:if test="${group.owner.id == session.user.id}">
                                <a href="#" id="user-group-id-${userGroup.id}" data-user-group-id="${userGroup.id}" style="position: relative; top: -2.5em; left: -1.6em;" class="secondary-content delete-user"><i class="material-icons">delete</i></a>
                                <g:if test="${!userGroup.admin}">
                                    <a id="make-admin-${userGroup.id}"  data-user-group-id="${userGroup.id}" href="#" data-position="left" data-tooltip="Tornar admin" class="secondary-content manage-user tooltipped"><i id="admin-${userGroup.id}" class="material-icons">star_border</i></a>
                                </g:if>
                                <g:else>
                                    <a id="remove-admin-${userGroup.id}" data-user-group-id="${userGroup.id}" href="#" class="secondary-content manage-user tooltipped"><i id="admin-star-${userGroup.id}" class="material-icons">star</i></a>
                                </g:else>
                            </g:if>

                        </li>
                    </g:each>
                </g:else>
            </ul>
        </div>
    </div>

<!-- Modal Structure -->
<div id="modal-user-in-group" class="modal">
    <div class="modal-content">
        <h5 id="modal-message"></h5>
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Ok</a>
    </div>
</div>
    <!-- Modal Structure -->

    <div class="divider"></div>

    <div>
        <a href="#modal-users" class="modal-trigger" style="font-size: 1.2em; left: -2.8em; position: relative"><span class="right group-size" data-group-size="${group.userGroups.size()}">Ver membros (${group.userGroups.size()})</span></a>

        <g:if test="${!group.owner.id == session.user.id}">
            <p align="left" style="font-size: 1.2em;">Dono: ${group.owner.firstName + " " + group.owner.lastName} </p>
        </g:if><br>

    </div>

<div class="row">
    <div style="position: relative; left: 1em">
        <g:each var="groupExportedResource" in="${groupExportedResources}">
            <div id="card-group-exported-resource-${groupExportedResource.id}" style="overflow: visible !important;" class="card white col l3 s4">
                <div class="card-image">
                    <img src="/published/${groupExportedResource.exportedResource.processId}/banner.png">
                </div>
                <div class="card-content">
                    <span class="title">${groupExportedResource.exportedResource.name}</span>
                    <div class="divider"></div>
                    <span style="color: dimgrey; font-size: 0.9em" class="center">${groupExportedResource.exportedResource.resource.category.name}</span>
                    <span style="color: dimgrey; font-size: 0.9em" class="center truncate">Feito por: ${groupExportedResource.exportedResource.owner.username}</span>
                    <span style="color: dimgrey;" class="center">
                        <i class="fa fa-globe"></i>
                        <g:if test="${groupExportedResource.exportedResource.resource.android}">
                            <i class="fa fa-android"></i>
                        </g:if>
                        <g:if test="${groupExportedResource.exportedResource.resource.desktop}">
                            <i class="fa fa-windows"></i>
                            <i class="fa fa-linux"></i>
                            <i class="fa fa-apple"></i>
                        </g:if>
                        <g:if test="${groupExportedResource.exportedResource.resource.moodle}">
                            <i class="fa fa-graduation-cap"></i>
                        </g:if>
                    </span>
                </div>
                <div class="right-align">
                    <g:if test="${group.owner.id == session.user.id}">

                        <a class="dropdown-button" data-activates='dropdown${groupExportedResource.id}'><i class="material-icons" style="color: black;">more_vert</i></a>
                    <!-- Dropdown Structure -->
                    <ul id='dropdown${groupExportedResource.id}' class='dropdown-content'>
                        <li style="text-align: center;">
                            <a class="tooltipped remove-resource" id="delete-resource-${groupExportedResource.id}" data-resource-id="${groupExportedResource.id}" data-position="right" data-delay="50" data-tooltip="Remover do grupo">
                                <i class="material-icons" style="color: #FF5722;">delete</i>

                                %{--TODO remover jogo de grupo apenas--}%
                                %{--TODO ver estatisticas aqui nas opcoes?--}%
                            </a>
                        </li>
                    </g:if>
                    </ul>
                </div>
            </div>
        </g:each>
    </div>
</div>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<g:javascript src="delete-group-resources.js" />
<g:javascript src="manage-user-group.js" />
<g:javascript src="tooltip.js" />

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

                },statusCode:{
                    403: function(response){
                        $("#modal-message").html(response.responseText);
                        $('#modal-user-in-group').openModal();
                    }
                }
            })
        },
        select: function(event, ui) {
            event.preventDefault();
            $("#user-id").val(ui.item.value);

        },
        focus: function(event, ui) {
            event.preventDefault();
            if(ui.item.inGroup == true){
                //TODO
            }
            $(this).val(ui.item.label);
        },
        messages: {
            noResults: '',
            results: function() {}
        },
        minLength: 3
    });

</script>
<g:javascript src="jquery/jquery.validate.js"/>
</body>
</html>