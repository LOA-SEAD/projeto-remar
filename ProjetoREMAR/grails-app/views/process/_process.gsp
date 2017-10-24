<main class="cardGames">
    <div class="row">
        <g:each in="${processes}" var="process">
            <div id="card${process.id}" data-instance_id="${process.id}" class="col l2 m4 s6 fullCard">
                <div class="card hoverable">

                    <div class="card-image waves-effect waves-light">
                        <img alt="${process.definition.name}" class="activator"
                             src="/data/processes/${process.id}/banner.png?${new java.util.Date()}">
                    </div>

                    <div class="card-content">
                        <span class="card-title flow-text grey-text text-darken-4 activator valign-wrapper truncate no-padding" title="${process.name}">
                            <p class="no-margin truncate">${process.name}</p>
                        </span>

                        <div class="divider"></div>

                        <div class="row no-margin valign-wrapper">
                            <div class="col s2 no-padding center">
                                <span>
                                    <i class="material-icons tiny">games</i>
                                </span>
                            </div>
                            <div class="col s10">
                                <span>
                                    ${process.definition.name}
                                </span>
                            </div>
                        </div>

                        <div class="row no-margin valign-wrapper">
                            <div class="col s2 no-padding center">
                                <span>
                                    <i class="material-icons tiny">access_time</i>
                                </span>
                            </div>
                            <div class="col s12">
                                <span>
                                    <g:formatDate format="dd/MM/yyyy HH:mm" date="${process.createdAt}"/>
                                </span>
                            </div>
                        </div>

                        <div class="row no-margin">
                            <div class="col s6 center">
                                <a class="tooltipped modal-trigger card-front-button" href="/process/overview/${process.id}"
                                   data-position="right" data-delay="50" data-tooltip="Continuar Editando">
                                    <i class="fa fa-pencil fa-2x"></i>
                                </a>
                            </div>
                            <div class="col s6 center">
                                <a class="tooltipped modal-trigger card-front-button" href="#modal-confirmation-process-${process.id}"
                                   data-position="right" data-delay="50" data-tooltip="Excluir">
                                    <i class="fa fa-trash fa-2x"></i>
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Modal de confirmação de exclusão -->
            <div class="modal-wrapper-50">
                <div id="modal-confirmation-process-${process.id}"
                     class="modal remar-modal">
                    <div class="modal-content">
                        <h4>Excluir Jogo em Customização</h4>

                        <p>Tem certeza que deseja realizar esta ação</p>
                    </div>

                    <div class="modal-footer">
                        <a class="modal-action modal-close btn waves-effect waves-light remar-orange"
                           href="/process/delete/${process.id}">Sim</a>
                        <a class="modal-action modal-close btn waves-effect waves-light remar-orange">Não</a>
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</main>

