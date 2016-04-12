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
            <i class="small material-icons left">videogame_asset</i>Jogos
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
                <option class="option" value="-1" selected>Todas</option>
                <g:if test="${categories.size() > 0}">
                    <g:each in="${categories}" var="category">
                        <option class="option" value="${category.id}">${category.name}</option>
                    </g:each>
                </g:if>
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
                <g:each in="${publicExportedResourcesList}" var="instance">
                    <div class="card square-cover small hoverable">
                        <div class="card-image waves-effect waves-block waves-light">
                            <div class="cover-image-container">
                                <img alt="${instance.name}"
                                     class="cover-image img-responsive image-bg activator "
                                     src="/published/${instance.processId}/banner.png?=${new Date()}">
                            </div>
                        </div>

                        <div class="card-content">
                            <div class="details">
                                <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                <span class="title card-name activator"
                                      data-category="${instance.resource.category.id}"
                                      title="${instance.name}" aria-hidden="true"
                                      tabindex="-1">${instance.name}</span>

                                <div class="subtitle-container">
                                    <p class="subtitle">Feito por: ${instance.owner.firstName}</p>
                                </div>

                                <div class="gray-color subtitle-container">
                                    <i class="fa fa-globe"></i>
                                    <g:if test="${instance.resource.android}">
                                        <i class="fa fa-android"></i>
                                    </g:if>
                                    <g:if test="${instance.resource.desktop}">
                                        <i class="fa fa-desktop"></i>
                                    </g:if>
                                    <g:if test="${instance.resource.moodle}">
                                        <i class="fa fa-graduation-cap"></i>
                                    </g:if>
                                </div>
                            </div>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4"><small class="left">Jogar:</small><i
                                    class="material-icons right">close</i></span>
                            <div class="clearfix"></div>
                            <div class="plataform-card left-align">
                                <div class="col s6">
                                    <a target="_blank" href="/published/${instance.processId}/web" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Web"><i class="fa fa-globe"></i></a> <br>
                                    <g:if test="${instance.resource.desktop}">
                                        <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.name}-linux.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Linux"><i class="fa fa-linux"></i></a> <br>
                                        <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.name}-windows.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Windows"><i class="fa fa-windows"></i></a> <br>
                                        <a target="_blank" href="/published/${instance.processId}/desktop/${instance.resource.name}-mac.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Mac"><i class="fa fa-apple"></i></a> <br>
                                    </g:if>
                                </div>
                                <div class="col s6">
                                    <g:if test="${instance.resource.android}">
                                        <a target="_blank" href="/published/${instance.processId}/mobile/${instance.resource.name}-android.zip" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Android"><i class="fa fa-android"></i></a> <br>
                                    </g:if>

                                    <g:if test="${instance.resource.moodle}">
                                        <a class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Disponível no Moodle"><i class="fa fa-graduation-cap"></i></a>
                                    </g:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:each>
            </g:else>
        </article>
    </div>
    <g:applyLayout name="pagination"/>
</div>
<g:javascript src="menu.js"/>
</body>
</html>