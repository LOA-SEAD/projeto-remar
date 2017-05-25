<input type="hidden" id="resourceCount" value="${resourceInstanceList.size()}">
<g:each in="${resourceInstanceList}" status="i" var="resourceInstance">
    <div class=" col l3 m3 s6">
        <input type="hidden" id="cardStatus${i}" value="${resourceInstance.status}">
        <div id="card${i}" class=" card hoverable card-developer">
            <div class="card-image">
                <a href="edit/${resourceInstance.id}">
                <img id="image${resourceInstance.id}" alt="${resourceInstance.name}" class=""  src="/images/${resourceInstance.uri}-banner.png">
                </a>
            </div>
            <div class="card-content">
                <a class="title truncate" title="${resourceInstance.name}" aria-hidden="true" tabindex="-1" >${resourceInstance.name}</a>
                <p style="font-size: 1.0em;" class="center">Feito por:
                    <a href="#!" style="color: #FF5722 !important; margin-right:10px; cursor:pointer; font-style:normal"  class="user-profile" id="user-id-${resourceInstance.owner.id}" >
                        ${resourceInstance.owner.username}
                    </a>
                </p>
                <div class="divider"></div>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <input type="text" class="comment truncate" placeholder="Comentário"  value="${resourceInstance.comment}" data-id="${resourceInstance.id}">
                </sec:ifAllGranted>
                <sec:ifNotGranted roles="ROLE_ADMIN">
                    <input type="text" value="${resourceInstance.comment}" class="comment" data-id="${resourceInstance.id}" disabled>
                </sec:ifNotGranted>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <div class="col s3 m3 l3">
                        <a href="#" class="tooltipped  review"  data-review="approve" data-id="${resourceInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Aprovar" style="color: green;"><i class="material-icons">done</i></a>
                    </div>
                   %{-- <div class="col s3 m3 l3">
                        <a href="#" class="tooltipped  review" data-review="reject" data-id="${resourceInstance.id}" data-position="bottom" data-delay="5" data-tooltip="Rejeitar" style="color: red;"><i class="material-icons">block</i></a>
                    </div>--}%

                </sec:ifAllGranted>
                <div class="">
                    <a href="#" class="tooltipped delete" data-id="${resourceInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Excluir" style="color: gray;"><i class="material-icons">delete</i></a>
                </div>
            </div>

        </div>

    </div>
</g:each>
<g:javascript src="showResourceStatus.js"/>
