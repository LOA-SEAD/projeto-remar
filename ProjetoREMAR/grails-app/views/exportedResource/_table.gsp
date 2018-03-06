<ul class="collapsible" data-collapsible="expandable" id="collapsible-to-change-css">
    <li class="c">
        <div class="collapsible-header">
            <div class="my-div centered"><strong><g:message code="exportedResource.label.user" default="Usuário"/></strong></div>
            <div class="my-div centered"><strong><g:message code="exportedResource.label.rightAnswers" default="Acertos"/></strong></div>
            <div class="my-div centered"><strong><g:message code="exportedResource.label.wrongAnswers" default="Erros"/></strong></div>
            <div class="my-div centered"><strong><g:message code="exportedResource.label.performance" default="Aproveitamento"/></strong></div>
        </div>
    </li>
    <g:each in="${users}" var="user">
        <li>
            <div class="collapsible-header" data-user-id="${user.value.id}" data-exported-resource-id="${user.value.resourceId}">
                <div class="my-div">${user.value.name}</div>
                <div class="my-div centered">${user.value.hits}</div>
                <div class="my-div centered">${user.value.errors}</div>
                <div class="my-div centered"><g:formatNumber number="${100 * user.value.hits / (user.value.hits + user.value.errors)}" type="number" maxFractionDigits="2" />%</div>
            </div>
            <div class="collapsible-body no-padding">
                <div id="${user.value.id}-data">
                    <br />
                    <br />
                    <div class="preloader-wrapper big active">
                        <div class="spinner-layer spinner-blue-only">
                            <div class="circle-clipper left">
                                <div class="circle"></div>
                            </div><div class="gap-patch">
                            <div class="circle"></div>
                        </div><div class="circle-clipper right">
                            <div class="circle"></div>
                        </div>
                        </div>
                    </div>
                    <br />
                    <br />
                </div>
            </div>
        </li>
    </g:each>
</ul>

<script>
    $(document).ready(function(){
        $('.collapsible').collapsible();
    });

    $('.collapsible-header').on('click', function (e) {
        var userId = $(e.currentTarget).attr('data-user-id');
        var exportedResourceId = $(e.currentTarget).attr('data-exported-resource-id');
        $.ajax({
            url: '/exported-resource/_data.gsp',
            type: 'POST',
            data: { userId: userId, exportedResourceId: $('#mainSwiper').find('.swiper-slide-active').attr('data-hash') },
            success: function(data, status) {
                $('#'+userId+'-data').html(data);
            },
            error: function(data) {
            }
        });
    });
</script>
