<g:each in="${processes}" var="process">
    <a class=""  href="/process/tasks/overview/${process[3]}">
        <g:if test="${process[1] > 0}">
            <div class="card card-developer pending">
        </g:if>
        <g:else>
            <div class="card card-developer approved">
        </g:else>
        <div class="card-content">
            <div class="cover">
                <div class="cover-image-container">
                    <div class="cover-outer-align">
                        <div class="cover-inner-align">
                            %{--<img alt="${process[0]}" class="cover-image img-responsive image-bg "  src="/images/${process[0]}-banner.png">--}%
                            <img alt="${process[0]}" class="cover-image img-responsive image-bg "  src="/images/escolamagica-banner.png">
                        </div>
                    </div>
                </div>
                <a class="activator" ></a>
            </div>
            <div class="details">
                <a class="title" title="${process[0]}" aria-hidden="true" tabindex="-1" >${process[0]}</a>
                %{--<div class="subtitle-container">--}%
                    %{--<p class="subtitle">Feito por: REMAR</p>--}%
                %{--</div>--}%
            </div>
            <div class="row no-margin margin-top card-info">
                <div class="col s12">
                    %{--<div class="right gray-color">--}%
                    %{--<i class="fa fa-globe"></i>--}%
                    %{--<g:if test="${gameInstance.android}">--}%
                    %{--<i class="fa fa-android"></i>--}%
                    %{--</g:if>--}%
                    %{--<g:if test="${gameInstance.linux}">--}%
                    %{--<i class="fa fa-linux"></i>--}%
                    %{--</g:if>--}%
                    %{--<g:if test="${gameInstance.moodle}">--}%
                    %{--<i class="fa fa-graduation-cap"></i>--}%
                    %{--</g:if>--}%
                    %{--</div>--}%
                </div>
            </div>
            <div class="card-action">
                %{--<div class="col s12">--}%
                   <input type="text" class="comment" placeholder="Comentário"  value=" ${process[1]} atividade(s)" disabled>
                   %{--<p style="margin-bottom: 10px;"></p>--}%
                    <div class="">
                        <a class="right tooltipped" href="/process/delete/${process[3]}" data-position="right" data-delay="50" data-tooltip="Excluir"><i class="material-icons">delete</i></a>
                    </div>
                %{--</div>--}%
            </div>
        </div>
    </div>
    </a>
</g:each>