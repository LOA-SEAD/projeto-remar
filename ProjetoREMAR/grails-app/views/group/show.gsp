<%@ page import="br.ufscar.sead.loa.remar.Group; br.ufscar.sead.loa.remar.UserGroup" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>
    <body>
        <div class="row cluster">
            <div class="row show">
                <div class="row cluster-header">
                    <div id="main-header" class="row" style="margin-bottom: 0px">
                        <div class="col s6">
                            <div style="font-size: 1.6em;">
                                <a href="#!" class="first-breadcrumb black-text"><g:message code='group.label.myGroups' default="Meus Grupos"/></a>
                                <g:if test="${group.owner.id == session.user.id}">
                                    <a href="/group/admin" class="breadcrumb orange-text text-darken-2"><g:message code='menu.button.my.groups.admin.label' default="Sou Admin"/></a>
                                </g:if>
                                <g:else>
                                    <a href="/group/list" class="breadcrumb orange-text text-darken-2"><g:message code='menu.button.my.groups.member.label' default="Sou Membro"/></a>
                                </g:else>
                                <a href="#1" class="breadcrumb black-text">${group.name}</a>
                                <br/>
                            </div>
                            <g:if test="${group.owner.id == session.user.id}">
                                <h7>Código de acesso: ${group.token}</h7>
                            </g:if>
                        </div>

                        <div class="col s6">
                            <div class="row right-align" style="margin-bottom: 0px">
                                <g:if test="${group.owner.id == session.user.id}">
                                    <g:link action="edit" id="${group.id}">
                                        <i class="tooltipped fa fa-cog fa-2x" data-position="left" data-tooltip="Gerenciar Grupo"></i>
                                    </g:link>
                                </g:if>
                            </div>
                            <div class="row right-align" style="margin-bottom: 0px">
                                <a href="#modal-users" class="modal-trigger" style="font-size: 1.2em; left: -2.8em; position: relative"><span
                                        class="right group-size"
                                        data-group-size="${group.userGroups.size() + 1}">Ver membros (${group.userGroups.size() + 1})</span></a>
                                <g:if test="${!group.owner.id == session.user.id}">
                                    <p align="left" style="font-size: 1.2em;">Dono: ${group.owner.firstName + " " + group.owner.lastName}</p>
                                </g:if>

                            </div>
                        </div>
                    </div>
                    <input type="hidden" value="${group.id}" id="group-id" name="groupid">
                    <div class="divider"></div>

                </div>
            </div>

            <div>
                <!-- Jogos Compartilhados -->
                <div id="shared-resources row">
                    <g:if test="${!groupExportedResources.empty}">
                        <g:render template="sharedResourceCard" model="[groupExportedResources: groupExportedResources]"/>
                    </g:if>
                    <g:else>
                        <div class="warning-box">
                            <i class="material-icons tiny">warning</i>
                            Não há nenhum jogo compartilhado com este grupo.
                        </div>
                    </g:else>
                </div>
            </div>

            <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdminAndGroup(session.user, true, group)}">
            <!-- Compartilhamento de Jogos -->
            <div class="row show">
                <div class="cluster-header">
                    <h4>Compartilhamento de Jogos</h4>
                    <div class="divider"></div>
                </div>
                <div class="row">
                    <div id="info" style="padding-left: 15px;">
                        <p align="left">
                            <u>Informações sobre o compartilhamento de jogos</u>
                        </p>
                        <p align="left" style="margin-left: 20px;">
                            Acesse <g:link controller="exportedResource" action="publicGames">Banco de Jogos</g:link>
                            ou <g:link controller="exportedResource" action="MyGames">Meus Jogos</g:link>
                        </p>
                        <p align="left" style="margin-left: 20px;">
                            Escolha um Jogo e clique na opção "Compartilhar para grupos" <i class="fa fa-users" style="color: #FF5722;"></i>
                        </p>
                        <p align="left" style="margin-left: 20px;">
                            <span class="bold">Obs:</span> Você também pode compartilhar um jogo ao término de sua customização.
                        </p>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            </g:if>
        </div>

        <!-- Modal Structures -->
        <div id="modal-users" class="modal bottom-sheet">
            <div class="modal-content">
                <h4 class="left-align">Membros do grupo</h4>
                <ul class="collection users-collection">
                    <li class="collection-item avatar left-align">
                        <img src="/data/users/${group.owner.username}/profile-picture" class="circle">
                        <span class="title">${group.owner.firstName + " " + group.owner.lastName + " (Dono do grupo)"}</span>
                        <p class="">Usuário: ${group.owner.username}</p>
                    </li>
                    <g:if test="${group.userGroups.size() == 0 && group.owner.id == session.user.id}">
                        <li id="no-users" class="collection-item">Nenhum usuário foi adicionado à este grupo.</li>
                    </g:if>
                    <g:else>
                        <g:each var="userGroup" in="${group.userGroups.sort { it.user.firstName }}">
                            <li id="user-group-card-${userGroup.id}" class="collection-item avatar left-align">
                                <img alt src="/data/users/${userGroup.user.username}/profile-picture" class="circle">
                                <span class="title">${userGroup.user.firstName + " " + userGroup.user.lastName}</span>
                                <span class="admin-text" id="admin-${userGroup.id}-text"><g:if
                                        test="${userGroup.admin}">(Administrador)</g:if>
                                <g:else></g:else>
                                </span>
                                <p class="">Usuário: ${userGroup.user.username}</p>
                                <g:if test="${group.owner.id != session.user.id}">
                                    <g:if test='${userGroup.user.id == session.user.id}'>
                                        <a class="tooltipped modal-trigger secondary-content" data-tooltip="Sair do grupo"
                                           style=" color: black;" href="#leave-group"><i class="fa fa-sign-out fa-2x"
                                                                                         aria-hidden="true"></i></a>
                                    </g:if>
                                </g:if>
                            </li>
                        </g:each>
                    </g:else>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Modal Structures -->
