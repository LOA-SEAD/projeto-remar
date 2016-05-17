    <main class="cardProcess">
        <article class="row">
            <g:each in="${processes}" var="process">
                <g:if test="${process.pendingTasks.size() > 0}">
                    <a href="/process/overview/${process.id}">
                        <div class="card square-cover small hoverable my-card">
                            <div class="card-image waves-effect waves-block waves-light">
                               <div class="cover-image-container">
                                   <img alt="${process.definition.name}" class="cover-image img-responsive image-bg activator "
                                        src="/data/processes/${process.id}/banner.png?${new java.util.Date()}">
                               </div>
                            </div>
                            <div class="card-div">
                                <div class="card-content">
                                    <div class="details">
                                        <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                        <span class="title card-name activator  truncate" data-category="" aria-hidden="true" tabindex="-1">${process.name}</span>
                                        <div class="info-card">
                                            <div class="subtitle-container">
                                                <p class="subtitle truncate"><i class="fa fa-pencil" aria-hidden="true"></i>
                                                    ${process.definition.name}</p>
                                            </div>
                                            <div class="subtitle-container">
                                                <p class="subtitle"><i class="fa fa-clock-o"></i> <g:formatDate format="dd/MM/yyyy HH:mm"
                                                                                                                date="${process.createdAt}"/></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row no-margin-bottom">
                                        <div class="col s1 offset-s9">
                                            <a class="dropdown-button" data-activates='dropdown${process.id}'><i class="material-icons" style="color: black;">more_vert</i></a>
                                            <!-- Dropdown Structure -->
                                            <ul id='dropdown${process.id}' class='dropdown-content'>
                                                <li style="text-align: center;">
                                                    <a class="tooltipped delete" onclick=" if(confirm('Deseja mesmo excluir este processo?')){ href='/process/delete/${process.id}'}"
                                                       data-position="right" data-delay="50" data-tooltip="Excluir" style="color: gray;">
                                                        <i class="fa fa-trash" style="color: #FF5722;"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </g:if>
            </g:each>
        </article>
        <g:applyLayout name="pagination" params="${processVariables}"/>
    </main>

