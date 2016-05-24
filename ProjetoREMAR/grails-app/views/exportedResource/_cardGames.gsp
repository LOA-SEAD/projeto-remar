<main class="cardGames">
    <article class="row">
        <g:if test="${publicExportedResourcesList.size() == 0}">

        </g:if>
        <g:else>
            <g:each in="${publicExportedResourcesList}" var="instance">
                <div class="card square-cover small hoverable my-card">
                    <div class="card-image waves-effect waves-block waves-light">
                        <div class="cover-image-container">
                            <img alt="${instance.name}" class="cover-image img-responsive image-bg activator "
                                 src="/published/${instance.processId}/banner.png">
                        </div>
                    </div>
                    <div class="card-div">
                        <div class="card-content">
                            <div class="details">
                                <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                <span class="title card-name activator truncate" data-category="${instance.resource.category.id}" title="${instance.name}" aria-hidden="true" tabindex="-1">${instance.name}</span>
                                <div class="info-card">
                                    <div class="subtitle-container">
                                        <p class="subtitle">${instance.resource.category.name}</p>
                                    </div>
                                    <div class="subtitle-container">
                                        <p class="subtitle">Feito por: ${instance.owner.firstName}</p>
                                    </div>
                                    <div class="gray-color subtitle-container bold">
                                        <i class="fa fa-globe"></i>
                                        <g:if test="${instance.resource.android}">
                                            <i class="fa fa-android"></i>
                                        </g:if>
                                        <g:if test="${instance.resource.desktop}">
                                            <i class="fa fa-windows"></i>
                                            <i class="fa fa-linux"></i>
                                            <i class="fa fa-apple"></i>
                                        </g:if>
                                        <g:if test="${instance.resource.moodle}">
                                            <i class="fa fa-graduation-cap"></i>
                                        </g:if>
                                    </div>
                                </div>

                            </div>
                            <div class="row no-margin-bottom">
                                <div class="col s1 offset-s9">
                                    <a class="dropdown-button" data-activates='dropdown${instance.id}'><i class="material-icons" style="color: black;">more_vert</i></a>
                                    <!-- Dropdown Structure -->
                                    <ul id='dropdown${instance.id}' class='dropdown-content'>
                                        <li style="text-align: center;">
                                            <a href="/exported-resource/publish/${instance.id}"
                                               class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Mais informações">
                                                <i class="fa fa-info-circle" style="color: #FF5722;"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="card-reveal">
                        <span class="card-title grey-text text-darken-4"><small class="left">Jogar:</small><i class="material-icons right">close</i></span>
                        <div class="clearfix"></div>
                        <div class="plataform-card left-align">
                            <div class="col s6">
                                <a target="_blank" href="/published/${instance.processId}/web" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Web"><i class="fa fa-globe"></i></a> <br>
                                <g:if test="${instance.resource.desktop}">
                                    <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.name}-linux.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Linux"><i class="fa fa-linux"></i></a> <br>
                                    <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.name}-windows.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Windows"><i class="fa fa-windows"></i></a> <br>
                                    <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.name}-mac.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Mac"><i class="fa fa-apple"></i></a> <br>
                                </g:if>
                            </div>
                            <div class="col s6">
                                <g:if test="${instance.resource.android}">
                                    <a target="_blank" href="/published/${instance.processId}/mobile/${instance.resource.name}-android.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Android"><i class="fa fa-android"></i></a> <br>
                                </g:if>

                                <g:if test="${instance.resource.moodle}">
                                    <a class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Disponível no Moodle"><i class="fa fa-graduation-cap"></i></a>
                                </g:if>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:else>
    </article>
    <g:applyLayout name="pagination"/>
</main>

