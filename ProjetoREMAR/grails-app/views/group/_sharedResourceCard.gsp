<%@ page import="br.ufscar.sead.loa.remar.GroupExportedResources" %>
<%@ page import="br.ufscar.sead.loa.remar.UserGroup" %>

<g:external dir="css" file="card.css"/>

<main class="cardGames">
    <div class="row">
        <g:if test="${groupExportedResources.size() > 0}">
            <g:each in="${groupExportedResources}" var="groupExportedResource">

                <div id="card${groupExportedResource.exportedResource.id}" data-groupExportedResource.exportedResource_id="${groupExportedResource.exportedResource.id}" class="col l2 m4 s6 fullCard">
                    <div class="card hoverable">

                        <div class="card-image waves-effect waves-light">
                            <img alt="${groupExportedResource.exportedResource.name}" class="activator"
                                 src="/published/${groupExportedResource.exportedResource.processId}/banner.png">
                        </div>

                        <div class="card-content">
                            <span class="card-title flow-text grey-text text-darken-4 activator valign-wrapper truncate no-padding"
                                  data-category="${groupExportedResource.exportedResource.resource.category.id}" title="${groupExportedResource.exportedResource.name}">
                                <p class="no-margin truncate">${groupExportedResource.exportedResource.name}</p>
                                <i class="material-icons right remar-orange-text">more_vert</i>
                            </span>

                            <div class="divider"></div>
                            <span>${groupExportedResource.exportedResource.resource.category.name}</span>
                            <span class="truncate">
                                <g:message code="group.label.madeBy" default="Feito por"/>:
                                <a href="#!" class="user-profile" id="user-id-${groupExportedResource.exportedResource.owner.id}">
                                    ${groupExportedResource.exportedResource.owner.username}
                                </a>
                            </span>
                            <span>
                                <i class="fa fa-globe tooltipped" data-tooltip="Web"></i>
                                <g:if test="${groupExportedResource.exportedResource.resource.android}">
                                    <i class="fa fa-android tooltipped" data-tooltip="Android"></i>
                                </g:if>
                                <g:if test="${groupExportedResource.exportedResource.resource.desktop}">
                                    <i class="fa fa-windows tooltipped" data-tooltip="Windows"></i>
                                    <i class="fa fa-linux tooltipped" data-tooltip="Linux"></i>
                                    <i class="fa fa-apple tooltipped" data-tooltip="Mac"></i>
                                </g:if>
                                <g:if test="${groupExportedResource.exportedResource.resource.moodle}">
                                    <i class="fa fa-graduation-cap"></i>
                                </g:if>
                            </span>
                        </div>

                        <div class="card-reveal col s12">
                            <div class="row no-margin">
                                <div class="col s6 no-padding">
                                    <h6 class="grey-text text-darken-4 no-margin">
                                        <g:message code="group.label.play" default="Jogar"/>
                                    </h6>
                                </div>

                                <div class="col s6 no-padding">
                                    <div class="row no-margin card-title valign-wrapper right-align remar-lightorange-text">
                                        <i class="material-icons">close</i>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col s6 m4 l3">
                                    <a target="_blank" href="/published/${groupExportedResource.exportedResource.processId}/web" class="tooltipped"
                                       data-position="down" data-delay="50" data-tooltip="Web"><i
                                            class="fa fa-globe"></i></a>
                                </div>
                                <g:if test="${groupExportedResource.exportedResource.resource.desktop}">
                                    <div class="col s6 m4 l3">
                                        <a target="_blank"
                                           href="/published/${groupExportedResource.exportedResource.processId}/desktop/${groupExportedResource.exportedResource.resource.uri}-linux.zip"
                                           class="tooltipped" data-position="right" data-delay="50"
                                           data-tooltip="Linux"><i class="fa fa-linux"></i></a>
                                    </div>

                                    <div class="col s6 m4 l3">
                                        <a target="_blank"
                                           href="/published/${groupExportedResource.exportedResource.processId}/desktop/${groupExportedResource.exportedResource.resource.uri}-windows.zip"
                                           class="tooltipped" data-position="right" data-delay="50"
                                           data-tooltip="Windows"><i class="fa fa-windows"></i></a> <br>
                                    </div>

                                    <div class="col s6 m4 l3">
                                        <a target="_blank"
                                           href="/published/${groupExportedResource.exportedResource.processId}/desktop/${groupExportedResource.exportedResource.resource.uri}-mac.zip"
                                           class="tooltipped" data-position="right" data-delay="50"
                                           data-tooltip="Mac"><i class="fa fa-apple"></i></a> <br>
                                    </div>
                                </g:if>

                                <div class="col s6 m4 l3">
                                    <g:if test="${groupExportedResource.exportedResource.resource.android}">
                                        <a target="_blank"
                                           href="/published/${groupExportedResource.exportedResource.processId}/mobile/${groupExportedResource.exportedResource.resource.uri}-android.zip"
                                           class="tooltipped" data-position="right" data-delay="50"
                                           data-tooltip="Android"><i class="fa fa-android"></i></a> <br>
                                    </g:if>
                                </div>

                                <div class="col s6 m4 l3">
                                    <g:if test="${groupExportedResource.exportedResource.resource.moodle}">
                                        <a class="tooltipped" data-position="right" data-delay="50"
                                           data-tooltip="Disponível no Moodle"><i class="fa fa-graduation-cap"></i></a>
                                    </g:if>
                                </div>
                            </div>

                            <div class="divider"></div><br>

                            <div class="row">
                                <div class="col s6 m4 l3">
                                    <a href="/exported-resource/info/${groupExportedResource.exportedResource.id}"
                                       class="tooltipped" data-position="bottom" data-delay="50"
                                       data-tooltip="Mais informações">
                                        <i class="fa fa-info-circle"></i>
                                    </a>
                                </div>
                                <div class="col s6 m4 l3">
                                    <a id="show-ranking-${groupExportedResource.id}" class="show-ranking tooltipped"
                                       href="/group/rankUsers?groupId=${group.id}&exportedResourceId=${groupExportedResource.exportedResource.id}"
                                       data-position="bottom" data-delay="50" data-tooltip="Ranking">
                                        <i class="fa fa-trophy remar-orange-text"></i>
                                    </a>
                                </div>
                                <g:if test="${group.owner.id == session.user.id}">
                                    <div class="col s6 m4 l3">
                                        <a class="modal-trigger tooltipped"
                                           href="#modal-confirmation-exported-resource-${groupExportedResource.id}"
                                           data-position="bottom" data-delay="50" data-tooltip="Descompartilhar">
                                            <i class="fa fa-ban remar-orange-text"></i>
                                        </a>
                                    </div>
                                </g:if>
                                <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdmin(session.user, true)}">
                                    <div class="col s6 m4 l3">
                                        <a class="show-stats tooltipped"
                                           href="/stats/analysis/?groupId=${group.id}&exportedResourceId=${groupExportedResource.exportedResource.id}"
                                           data-exported-resource-id="${groupExportedResource.exportedResource.id}"
                                           id="delete-resource-${groupExportedResource.id}"
                                           data-resource-id="${groupExportedResource.id}"
                                           data-position="bottom" data-delay="50" data-tooltip="Estatísticas">
                                            <i class="fa fa-bar-chart remar-orange-text"></i>
                                        </a>
                                    </div>
                                </g:if>
                            </div>

                            <div class="row">

                            </div>

                            <div class="divider"></div><br>

                            <div class="license-info license-image-only center-align"
                                 data-license="${groupExportedResource.exportedResource.license}"></div>
                        </div>
                    </div>
                </div>

                <!-- Modal de confirmação de exclusão -->
                <div class="modal-wrapper-50">
                    <div id="modal-confirmation-exported-resource-${groupExportedResource.id}"
                         class="modal remar-modal">
                        <div class="modal-content">
                            <h4><g:message code="group.label.deleteResource" default="Excluir Recurso"/></h4>

                            <p><g:message code="group.message.confirmAction" default="Tem certeza que deseja realizar esta ação?"/></p>
                        </div>

                        <div class="modal-footer">
                            <a class="modal-action modal-close btn waves-effect waves-light remar-orange remove-resource"
                               data-resource-id="${groupExportedResource.exportedResource.id}">Sim</a>
                            <a class="modal-action modal-close btn waves-effect waves-light remar-orange">Não</a>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:if>

    %{--Modal for groups--}%
        <div id="modal-group" class="modal remar-modal shareModal">
            <div class="modal-content">
                %{--Preenchido pelo javascript--}%
            </div>

            <div class="modal-footer">
                <a class="modal-action modal-close btn waves-effect waves-light remar-orange" type="submit"
                   name="action"><g:message code="group.label.close" default="Fechar"/></a>
            </div>
        </div>

    </div>
    <g:applyLayout name="pagination"/>
    <g:javascript src="remar/utility/utility-public-game.js"/>
    <g:javascript src="remar/licenseShow.js"/>
</main>
