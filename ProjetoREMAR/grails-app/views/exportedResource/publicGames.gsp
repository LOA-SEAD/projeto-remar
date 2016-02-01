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
                        <div class="card-content">
                            <div class="cover">
                                <div class="cover-image-container">
                                    <div class="cover-outer-align">
                                        <div class="cover-inner-align">
                                            <img alt="${exportedResourceInstance.name}" class="cover-image img-responsive image-bg "  src="/images/${exportedResourceInstance.resource.uri}-banner.png">
                                        </div>
                                    </div>
                                </div>
                                <a class="card-click-target"  href="/resource/show/${exportedResourceInstance.id}"></a>
                            </div>
                            <div class="details">
                                <a class="card-click-target"  href="/resource/show/${exportedResourceInstance.id}" aria-hidden="true" tabindex="-1"></a>
                                <a class="title card-name"  href="/resource/show/${exportedResourceInstance.id}" title="${exportedResourceInstance.name}" aria-hidden="true" tabindex="-1">${exportedResourceInstance.name}</a>
                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: ${exportedResourceInstance.owner.firstName}</p>
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
                                        <g:if test="${exportedResourceInstance.webUrl != null}">
                                            <a href="${exportedResourceInstance.webUrl}" ><i class="fa fa-globe"></i></a>
                                        </g:if>
                                        <g:if test="${exportedResourceInstance.androidUrl != null}">
                                            <a href="${exportedResourceInstance.androidUrl}"><i class="fa fa-android"></i></a>
                                        </g:if>
                                        <g:if test="${exportedResourceInstance.linuxUrl != null}">
                                            <a href="${exportedResourceInstance.linuxUrl}"><i class="fa fa-linux"></i></a>
                                        </g:if>
                                        <g:if test="${exportedResourceInstance.moodleUrl != null}">
                                            <a href="${exportedResourceInstance.moodleUrl}"><i class="fa fa-graduation-cap"></i></a>
                                        </g:if>
                                    </div>
                                </div>
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