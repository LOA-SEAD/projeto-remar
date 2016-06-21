<main class="cardGames">
    <article class="row">
        <g:if test="${gameInstanceList.size() == 0}">
        </g:if>
        <g:else>
            <g:each in="${gameInstanceList}" var="gameInstance">
                <div class="col l3 s5">
                    <div style="position: relative; left: 1em" class="card hoverable">
                        <div class="card-image waves-effect waves-block waves-light">
                            <a href="/resource/show/${gameInstance.id}"><img alt="${gameInstance.name}" class="activator" src="/images/${gameInstance.uri}-banner.png"></a>
                        </div>
                        <div class="card-content">
                            %{--<a class="card-click-target"  href="/resource/show/${gameInstance.id}" aria-hidden="true" tabindex="-1"></a>--}%
                            <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate data-category="${gameInstance.category.id}" title="${gameInstance.name}">${gameInstance.name}</span>
                            <div class="divider"></div>
                            <span style="color: dimgrey; font-size: 0.9em" class="center">${gameInstance.category.name}</span>
                            <span style="color: dimgrey; font-size: 0.9em" class="center truncate">Feito por: ${gameInstance.owner.username}</span>
                            <span style="color: dimgrey;" class="center">
                                <i class="fa fa-globe"></i>
                                <g:if test="${gameInstance.android}">
                                    <i class="fa fa-android"></i>
                                </g:if>
                                <g:if test="${gameInstance.desktop}">
                                    <i class="fa fa-windows"></i>
                                    <i class="fa fa-linux"></i>
                                    <i class="fa fa-apple"></i>
                                </g:if>
                                <g:if test="${gameInstance.moodle}">
                                    <i class="fa fa-graduation-cap"></i>
                                </g:if>
                            </span>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:else>
    </article>
    <g:applyLayout name="pagination"/>
</main>

