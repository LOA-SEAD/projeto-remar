<%@ page import="br.ufscar.sead.loa.remar.GroupExportedResources" %>
<g:external dir="css" file="card.css" />

<main class="cardGames">
    <div class="row">
        <g:if test="${publicExportedResourcesList.size() > 0}">
            <g:each in="${publicExportedResourcesList}" var="instance">

                <div id="card${instance.id}" data-instance_id="${instance.id}" class="col l2 m4 s6 fullCard">
                    <div class="card hoverable">

                        <div class="card-image waves-effect waves-light">
                            <img alt="${instance.name}" class="activator" src="/published/${instance.processId}/banner.png">
                        </div>

                        <div class="card-content">
                            <span class="card-title flow-text grey-text text-darken-4 activator valign-wrapper truncate no-padding"
                                  data-category="${instance.resource.category.id}" title="${instance.name}">
                                <p class="no-margin truncate">${instance.name}</p>
                                <i class="material-icons right remar-orange-text">more_vert</i>
                            </span>

                            <div class="divider"></div>

                            <span>${instance.resource.category.name}</span>
                            <span class="truncate">
                                <g:message code="exportedResource.label.madeBy" default="Feito por:"/>
                                <a href="#!" class="user-profile" id="user-id-${instance.owner.id}">
                                    ${instance.owner.username}
                                </a>
                            </span>
                            <span>
                                <i class="fa fa-globe tooltipped" data-tooltip="Web"></i>
                                <g:if test="${instance.resource.android}">
                                    <i class="fa fa-android tooltipped" data-tooltip="Android"></i>
                                </g:if>
                                <g:if test="${instance.resource.desktop}">
                                    <i class="fa fa-windows tooltipped" data-tooltip="Windows"></i>
                                    <i class="fa fa-linux tooltipped" data-tooltip="Linux"></i>
                                    <i class="fa fa-apple tooltipped" data-tooltip="Mac"></i>
                                </g:if>
                                <g:if test="${instance.resource.moodle}">
                                    <i class="fa fa-graduation-cap"></i>
                                </g:if>
                            </span>
                        </div>

                        <div class="card-reveal col s12">
                            <div class="row no-margin">
                                <div class="col s6 no-padding">
                                    <h6 class="grey-text text-darken-4 no-margin">
                                        <g:message code="exportedResource.label.play" default="Jogar"/>
                                    </h6>
                                </div>
                                <div class="col s6 no-padding">
                                    <div class="row no-margin card-title valign-wrapper right-align">
                                        <i class="material-icons">close</i>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s6 m4 l3">
                                    <a target="_blank" href="/published/${instance.processId}/web" class="tooltipped"
                                       data-position="bottom" data-delay="50" data-tooltip="Web">
                                        <i class="fa fa-globe"></i>
                                    </a>
                                </div>
                                <g:if test="${instance.resource.desktop}">
                                    <div class="col s6 m4 l3">
                                        <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.uri}-linux.zip" class="tooltipped"
                                           data-position="bottom" data-delay="50" data-tooltip="Linux">
                                            <i class="fa fa-linux"></i>
                                        </a>
                                    </div>
                                    <div class="col s6 m4 l3">
                                        <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.uri}-windows.zip" class="tooltipped"
                                           data-position="bottom" data-delay="50" data-tooltip="Windows">
                                            <i class="fa fa-windows"></i>
                                        </a>
                                    </div>
                                    <div class="col s6 m4 l3">
                                        <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.uri}-mac.zip" class="tooltipped"
                                           data-position="bottom" data-delay="50" data-tooltip="Mac">
                                            <i class="fa fa-apple"></i>
                                        </a>
                                    </div>
                                </g:if>
                                <div class="col s6 m4 l3">
                                    <g:if test="${instance.resource.android}">
                                        <a target="_blank" href="/published/${instance.processId}/mobile/${instance.resource.uri}-android.zip" class="tooltipped"
                                           data-position="bottom" data-delay="50" data-tooltip="Android">
                                            <i class="fa fa-android"></i>
                                        </a>
                                    </g:if>
                                </div>
                                <div class="col s6 m4 l3">
                                    <g:if test="${instance.resource.moodle}">
                                        <a target="_blank" class="tooltipped"
                                           data-position="right" data-delay="50" data-tooltip="Disponível no Moodle">
                                            <i class="fa fa-graduation-cap"></i>
                                        </a>
                                    </g:if>
                                </div>
                            </div>

                            <div class="divider"></div>
                            <br/>

                            <div class="row">
                                <div class="col s6 m4 l3">
                                    <a href="/exported-resource/info/${instance.id}" class="tooltipped"
                                       data-position="bottom" data-delay="50" data-tooltip="Mais informações">
                                        <i class="fa fa-info-circle"></i>
                                    </a>
                                </div>
                                <g:if test="${!(mode == 'public')}">
                                    <g:if test="${instance.resource.shareable}">
                                        <div class="col s6 m4 l3">
                                            <a href="#modal-group" class="tooltipped compartilhaModal"
                                               data-position="bottom" data-delay="50" data-tooltip="Compartilhar para grupos">
                                                <i class="fa fa-users"></i>
                                            </a>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <div class="col s6 m4 l3">
                                            <div class="tooltipped"
                                                 data-position="bottom" data-delay="50" data-tooltip="Sem compartilharmento para grupos">
                                                <i class="fa fa-users"></i>
                                            </div>
                                        </div>
                                    </g:else>
                                    <div class="col s6 m4 l3 ">
                                        <a href="#modal-delete-exported-resource" class="tooltipped modal-trigger deleteExportedResource"
                                           data-position="bottom" data-delay="50" data-tooltip="Excluir">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </div>
                                </g:if>
                            </div>

                            <div class="divider"></div>
                            <br/>

                            <div class="license-info license-image-only center-align" data-license="${instance.license}"></div>
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
                <a class="modal-action modal-close btn waves-effect waves-light remar-orange" type="submit" name="action">Fechar</a>
            </div>
        </div>

        %{--Modal for delete--}%
        <div class="modal-wrapper-50">
            <div id="modal-delete-exported-resource" class="modal remar-modal">
                <div class="modal-content">
                    <h4><g:message code="exportedResource.label.deleteCustomizingGame" default="Excluir Jogo em Customização"/></h4>

                    <p><g:message code="exportedResource.label.confirmAction" default="Tem certeza que deseja realizar esta ação?"/></p>
                </div>

                <div class="modal-footer">
                    <a id="confirmDeleteExpResource" class="modal-action modal-close btn waves-effect waves-light remar-orange">Sim</a>
                    <a class="modal-action modal-close btn waves-effect waves-light remar-orange">Não</a>
                </div>
            </div>
        </div>

    </div>

    <g:applyLayout name="pagination"/>
    <g:if test='${page == 'myGames'}'>
    <g:javascript src="remar/utility/utility-my-game.js"/>
  </g:if>
    <g:elseif test="${page == 'publicGames'}">
    <g:javascript src="remar/utility/utility-public-game.js"/>
  </g:elseif>
    <g:javascript src="remar/licenseShow.js"/>
    <g:javascript src="remar/resource.actions.js"/>
</main>
