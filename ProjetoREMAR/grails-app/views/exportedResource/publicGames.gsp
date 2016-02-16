<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 21/01/16
  Time: 13:57
  Desc: Tela que lista os jogos públicos
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Jogos Públicos</title>
    <meta name="layout" content="materialize-layout">

</head>

<body>
<div class="row cluster">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">public</i>Jogos públicos
        </p>
        <div class="divider"></div>
    </div>
    <div class="row search">
        <div class="input-field col s6">
            <input id="search" type="text" class="validate">
            <label for="search"><i class="fa fa-search"></i></label>
        </div>
        <div class="input-field col s6">
            <select>
                <option value="1" selected>Todas</option>
                <option value="2">Ação</option>
                <option value="3">Aventura</option>
                <option value="4">Educacional</option>
            </select>
            <label>Categoria</label>
        </div>
    </div>
    <div class="row show cards">
        <article class="row">
            <g:if test="${publicExportedResourcesList.size() == 0}">
                <p>Ainda não existe nenhum jogo disponível para ser jogado!.</p>
            </g:if>
            <g:else>
                <g:each in="${publicExportedResourcesList}" var="exportedResourceInstance">
                    <div class="card square-cover small hoverable">
                        <div class="card-image waves-effect waves-block waves-light">
                            <div class="cover-image-container">
                                <img alt="${exportedResourceInstance.name}" class="cover-image img-responsive image-bg activator "
                                     src="${(exportedResourceInstance.webUrl).substring(0,exportedResourceInstance.webUrl.indexOf('w')-1)}/banner.png">
                            </div>
                            %{--<a class="card-click-target"  href="/resource/show/${exportedResourceInstance.id}"></a>--}%
                        </div>
                        <div class="card-content">
                            <div class="details">
                                <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                <span class="title card-name activator" title="${exportedResourceInstance.name}" aria-hidden="true" tabindex="-1">${exportedResourceInstance.name}</span>
                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: ${exportedResourceInstance.owner.firstName}</p>
                                </div>
                            </div>
                            <div class="row no-margin margin-top">
                                <div class="col s5">
                                    <div class="pull-left tiny-stars">
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        <img src="/images/star.png" width="14" height="14" alt="Estrela" />
                                        %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                                    </div>
                                </div>
                                <div class="col s7">
                                    <div class="pull-right gray-color">
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
            </g:else>
        </article>
    </div>
    <footer class="row">
        <ul class="pagination">
            <li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
            <li class="active"><a href="#!">1</a></li>
            <li class="waves-effect"><a href="#!">2</a></li>
            <li class="waves-effect"><a href="#!">3</a></li>
            <li class="waves-effect"><a href="#!">4</a></li>
            <li class="waves-effect"><a href="#!">5</a></li>
            <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
        </ul>
    </footer>
</div>
<g:javascript src="menu.js"/>
</body>
</html>