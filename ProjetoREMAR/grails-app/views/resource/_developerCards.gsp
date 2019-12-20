<input type="hidden" id="resourceCount" value="${resourceInstanceList.size()}">
<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
<g:each in="${resourceInstanceList}" status="i" var="resourceInstance">
    <div id="card-id-${resourceInstance.id}" class="col l2 m4 s6">
        <input type="hidden" id="cardStatus${i}" value="${resourceInstance.status}">

        <div id="card${i}" class="card hoverable card-developer">

            <div class="card-image">
                <a href="edit/${resourceInstance.id}">
                    <img id="image${resourceInstance.id}" alt="${resourceInstance.name}" class=""  src="/images/${resourceInstance.uri}-banner.png">
                </a>
            </div>

            <div class="card-content">
                <span class="card-title flow-text grey-text text-darken-4 valign-wrapper no-padding"
                      data-category="${resourceInstance.category.id}" title="${resourceInstance.name}">
                    <p class="truncate no-margin">${resourceInstance.name}</p>
                </span>

                <div class="divider"></div>

                <span class="truncate">
                    Feito por:
                    <a href="#userDetailsModal" class="user-profile" id="user-id-${resourceInstance.owner.id}">
                        ${resourceInstance.owner.username}
                    </a>
                </span>

                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <span class="truncate">
                        Status: ${resourceInstance.comment}
                    </span>
                </sec:ifAllGranted>

                <sec:ifNotGranted roles="ROLE_ADMIN">
                    <input type="text"  value="${resourceInstance.comment}" class="comment" data-id="${resourceInstance.id}" disabled>
                </sec:ifNotGranted>


                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <div class="row no-margin">
                        <g:if test="${resourceInstance.comment != "Aprovado"}">
                            <div class="col s6 m6 l6 center">
                                <a href="#" id="conteudo${i}" class="tooltipped review card-front-button"  data-review="approve" data-id="${resourceInstance.id}" data-position="bottom" data-delay="5" data-tooltip="Aprovar"><i class="fa fa-2x fa-check"></i></a>
                            </div>
                            <div class="col s6 m6 l6 center">
                                <a href="#" class="tooltipped delete card-front-button" data-id="${resourceInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Excluir"><i class="fa fa-2x fa-trash"></i></a>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="col s12 m12 l12 center">
                                <a href="#" class="tooltipped delete card-front-button" data-id="${resourceInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Excluir"><i class="fa fa-2x fa-trash"></i></a>
                            </div>
                        </g:else>
                    </div>
                </sec:ifAllGranted>

                <sec:ifNotGranted roles="ROLE_ADMIN">
                    <div class="row no-margin">
                        <div class="col s12 m12 l12 center">
                            <a href="#" class="tooltipped delete card-front-button" data-id="${resourceInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Excluir"><i class="fa fa-2x fa-trash"></i></a>
                        </div>
                    </div>
                </sec:ifNotGranted>

            </div>

        </div>
    </div>
</g:each>

<g:javascript src="remar/user/showProfile.js"/>
<g:javascript src="remar/showResourceStatus.js"/>
