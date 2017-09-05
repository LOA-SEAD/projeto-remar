<div class="col l3 s5">
    <div id="card-group-exported-resource-${groupExportedResource.id}" class="card hoverable shared-resource-card">
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
            <i class="activator material-icons remar-orange-text" style="cursor: pointer">more_vert</i>
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
                               data-position="bottom" data-delay="50" data-tooltip="Descompartilhar">
                                <i class="fa fa-trash fa-2x remar-orange-text"></i>
                            </a>
                        </div>
                    </g:if>
                    <g:if test="${group.owner.id == session.user.id || UserGroup.findByUserAndAdmin(session.user, true)}">
                        <div class="col l4">
                            <a class="show-stats tooltipped"
                               href="/group/stats/${group.id}?exp=${groupExportedResource.exportedResource.id}"
                               data-exported-resource-id="${groupExportedResource.exportedResource.id}"
                               id="delete-resource-${groupExportedResource.id}"
                               data-resource-id="${groupExportedResource.id}"
                               data-position="bottom" data-delay="50" data-tooltip="Estatísticas">
                                <i class="fa fa-bar-chart fa-2x remar-orange-text"></i>
                            </a>
                        </div>
                    </g:if>
                    <div class="col l4">
                        <a id="show-ranking-${groupExportedResource.id}" class="show-ranking tooltipped"
                           href="/group/rankUsers?groupId=${group.id}&exportedResourceId=${groupExportedResource.exportedResource.id}"
                           data-position="bottom" data-delay="50" data-tooltip="Ranking">
                            <i class="fa fa-trophy fa-2x remar-orange-text"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal de confirmação de exclusão -->
<div class="modal-wrapper-50">
    <div id="modal-confirmation-exported-resource-${groupExportedResource.id}" class="modal remar-modal">
        <div class="modal-content">
            <h4>Excluir Recurso</h4>

            <p>Tem certeza que deseja realizar esta ação</p>
        </div>

        <div class="modal-footer">
            <a class="modal-action modal-close btn waves-effect waves-light remar-orange remove-resource"
               data-resource-id="${groupExportedResource.exportedResource.id}">Sim</a>
            <a class="modal-action modal-close btn waves-effect waves-light remar-orange">Não</a>
        </div>
    </div>
</div>