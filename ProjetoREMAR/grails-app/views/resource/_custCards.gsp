<main class="cardGames">
    <article class="row">
        <g:if test="${resourceInstanceList.size() == 0}">
        </g:if>
        <g:else>
            <g:each in="${resourceInstanceList}" var="resourceInstance">
                <div class="col l3 s5">
                    <div style="position: relative; left: 1em" class="card hoverable">
                        <div class="card-image waves-effect waves-block waves-light">
                            <a href="/resource/show/${resourceInstance.id}"><img alt="${resourceInstance.name}" class="activator" src="/images/${resourceInstance.uri}-banner.png"></a>
                        </div>
                        <div class="card-content">
                            %{--<a class="card-click-target"  href="/resource/show/${resourceInstance.id}" aria-hidden="true" tabindex="-1"></a>--}%
                            <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate data-category="${resourceInstance.category.id}" title="${resourceInstance.name}">${resourceInstance.name}</span>
                            <div class="divider"></div>
                            <span style="color: dimgrey; font-size: 0.9em" class="center">${resourceInstance.category.name}</span>
                            <span style="color: dimgrey; font-size: 0.9em" class="center truncate">Feito por:
                                <a href="#!" style="color: #7d8fff !important; margin-right:10px; cursor:pointer; font-style:normal"  class="user-profile" id="user-id-${resourceInstance.owner.id}" >
                                    ${resourceInstance.owner.username}
                                </a></span>
                            <span style="color: dimgrey;" class="center">
                                <i class="fa fa-globe"></i>
                                <g:if test="${resourceInstance.android}">
                                    <i class="fa fa-android"></i>
                                </g:if>
                                <g:if test="${resourceInstance.desktop}">
                                    <i class="fa fa-windows"></i>
                                    <i class="fa fa-linux"></i>
                                    <i class="fa fa-apple"></i>
                                </g:if>
                                <g:if test="${resourceInstance.moodle}">
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

