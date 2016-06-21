    <main class="cardProcess">
        <article class="row">
            <g:each in="${processes}" var="process">
                %{--<g:if test="${process.pendingTasks.size() > 0}">--}%
                <div class="col l3 s5">
                        <div  class="card hoverable">
                            <a href="/process/overview/${process.id}">
                                <div class="card-image waves-effect waves-block waves-light">
                                   <img alt="${process.definition.name}" class="activator "
                                        src="/data/processes/${process.id}/banner.png?${new java.util.Date()}">
                                </div>
                            </a>
                            <div class="card-content">
                                <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate">${process.name}</span>
                                <div class="divider"></div>
                                <p style="font-size: 1.0em;" class="truncate"> <i class="fa fa-pencil" aria-hidden="true"></i>${process.definition.name}</p>
                                <p style="font-size: 1.0em;"><i class="fa fa-clock-o"></i> <g:formatDate format="dd/MM/yyyy HH:mm"
                                                                                                                date="${process.createdAt}"/></p>
                            </div>
                            <div class="card-reveal">
                                <div class="row">
                                    <div class="col l4">
                                        <a class="tooltipped delete" onclick=" if(confirm('Deseja mesmo excluir este processo?')){ href='/process/delete/${process.id}'}"
                                           data-position="right" data-delay="50" data-tooltip="Excluir" style="color: gray; cursor: pointer;">
                                            <i class="fa fa-trash fa-2x" style="color: #FF5722;"></i>
                                        </a>
                                    </div>
                                    <h5 class="card-title grey-text text-darken-4 col l8"><i class="material-icons right">close</i></h5><br>

                                </div>
                            </div>
                                <div class="right">
                                    <i class="activator material-icons" style="color: black; cursor: pointer">more_vert</i>
                                </div>
                        </div>
                </div>
                %{--</g:if>--}%
            </g:each>
        </article>
        %{--<g:applyLayout name="tab-pagination"/>--}%
    </main>

