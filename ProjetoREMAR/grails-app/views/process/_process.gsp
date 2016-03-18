<g:each in="${processes}" var="process">
    <a href="/process/overview/${process.id}">
        <g:if test="${process.pendingTasks.size() > 0}">
            <div class="card card-developer pending">
        </g:if>
        <g:else>
            <div class="card card-developer approved">
        </g:else>
        <div class="cover waves-effect waves-block waves-light">
            <img alt="${process.definition.name}" class="cover-image img-responsive image-bg "
                 src="/images/${process.definition.uri}-banner.png">
        </div>

        <div class="card-content">
            <div class="details">
                <a class="title" title="${process.definition.name}" aria-hidden="true"
                   tabindex="-1">${process.definition.name}</a>

                <div class="subtitle-container">
                    <p class="subtitle"><i class="fa fa-clock-o"></i> <g:formatDate format="dd/MM/yyyy HH:mm"
                                                                                    date="${process.createdAt}"/></p>
                </div>
            </div>

            <div class="row no-margin margin-top card-info">
                <div class="col s12">
                </div>
            </div>

            <div class="card-action">
                <div class="">
                    <div class="col s6">
                        <span class="tooltipped" data-position="bottom" data-delay="50"
                              data-tooltip="${process.pendingTasks.size()} tarefas pendentes" style="color: gray;">
                            <i class="material-icons">warning</i>
                        </span>
                    </div>

                    <div class="col s6">
                        <a class="tooltipped delete" href="/process/delete/${process.id}" data-position="bottom"
                           data-delay="50" data-tooltip="Excluir" style="color: gray;">
                            <i class="material-icons">delete</i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </a>
</g:each>