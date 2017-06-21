<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>

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
                            <span style="font-size: 1.3em;" class="card-title grey-text text-darken-4 activator center-align truncate data-category="${resourceInstance.category.id}" title="${resourceInstance.name}">${resourceInstance.name}</span>
                            <div class="divider"></div>
                            <span style="color: dimgrey; font-size: 0.9em" class="center">${resourceInstance.category.name}</span>
                            <span style="color: dimgrey; font-size: 0.9em" class="center truncate">Feito por:
                                <a href="#!" style="color: #FF5722 !important; margin-right:10px; cursor:pointer; font-style:normal"  class="user-profile" id="user-id-${resourceInstance.owner.id}" >
                                    ${resourceInstance.owner.username}
                                </a></span>
                            <span style="color: dimgrey;" class="center">
                                <i class="fa fa-globe"></i>
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
                            </span>
                        </div>
                    </div>
                </div>
            </g:each>
        </g:else>
    </article>
    <g:applyLayout name="pagination"/>
</main>

