<main class="cardGames">
    <article class="row">
        <g:if test="${gameInstanceList.size() == 0}">
        </g:if>
        <g:else>
            <g:each in="${gameInstanceList}" var="gameInstance">
                <div class="card square-cover small hoverable">
                    <div class="card-image waves-effect waves-block waves-light">
                        <img alt="${gameInstance.name}" class="cover-image img-responsive image-bg "  src="/images/${gameInstance.uri}-banner.png">
                        <a class="card-click-target"  href="/resource/show/${gameInstance.id}"></a>
                    </div>
                    <div class="card-content">
                        <div class="details">
                            <a class="card-click-target"  href="/resource/show/${gameInstance.id}" aria-hidden="true" tabindex="-1"></a>
                            <a class="title card-name" data-category="${gameInstance.category.id}" href="/resource/show/${gameInstance.id}" title="${gameInstance.name}" aria-hidden="true" tabindex="-1">${gameInstance.name}</a>
                            <div class="subtitle-container">
                                <p class="subtitle">Feito por: ${gameInstance.owner.firstName}</p>
                            </div>
                            <div class="gray-color subtitle-container">
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
                            </div>
                        </div>
                        <div class="row no-margin margin-top">
                            <div class="col s12 no-padding">
                                <div class="left">
                                    <g:if test="${gameInstance.sumUser == 0}">
                                        <div id="rateYo-main" style="display: inline-block;"
                                             data-stars="0"></div>
                                    </g:if>
                                    <g:else>
                                        <div class="rating-card"
                                             data-stars="${gameInstance.sumStars / gameInstance.sumUser}"></div>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:else>
    </article>
    <g:applyLayout name="pagination"/>
</main>