<div id="modal-users" class="modal bottom-sheet">
    <div class="modal-content">
        <h4 class="left-align">Membros do grupo</h4>
        <ul class="collection users-collection">
            <li class="collection-item avatar left-align">
                <img src="/data/users/${group.owner.username}/profile-picture" class="circle">
                <span class="title">${group.owner.firstName + " " + group.owner.lastName + " (Dono do grupo)"}</span>

                <p class="">Usuário: ${group.owner.username}</p>
            </li>
            <g:if test="${group.userGroups.size() == 0 && group.owner.id == session.user.id}">
                <li id="no-users" class="collection-item">Nenhum usuário foi adicionado à este grupo.</li>
            </g:if>
            <g:else>
                <g:each var="userGroup" in="${group.userGroups.sort { it.user.firstName }}">
                    <li id="user-group-card-${userGroup.id}" class="collection-item avatar left-align">
                        <img alt src="/data/users/${userGroup.user.username}/profile-picture" class="circle">
                        <span class="title">${userGroup.user.firstName + " " + userGroup.user.lastName}</span>
                        <span class="admin-text" id="admin-${userGroup.id}-text"><g:if
                                test="${userGroup.admin}">(Administrador)</g:if>
                        <g:else></g:else>
                        </span>

                        <p class="">Usuário: ${userGroup.user.username}</p>
                        <g:if test="${group.owner.id == session.user.id}">
                            <!--a href="#" id="${userGroup.id}" style="position: relative; top: -2.5em; left: -1.6em;"
                               class="secondary-content delete-modal"><i class="material-icons">delete</i></a-->
                            <g:if test="${!userGroup.admin}">
                                <a id="make-admin-${userGroup.id}" data-user-group-id="${userGroup.id}" href="#"
                                   data-position="left" data-tooltip="Tornar admin"
                                   class="secondary-content manage-user tooltipped"><i id="admin-${userGroup.id}"
                                                                                       class="material-icons">star_border</i>
                                </a>
                            </g:if>
                            <g:else>
                                <a id="remove-admin-${userGroup.id}" data-user-group-id="${userGroup.id}" href="#"
                                   class="secondary-content manage-user tooltipped"><i id="admin-star-${userGroup.id}"
                                                                                       class="material-icons">star</i>
                                </a>
                            </g:else>
                        </g:if>
                        <g:else>
                            <g:if test='${userGroup.user.id == session.user.id}'>
                                <a class="tooltipped modal-trigger secondary-content" data-tooltip="Sair do grupo"
                                   style=" color: black;" href="#leave-group"><i class="fa fa-sign-out fa-2x"
                                                                                 aria-hidden="true"></i></a>
                            </g:if>

                        </g:else>
                    </li>
                </g:each>
            </g:else>
        </ul>
    </div>
</div>

<div id="leave-group" class="modal">
    <div class="modal-content">
        <h5>Deseja mesmo sair do grupo?</h5>
    </div>

    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Não</a>
        <a href="/group/leave-group/${group.id}"
           class=" modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
    </div>
</div>

<div id="modal-user-in-group" class="modal">
    <div class="modal-content">
        <h5 id="modal-message"></h5>
    </div>

    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Ok</a>
    </div>
</div>


<link type="text/css" rel="stylesheet" href="${resource(dir: "css/user", file: "profile.css")}"/>
<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "group.css")}"/>


    <g:javascript src="remar/group/delete-group-resources.js"/>
</body>

</html>
