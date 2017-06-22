<%@ page import="br.ufscar.sead.loa.remar.Group; br.ufscar.sead.loa.remar.UserGroup" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>

<body>
<div id="modal-confirmation-group" class="modal">
    <div class="modal-content">
        <p>Tem certeza que deseja realizar esta ação</p>
    </div>

    <div class="modal-footer">
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Não</a>
        <a id="delete-group" href="/group/delete/${group.id}"
           class=" modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
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

<div class="row">
    <div class="col l4 s6 m5">
        <h5 class="left-align"><span class="truncate" id="group-name">${group.name}</span>
            <g:if test="${group.owner.id == session.user.id}">
                <a id="edit-group" data-name="${group.name}" data-position="right" data-tooltip="Editar grupo"
                   class="tooltipped" style="color: black"><i style="position:relative; top: 0.145em; cursor: pointer;"
                                                              class="material-icons">edit</i></a>
                <a id="remove-group" data-position="right" data-tooltip="Deletar grupo" class="tooltipped modal-trigger"
                   href="#modal-confirmation-group" style="color: black"><i style="position:relative; top: 0.145em;"
                                                                            class="material-icons">delete</i></a>
            </g:if>
            <g:if test="${group.owner.id == session.user.id}">
                <span style="font-size: 0.6em;" class="left">Código de acesso: ${group.token}</span><br>
            </g:if>
        </h5>
    </div>
    <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdminAndGroup(session.user, true, group)}">
        <form id="add-user-form">
            <div class="input-field col l3 offset-l2 m4">
                <input class="user-input" type="text" placeholder="Procure por um usuário" name="term" id="search-user"
                       required>
                <input type="hidden" value="" id="user-id" name="userid">
            </div>

            <div class="col l3">
                <button style="font-size: 0.8em; top: 1.2em; position:relative;"
                        class="btn waves-effect waves-light remar-orange" type="submit" name="action">Adicionar

                </button>
            </div>
        </form>
    </g:if>
    <input type="hidden" value="${group.id}" name="groupid">
</div>

<!-- Modal Structure -->
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
                            <a href="#" id="${userGroup.id}" style="position: relative; top: -2.5em; left: -1.6em;"
                               class="secondary-content delete-modal"><i class="material-icons">delete</i></a>
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

<!-- Modal Structure -->
<div id="delete-modal" class="modal">
    <div class="modal-content">
        <h5>Deseja mesmo remover este usuário do grupo?</h5>
    </div>

    <div class="modal-footer">
        <a href="#!" data-user-group-id=""
           class="delete-user modal-action modal-close waves-effect waves-green btn-flat">Sim</a>
        <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Não</a>
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

<div class="divider"></div>

<div>
    <a href="#modal-users" class="modal-trigger" style="font-size: 1.2em; left: -2.8em; position: relative"><span
            class="right group-size"
            data-group-size="${group.userGroups.size() + 1}">Ver membros (${group.userGroups.size() + 1})</span></a>

    <g:if test="${!group.owner.id == session.user.id}">
        <p align="left" style="font-size: 1.2em;">Dono: ${group.owner.firstName + " " + group.owner.lastName}</p>
    </g:if>
    <br>

