<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>
<body>

    <div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                <i class="left small material-icons">create</i>Criar novo R.E.A
            </p>
            <div class="divider"></div>
        </div>

        <div class="card-list two-cards">
            <g:if test="${gameInstanceList.size() == 0}">
                <p>Não há nenhum R.E.A disponível para ser personalizado :(</p>
            </g:if>
            <g:else>
                <g:each in="${gameInstanceList}" var="gameInstance">
                    <div class="card square-cover small">
                        <div class="card-content">
                            <div class="cover">
                                <div class="cover-image-container">
                                    <div class="cover-outer-align">
                                        <div class="cover-inner-align">
                                            <img alt="A Head Full Of Dreams" class="cover-image img-responsive" src="https://lh3.googleusercontent.com/woc4V87mfN8LztxAI4pGvz33q6LKQHk9ULj1iEwjPM8u8hGUD4rmWsoh-Xo5kmkDdXDO5JHizw=w170-rw">
                                        </div>
                                    </div>
                                </div>
                                <a class="card-click-target" href="/store/music/album/Coldplay_A_Head_Full_Of_Dreams?id=B5b3fqfg3ty6xwifhgyzigjskwe"></a>
                            </div>
                            <div class="details">
                                <a class="card-click-target" href="/store/music/album/Coldplay_A_Head_Full_Of_Dreams?id=B5b3fqfg3ty6xwifhgyzigjskwe" aria-hidden="true" tabindex="-1"></a>
                                <a class="title" href="/store/music/album/Coldplay_A_Head_Full_Of_Dreams?id=B5b3fqfg3ty6xwifhgyzigjskwe" title="A Head Full Of Dreams" aria-hidden="true" tabindex="-1">  A Head Full Of Dreams</a>
                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: REMAR</p>
                                </div>
                            </div>
                            <div class="row no-margin margin-top">
                                <div class="col s6">
                                    <div class="pull-left tiny-stars">
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                    </div>
                                </div>
                                <div class="col s6">
                                    <div class="pull-right gray-color">
                                        <i class="tiny material-icons">public</i>
                                        <i class="tiny material-icons">android</i>
                                        <i class="tiny fa fa-linux"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:each>
            </g:else>
        </div>


    </div>

</body>
</html>
