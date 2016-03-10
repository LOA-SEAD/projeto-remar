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
    <div class="row show">

        <g:if test="${gameInstanceList.size() == 0}">
            <div class="row description">
                <p class="valign">Não há nenhum jogo disponível para ser customizado!</p>
            </div>
        </g:if>
        <g:else>
            <div class="subtitle">
                <p class="text-teal text-darken-3 left-align margin-bottom">
                    <i class="small material-icons left">new_releases</i>Confira os últimos jogos disponíveis para customização!
                </p>
            </div>
            <div class="row">
                <div class="center slick">
                    <g:each in="${gameInstanceList}" var="gameInstance">
                        <div class="card square-cover small dashboard">
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
                                    <a class="title card-name" data-category="${gameInstance.category.id}" href="/resource/show/${gameInstance.id}" title="${gameInstance.name}" aria-hidden="true" tabindex="-1">${gameInstance.name}</a>
                                    <div class="subtitle-container">
                                        <p class="subtitle">Feito por: ${gameInstance.owner.firstName}</p>
                                    </div>
                                    <div class="gray-color subtitle-container">
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
                                    </div>
                                </div>
                                <div class="row no-margin margin-top">
                                    <div class="col s12">
                                        <div class="pull-left tiny-stars">
                                            <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                            <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                            <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                            <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                            <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
        </g:else>

        <g:if test="${publicExportedResourcesList.size() > 0}">
            <div class="subtitle space">
                <p class="text-teal text-darken-3 left-align margin-bottom">
                    <i class="small material-icons left">new_releases</i>Estes são alguns jogos publicos, jogue-os agora mesmo!
                </p>
            </div>
            <div class="center slick">
                <g:each in="${publicExportedResourcesList}" var="exportedResourceInstance">
                    <div class="card square-cover small dashboard">
                        <div class="card-content">
                            <div class="cover">
                                <div class="cover-image-container">
                                    <div class="cover-outer-align">
                                        <div class="cover-inner-align">
                                            <img alt="${exportedResourceInstance.name}" class="cover-image img-responsive image-bg activator "
                                                 src="${(exportedResourceInstance.webUrl).substring(0,exportedResourceInstance.webUrl.indexOf('w')-1)}/banner.png">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="details">
                                <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                <span class="title card-name activator" data-category="${exportedResourceInstance.resource.category.id}" title="${exportedResourceInstance.name}" aria-hidden="true" tabindex="-1">${exportedResourceInstance.name}</span>
                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: ${exportedResourceInstance.owner.firstName}</p>
                                </div>
                                <div class="gray-color subtitle-container">
                                    <g:if test="${exportedResourceInstance.webUrl != null}">
                                        <i class="fa fa-globe"></i>
                                    </g:if>
                                    <g:if test="${exportedResourceInstance.androidUrl != null}">
                                        <i class="fa fa-android"></i>
                                    </g:if>
                                    <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                        <i class="fa fa-linux"></i>
                                    </g:if>
                                    <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                        <i class="fa fa-graduation-cap"></i>
                                    </g:if>
                                </div>
                            </div>
                            <div class="row no-margin margin-top">
                                <div class="col s12">
                                    <div class="pull-left tiny-stars">
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4"><small class="left">Jogar:</small><i class="material-icons right">close</i></span>
                            <div class="clearfix"></div>
                            <div class="plataform-card left-align">
                                <g:if test="${exportedResourceInstance.webUrl != null}">
                                    <a href="${exportedResourceInstance.webUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão web"><i class="fa fa-globe"></i></a>
                                </g:if>
                                <g:if test="${exportedResourceInstance.androidUrl != null}">
                                    <a href="${exportedResourceInstance.androidUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão android"><i class="fa fa-android"></i></a>
                                </g:if>
                                <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                    <a href="${exportedResourceInstance.linuxUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão linux"><i class="fa fa-linux"></i></a>
                                </g:if>
                                <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                    <a href="${exportedResourceInstance.moodleUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão moodle"><i class="fa fa-graduation-cap"></i></a>
                                </g:if>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </g:if>


        <g:if test="${myExportedResourcesList.size() > 0}">
            <div class="subtitle space">
                <p class="text-teal text-darken-3 left-align margin-bottom">
                    <i class="small material-icons left">new_releases</i>Aqui estão alguns dos jogos que você mesmo customizou!
                </p>
            </div>
            <div class="center slick">
                <g:each in="${myExportedResourcesList}" var="myExportedResourceInstance">
                    <div class="card square-cover small dashboard">
                        <div class="card-content">
                            <div class="cover">
                                <div class="cover-image-container">
                                    <div class="cover-outer-align">
                                        <div class="cover-inner-align">
                                            <img alt="${myExportedResourceInstance.name}" class="cover-image img-responsive image-bg activator "
                                                 src="${(myExportedResourceInstance.webUrl).substring(0,myExportedResourceInstance.webUrl.indexOf('w')-1)}/banner.png">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="details">
                                <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                <span class="title card-name activator" data-category="${myExportedResourceInstance.resource.category.id}" title="${myExportedResourceInstance.name}" aria-hidden="true" tabindex="-1">${myExportedResourceInstance.name}</span>
                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: ${myExportedResourceInstance.owner.firstName}</p>
                                </div>
                                <div class="gray-color subtitle-container">
                                    <g:if test="${myExportedResourceInstance.webUrl != null}">
                                        <i class="fa fa-globe"></i>
                                    </g:if>
                                    <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                        <i class="fa fa-android"></i>
                                    </g:if>
                                    <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                        <i class="fa fa-linux"></i>
                                    </g:if>
                                    <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                        <i class="fa fa-graduation-cap"></i>
                                    </g:if>
                                </div>
                            </div>
                            <div class="row no-margin margin-top">
                                <div class="col s12">
                                    <div class="pull-left tiny-stars">
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4"><small class="left">Jogar:</small><i class="material-icons right">close</i></span>
                            <div class="clearfix"></div>
                            <div class="plataform-card left-align">
                                <g:if test="${myExportedResourceInstance.webUrl != null}">
                                    <a href="${myExportedResourceInstance.webUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão web"><i class="fa fa-globe"></i></a>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                    <a href="${myExportedResourceInstance.androidUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão android"><i class="fa fa-android"></i></a>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                    <a href="${myExportedResourceInstance.linuxUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão linux"><i class="fa fa-linux"></i></a>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                    <a href="${myExportedResourceInstance.moodleUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão moodle"><i class="fa fa-graduation-cap"></i></a>
                                </g:if>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </g:if>
    </div>
</div>
</body>
</html>
