<%@ page import="br.ufscar.sead.loa.remar.Group; br.ufscar.sead.loa.remar.UserGroup" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>
    <body>
        <div class="row cluster">
            <div class="row">
                <div class="cluster-header">
                    <div id="main-header" class="row" style="margin-bottom: 0px">
                        <div class="col s6 left-align">
                            <h4 id="group-name">${group.name}</h4>
                            <g:if test="${group.owner.id == session.user.id}">
                                <h7>Código de acesso: ${group.token}</h7>
                            </g:if>
                        </div>

                        <div class="col s6">
                            <div class="row right-align" style="margin-bottom: 0px">
                                <g:if test="${group.owner.id == session.user.id}">
                                    <div class="row" style="margin:0px;">
                                        <g:link action="edit" id="${group.id}" class="tooltipped" data-position="left" data-delay="30" data-tootip="Gerenciar Grupo">
                                            <i class="fa fa-cog fa-2x"></i>
                                        </g:link>
                                    </div>
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

                <div class="row show">
                    <!-- Jogos Compartilhados -->
                    <div class="cardGames">
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
                                                                    <a class="modal-trigger tooltipped"
                                                                       href="#modal-confirmation-exported-resource-${groupExportedResource.id}"
                                                                       style="cursor: pointer"
                                                                       data-position="bottom" data-delay="50" data-tooltip="Descompartilhar">
                                                                        <i class="fa fa-trash fa-2x" style="color: #FF5722;"></i>
                                                                    </a>
                                                                </div>
                                                            </g:if>
                                                            <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdmin(session.user, true)}">
                                                                <div class="col l4">
                                                                    <a class="show-stats tooltipped"
                                                                       href="/group/stats/${group.id}?exp=${groupExportedResource.exportedResource.id}"
                                                                       data-exported-resource-id="${groupExportedResource.exportedResource.id}"
                                                                       style="cursor: pointer"
                                                                       id="delete-resource-${groupExportedResource.id}"
                                                                       data-resource-id="${groupExportedResource.id}"
                                                                       data-position="bottom" data-delay="50" data-tooltip="Estatísticas">
                                                                        <i class="fa fa-bar-chart fa-2x" style="color: #FF5722;"></i>
                                                                    </a>
                                                                </div>
                                                            </g:if>
                                                            <div class="col l4">
                                                                <a id="show-ranking-${groupExportedResource.id}" class="show-ranking tooltipped"
                                                                   href="/group/rankUsers?groupId=${group.id}&exportedResourceId=${groupExportedResource.exportedResource.id}"
                                                                   data-exported-resource-id="${groupExportedResource.exportedResource.id}"
                                                                   data-resource-id="${groupExportedResource.id}"
                                                                   data-position="bottom" data-delay="50" data-tooltip="Ranking">
                                                                    <i class="fa fa-trophy fa-2x" style="color: #FF55722;"></i>
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal de confirmação de exclusão -->
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
                                    </g:each>
                                </g:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdminAndGroup(session.user, true, group)}">
            <!-- Compartilhamento de Jogos -->
            <div class="row cluster">
                <div class="row">
                    <div class="cluster-header">
        	            <h4>Compartilhamento de Jogos</h4>
        	            <div class="divider"></div>
        	        </div>
        	        <div class="row show">
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
            </div>
        </g:if>

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


        <link type="text/css" rel="stylesheet" href="${resource(dir: "css/user", file: "profile.css")}" />
        <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "group.css")}" />

        <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <g:javascript src="group/delete-group-resources.js"/>
        <g:javascript src="group/manage-user-group.js"/>
        <g:javascript src="group/edit-group.js"/>
        <g:javascript src="group/group-ranking.js"/>
        <g:javascript src="jquery/jquery.validate.js"/>
    </body>
</html>
