<g:each in="${resourceInstanceList}" status="i" var="gameInstance">
    <a class=""  href="/resource/edit/${gameInstance.id}">
        <g:if test="${gameInstance.status == 'pending'}">
            <div class="card card-developer pending">
        </g:if>
        <g:elseif test="${gameInstance.status == 'approved'}">
            <div class="card card-developer approved">
        </g:elseif>
        <g:elseif test="${gameInstance.status == 'rejected'}">
            <div class="card card-developer rejected">
        </g:elseif>
        <div class="card-content">
            <div class="cover">
                <div class="cover-image-container">
                    <div class="cover-outer-align">
                        <div class="cover-inner-align">
                            <img alt="A Head Full Of Dreams" class="cover-image img-responsive activator" src="https://lh3.googleusercontent.com/woc4V87mfN8LztxAI4pGvz33q6LKQHk9ULj1iEwjPM8u8hGUD4rmWsoh-Xo5kmkDdXDO5JHizw=w170-rw">
                        </div>
                    </div>
                </div>
                <a class="activator" ></a>
            </div>
            <div class="details">
                %{--<a class="card-click-target"  href="/resource/show/${gameInstance.id}" aria-hidden="true" tabindex="-1"></a>--}%
                <a class="title" title=${gameInstance.name}" aria-hidden="true" tabindex="-1">${gameInstance.name}</a>
                <div class="subtitle-container">
                    <p class="subtitle">Feito por: REMAR</p>
                </div>
            </div>
            <div class="row no-margin margin-top card-info">
                %{--<div class="col s6">--}%
                %{--<div class="pull-left tiny-stars">--}%
                %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                %{--</div>--}%
                %{--</div>--}%
                <div class="col s12">
                    <div class="right gray-color">
                        <i class="tiny material-icons">public</i>
                        <i class="tiny material-icons">android</i>
                        <i class="tiny fa fa-linux"></i>
                    </div>
                </div>
            </div>
            <div class="card-action">
                <div class="col s12">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <input type="text" class="comment" placeholder="Comentário"  value="${gameInstance.comment}">
                    </sec:ifAllGranted>
                    <sec:ifNotGranted roles="ROLE_ADMIN">
                        <input type="text" value="${gameInstance.comment}" class="comment" disabled>
                    </sec:ifNotGranted>
                    <div class="">
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <a href="#" class="tooltipped  review"  data-review="approve" data-id="${gameInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Aprovar" style="color: green;"><i class="material-icons">done</i></a>
                            <a href="#" class="tooltipped  review" data-review="reject" data-id="${gameInstance.id}" data-position="bottom" data-delay="5" data-tooltip="Rejeitar" style="color: red;"><i class="material-icons">block</i></a>
                        </sec:ifAllGranted>
                        <a href="#" class="tooltipped delete" data-id="${gameInstance.id}"  data-position="bottom" data-delay="5" data-tooltip="Excluir" style="color: gray;"><i class="material-icons">delete</i></a>

                    </div>
                </div>
            </div>
        </div>
        </div>
    </a>
</g:each>