<%@ page import="br.ufscar.sead.loa.remar.GroupExportedResources" %>
<g:external dir="css" file="card.css" />

<main class="cardGames">
    <div class="row">

        <g:if test="${publicExportedResourcesList.size() == 0}">

        </g:if>
        <g:else>
            <g:each in="${publicExportedResourcesList}" var="instance">

                <div id="card${instance.id}" data-instance_id="${instance.id}" class="col l3 s5 fullCard">
                    <div class="card hoverable">
                        <div class="card-image waves-effect waves-light">
                            <img alt="${instance.name}" class="activator" src="/published/${instance.processId}/banner.png">
                        </div>
                        <div class="card-content">
                            <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate" data-category="${instance.resource.category.id}" title="${instance.name}">${instance.name}</span>
                            <div class="divider"></div>
                            <span style="color: dimgrey; font-size: 0.9em" class="center">${instance.resource.category.name}</span>
                            <span style="color: dimgrey; font-size: 0.9em" class="center truncate">Customizado por:
                                <a href="#!" style="color: margin-right:10px; cursor:pointer; font-style:normal" class="user-profile" id="user-id-${instance.owner.id}" >
                                    ${instance.owner.username}
                                </a></span>
                            <span style="color: dimgrey;" class="center">
                                <i class="fa fa-globe"></i>
                                <g:if test="${instance.resource.android}">
                                    <i class="fa fa-android" data-tooltip="Android"></i>
                                </g:if>
                                <g:if test="${instance.resource.desktop}">
                                    <i class="fa fa-windows" data-tooltip="Windows"></i>
                                    <i class="fa fa-linux" data-tooltip="Linux"></i>
                                    <i class="fa fa-apple" data-tooltip="Mac"></i>
                                </g:if>
                                <g:if test="${instance.resource.moodle}">
                                    <i class="fa fa-graduation-cap"></i>
                                </g:if>
                            </span>
                        </div>
                        <div class="right">
                            <i class="activator material-icons" style="color: black; cursor: pointer">more_vert</i>
                        </div>
                        <div class="card-reveal col l12">
                            <div class="row">
                                <h5 class="card-title grey-text text-darken-4 col l12"><small class="left">Jogar:</small><i class="material-icons right">close</i></h5><br>
                                <div class="col l4">
                                    <a style="font-size: 2em; color: black;" target="_blank" href="/published/${instance.processId}/web" class="tooltipped"  data-position="down" data-delay="50" data-tooltip="Web"><i class="fa fa-globe"></i></a>
                                </div>
                                <g:if test="${instance.resource.desktop}">
                                    <div class="col l4">
                                        <a style="font-size: 2em; color: black;" target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.uri}-linux.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Linux"><i class="fa fa-linux"></i></a>
                                    </div>
                                    <div class="col l4">
                                        <a style="font-size: 2em; color: black;" target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.uri}-windows.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Windows"><i class="fa fa-windows"></i></a> <br>
                                    </div>
                                    <div class="col l4">
                                        <a style="font-size: 2em; color: black;" target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.uri}-mac.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Mac"><i class="fa fa-apple"></i></a> <br>
                                    </div>
                                </g:if>

                                <div class="col l4">
                                    <g:if test="${instance.resource.android}">
                                        <a style="font-size: 2em; color: black;" target="_blank" href="/published/${instance.processId}/mobile/${instance.resource.uri}-android.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Android"><i class="fa fa-android"></i></a> <br>
                                    </g:if>
                                </div>
                                <div class="col l4">
                                    <g:if test="${instance.resource.moodle}">
                                        <a style="font-size: 2em; color: black;" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Disponível no Moodle"><i class="fa fa-graduation-cap"></i></a>
                                    </g:if>
                                </div>
                            </div>
                            <div class="divider"></div><br>
                            <div class="row">
                                <div class="center">
                                    <div class="col l4">
                                        <a style="font-size: 2em;" href="/exported-resource/info/${instance.id}"
                                           class="tooltipped"  data-position="down" data-delay="50" data-tooltip="Mais informações">
                                            <i class="fa fa-info-circle" style="color: #FF5722;"></i>
                                        </a>
                                    </div>
                                    <g:if test="${instance.resource.shareable}">
                                        <div class="col l4">
                                            <a style="font-size: 2em;" href="#modal-group" class="tooltipped compartilhaModal" data-position="down" data-delay="50" data-tooltip="Compartilhar para grupos">
                                                <i class="fa fa-users" style="color: #FF5722;"></i>
                                            </a>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <div class="col l4">
                                            <div style="font-size: 2em;" class="tooltipped" data-position="down" data-delay="50" data-tooltip="Sem compartilharmento para grupos">
                                                <i class="fa fa-users" style="color: #DCDCDC;"></i>
                                            </div>
                                        </div>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:else>

    %{--Modal for groups--}%
        <div id="modal-group" class="modal remar-modal shareModal">
            <div class="modal-content">
                %{--Preenchido pelo javascript--}%
            </div>
            <div class="modal-footer">
                <a class="modal-action modal-close btn waves-effect waves-light remar-orange" type="submit" name="action">Fechar</a>
            </div>
        </div>

    </div>
    <g:applyLayout name="pagination"/>
    <g:javascript src="utility/utility-public-game.js"/>
    <g:javascript src="showShares.js"/>
</main>