</div>
<main class="cardGames">
    <div class="row">
        <div style="position: relative; left: 1em">
            <g:if test="${!groupExportedResources.empty}">
                <g:each var="groupExportedResource" in="${groupExportedResources}">
                    <div class="col l3 s5">
                        <div id="card-group-exported-resource-${groupExportedResource.id}" class="card hoverable">
                            <div class="card-image waves-effect waves-block waves-light">
                                <img class="activator"
                                     src="/published/${groupExportedResource.exportedResource.processId}/banner.png">
                            </div>

                            <div class="card-content">
                                <span style="font-size: 1.3em;"
                                      class="card-title grey-text text-darken-4 activator center-align truncate">${groupExportedResource.exportedResource.name}</span>

                                <div class="divider"></div>
                                <span style="color: dimgrey; font-size: 0.9em"
                                      class="center">${groupExportedResource.exportedResource.resource.category.name}</span>
                                <span style="color: dimgrey; font-size: 0.9em"
                                      class="center truncate">Feito por: ${groupExportedResource.exportedResource.owner.username}</span>
                                <span style="color: dimgrey;" class="center">
                                    <i class="fa fa-globe"></i>
                                    <g:if test="${groupExportedResource.exportedResource.resource.android}">
                                        <i class="fa fa-android" data-tooltip="Android"></i>
                                    </g:if>
                                    <g:if test="${groupExportedResource.exportedResource.resource.desktop}">
                                        <i class="fa fa-windows" data-tooltip="Windows"></i>
                                        <i class="tooltipped fa fa-linux" data-position="bottom" data-tooltip="Linux"></i>
                                        <i class="fa fa-apple" data-tooltip="Mac"></i>
                                    </g:if>
                                    <g:if test="${groupExportedResource.exportedResource.resource.moodle}">
                                        <i class="fa fa-graduation-cap"></i>
                                    </g:if>
                                </span>
                            </div>

                            <div class="right">
                                <i class="activator material-icons" style="color: black; cursor: pointer">more_vert</i>
                            </div>

                            <div class="card-reveal">
                                <div class="row">
                                    <h5 class="card-title grey-text text-darken-4 col l12 truncate"><small
                                            class="left">Jogar:</small><i class="material-icons right">close</i>
                                    </h5><br>

                                    <div class="col l4">
                                        <a style="font-size: 2em; color: black;" target="_blank"
                                           href="/published/${groupExportedResource.exportedResource.processId}/web"
                                           class="tooltipped" data-position="right" data-delay="50"
                                           data-tooltip="Web"><i class="fa fa-globe"></i></a>
                                    </div>
                                    <g:if test="${groupExportedResource.exportedResource.resource.desktop}">
                                        <div class="col l4">
                                            <a style="font-size: 2em; color: black;" target="_blank"
                                               href="/published/${groupExportedResource.exportedResource.processId}/desktop/${groupExportedResource.exportedResource.resource.uri}-linux.zip"
                                               class="tooltipped" data-position="right" data-delay="50"
                                               data-tooltip="Linux"><i class="fa fa-linux"></i></a>
                                        </div>

                                        <div class="col l4">
                                            <a style="font-size: 2em; color: black;" target="_blank"
                                               href="/published/${groupExportedResource.exportedResource.processId}/desktop/${groupExportedResource.exportedResource.resource.uri}-windows.zip"
                                               class="tooltipped" data-position="right" data-delay="50"
                                               data-tooltip="Windows"><i class="fa fa-windows"></i></a> <br>
                                        </div>

                                        <div class="col l4">
                                            <a style="font-size: 2em; color: black;" target="_blank"
                                               href="/published/${groupExportedResource.exportedResource.processId}/desktop/${groupExportedResource.exportedResource.resource.uri}-mac.zip"
                                               class="tooltipped" data-position="right" data-delay="50"
                                               data-tooltip="Mac"><i class="fa fa-apple"></i></a> <br>
                                        </div>
                                    </g:if>

                                    <div class="col l4">
                                        <g:if test="${groupExportedResource.exportedResource.resource.android}">
                                            <a style="font-size: 2em; color: black;" target="_blank"
                                               href="/published/${groupExportedResource.exportedResource.processId}/mobile/${groupExportedResource.exportedResource.resource.uri}-android.zip"
                                               class="tooltipped" data-position="right" data-delay="50"
                                               data-tooltip="Android"><i class="fa fa-android"></i></a> <br>
                                        </g:if>
                                    </div>

                                    <div class="col l4">
                                        <g:if test="${groupExportedResource.exportedResource.resource.moodle}">
                                            <a style="font-size: 2em; color: black;" class="tooltipped"
                                               data-position="right" data-delay="50"
                                               data-tooltip="Disponível no Moodle"><i class="fa fa-graduation-cap"></i>
                                            </a>
                                        </g:if>
                                    </div>
                                </div>

                                <div class="divider"></div><br>

                                <div class="row">
                                    <div class="center">
                                        <g:if test="${group.owner.id == session.user.id}">
                                            <div class="col l4">
                                                <a class="modal-trigger"
                                                   href="#modal-confirmation-exported-resource-${groupExportedResource.id}"
                                                   style="cursor: pointer">
                                                    <i class="fa fa-trash fa-2x" data-tooltip="Descompartilhar"
                                                       style="color: #FF5722;"></i>
                                                </a>
                                            </div>
                                        </g:if>
                                        <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdmin(session.user, true)}">
                                            <div class="col l4">
                                                <a class="show-stats"
                                                   href="/group/stats/${group.id}?exp=${groupExportedResource.exportedResource.id}"
                                                   data-exported-resource-id="${groupExportedResource.exportedResource.id}"
                                                   style="cursor: pointer"
                                                   id="delete-resource-${groupExportedResource.id}"
                                                   data-resource-id="${groupExportedResource.id}">
                                                    <i class="fa fa-bar-chart fa-2x" style="color: #FF5722;"></i>
                                                </a>
                                            </div>
                                        </g:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="modal-confirmation-exported-resource-${groupExportedResource.id}" class="modal">
                            <div class="modal-content">
                                <p>Tem certeza que deseja realizar esta ação</p>
                            </div>

                            <div class="modal-footer">
                                <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Não</a>
                                <a id="delete-resource-${groupExportedResource.id}"
                                   data-resource-id="${groupExportedResource.id}"
                                   class="modal-action modal-close waves-effect waves-green btn-flat remove-resource">Sim</a>
                            </div>
                        </div>
                    </div>
                </g:each>
            </g:if>
        </div>
    </div>
</main>
    <div class="row">
        <div style="position: relative; left: 1em">
            <g:if test="${group.owner.id == session.user.id ||
                    UserGroup.findByUserAndAdminAndGroup(session.user, true, group)}">
                <ul class="collapsible popout" data-collapsible="expandable">
                    <li>
                        <g:if test="${groupExportedResources.empty}">
                            <div class="collapsible-header active">
                        </g:if>
                        <g:else>
                            <div class="collapsible-header">
                        </g:else>
                        Compartilhamento de Jogos
                    </div>
                        <div id="info" class="collapsible-body">
                            <div class="row">

                                Informações sobre o compartilhamento de jogos

                                <ul>
                                    <li>
                                        <p>Acesse <g:link controller="exportedResource"
                                                          action="publicGames">Banco de Jogos</g:link>
                                            ou <g:link controller="exportedResource"
                                                       action="MyGames">Meus Jogos</g:link></p>
                                    </li>
                                    <li>
                                        <p>Escolha um Jogo e clique na opção "Compartilhar para grupos" <i
                                                class="fa fa-users" style="color: #FF5722;"></i>

                                        <p>
                                    </li>
                                    <li>
                                        <p><span
                                                class="bold">Obs:</span>Você também pode compartilhar um jogo ao término de sua customização.
                                        </p>
                                    </li>

                                </ul>

                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </li>
                </ul>
            </g:if>
        </div>
    </div>

    
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <g:javascript src="delete-group-resources.js"/>
    <g:javascript src="manage-user-group.js"/>
    <g:javascript src="tooltip.js"/>
    <g:javascript src="edit-group.js"/>
    <g:javascript src="jquery/jquery.validate.js"/>
    <g:javascript src="tooltip.js"/>
</body>
</html>
