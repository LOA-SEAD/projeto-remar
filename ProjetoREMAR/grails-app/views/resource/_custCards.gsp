<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>

<main class="cardGames">
    <article class="row">
        <g:if test="${resourceInstanceList.size() != 0}">
            <g:each in="${resourceInstanceList}" var="resourceInstance">
                <div class="col l3 s5">
                    <div style="position: relative; left: 1em" class="card hoverable">
                        <div class="card-image waves-effect waves-block waves-light">
                            <a href="/resource/show/${resourceInstance.id}"><img alt="${resourceInstance.name}" class="activator" src="/images/${resourceInstance.uri}-banner.png"></a>
                        </div>
                        <div class="card-content">
                            <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate data-category="${resourceInstance.category.id}" title="${resourceInstance.name}">${resourceInstance.name}</span>
                            <div class="divider"></div>

                            <div style="color: dimgrey; font-size: 0.9em" class="row no-margin center-align">
                                ${resourceInstance.category.name}
                            </div>

                            <div style="color: dimgrey; font-size: 0.9em" class="row no-margin center-align truncate">Feito por:
                                <a href="#userDetailsModal" class="user-profile" id="user-id-${resourceInstance.owner.id}" >
                                    ${resourceInstance.owner.username}
                                </a>
                            </div>

                            <div style="color: dimgrey;" class="row no-margin center-align">
                                <i class="tooltipped fa fa-globe" data-tooltip="Web"></i>
                                <g:if test="${resourceInstance.android}">
                                    <i class="tooltipped fa fa-android" data-tooltip="Android"></i>
                                </g:if>
                                <g:if test="${resourceInstance.desktop}">
                                    <i class="tooltipped fa fa-windows" data-tooltip="Windows"></i>
                                    <i class="tooltipped fa fa-linux" data-tooltip="Linux"></i>
                                    <i class="tooltipped fa fa-apple" data-tooltip="Mac"></i>
                                </g:if>
                                <g:if test="${resourceInstance.moodle}">
                                    <i class="fa fa-graduation-cap"></i>
                                </g:if>
                            </div>
                            <div style="color: dimgrey;" class="row no-margin center-align">
                                <g:if test="${resourceInstance.shareable}">
                                    <i class="tooltipped fa fa-users" data-tooltip="${g.message(code:'tooltips.shareable')}"></i>
                                </g:if>
                                <g:else>
                                    <br>
                                </g:else>
                            </div>

                            <div class="row no-margin center-align">
                                <g:if test="${resourceInstance.sumUser == 0}">
                                    <div class="rating-dashboard" data-stars="0"></div>
                                </g:if>
                                <g:else>
                                    <div class="rating-dashboard"
                                         data-stars="${resourceInstance.sumStars / resourceInstance.sumUser}"></div>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:if>
    </article>

    <g:applyLayout name="pagination"/>
</main>

