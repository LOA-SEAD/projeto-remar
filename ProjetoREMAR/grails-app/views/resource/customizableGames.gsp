<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 21/01/16
  Time: 13:57
  Desc: Tela que lista os jogos customizáveis
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Jogos Customizávies</title>
    <meta name="layout" content="materialize-layout">

</head>

<body>
    <div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                <i class="small material-icons left">create</i>Jogos customizáveis
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
                <g:if test="${gameInstanceList.size() == 0}">
                    <p>Ainda não existe nenhum jogo disponível para ser customizado!.</p>
                </g:if>
                <g:else>
                    <g:each in="${gameInstanceList}" var="gameInstance">
                        <div class="card square-cover small hoverable">
                            <div class="card-image waves-effect waves-block waves-light">
                                <img alt="${gameInstance.name}" class="cover-image img-responsive image-bg "  src="/images/${gameInstance.uri}-banner.png">
                                <a class="card-click-target"  href="/resource/show/${gameInstance.id}"></a>
                            </div>
                            <div class="card-content">
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