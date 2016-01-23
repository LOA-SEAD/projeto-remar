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
            <p class="text-teal text-darken-3 left-align margin-bottom center dashboard-title">
                Olá ${session.user.firstName}, seja bem vindo ao REMAR!
            </p>
            <div class="divider"></div>
        </div>

        <div class="card-list two-cards">
            <g:if test="${gameInstanceList.size() == 0}">
                <p>Não há nenhum R.E.A disponível para ser personalizado :(</p>
            </g:if>
            <g:else>
                <div class="row show">
                    <div id="slick" class="center">
                        <g:each in="${gameInstanceList}" var="gameInstance">
                            <div class="card square-cover small">
                                <div class="card-content">
                                    <div class="cover">
                                        <div class="cover-image-container">
                                            <div class="cover-outer-align">
                                                <div class="cover-inner-align">
                                                    <img alt="${gameInstance.name}" class="cover-image img-responsive image-bg "  src="/images/${gameInstance.uri}-banner.png">
                                                </div>
                                            </div>
                                        </div>
                                        <a class="card-click-target"  href="/resource/show/${gameInstance.id}"></a>
                                    </div>
                                    <div class="details">
                                        <a class="card-click-target"  href="/resource/show/${gameInstance.id}" aria-hidden="true" tabindex="-1"></a>
                                        <a class="title truncate"  href="/resource/show/${gameInstance.id}" title="${gameInstance.name}s" aria-hidden="true" tabindex="-1">${gameInstance.name}</a>
                                        <div class="subtitle-container">
                                            <p class="subtitle truncate">Feito por: ${gameInstance.owner.firstName}</p>
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
                                                <i class="fa fa-globe"></i>
                                                <g:if test="${gameInstance.android}">
                                                    <i class="fa fa-android"></i>
                                                </g:if>
                                                <g:if test="${gameInstance.linux}">
                                                    <i class="fa fa-linux"></i>
                                                </g:if>
                                                <g:if test="${gameInstance.moodle}">
                                                    <i class="fa fa-graduation-cap"></i>
                                                </g:if>
                                            %{--<i class="tiny material-icons">public</i>--}%
                                            %{--<i class="tiny material-icons">android</i>--}%
                                            %{--<i class="tiny fa fa-linux"></i>--}%
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
            </g:else>
        </div>
    </div>
</body>
</html>
