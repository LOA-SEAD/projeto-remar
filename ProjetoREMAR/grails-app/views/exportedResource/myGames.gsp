<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 21/01/16
  Time: 13:57
  Desc: Tela que lista os jogos do usuário
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Meus jogos</title>
    <meta name="layout" content="materialize-layout">

</head>

<body>


<div class="row cluster">

    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">recent_actors</i>Meus jogos
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

            <g:if test="${myExportedResourcesList.size() == 0}">
                <p>Você ainda não possui nenhum jogo!</p>
            </g:if>
            <g:else>
                <g:each in="${myExportedResourcesList}" var="myExportedResourceInstance">
                    <div class="card square-cover small hoverable my-card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <div class="cover-image-container">
                                <img alt="${myExportedResourceInstance.name}" class="cover-image img-responsive image-bg activator "
                                     src="${(myExportedResourceInstance.webUrl).substring(0,myExportedResourceInstance.webUrl.indexOf('w')-1)}/banner.png">
                            </div>
                            %{--<a class="card-click-target"  href="/resource/show/${myExportedResourceInstance.id}"></a>--}%
                        </div>
                        <div class="card-div">
                            <div class="card-content">
                                <div class="details">
                                    <p class="card-click-targ" aria-hidden="true" tabindex="-1"></p>
                                    <span class="title card-name activator" data-category="${myExportedResourceInstance.resource.category.id}" title="${myExportedResourceInstance.name}" aria-hidden="true" tabindex="-1">${myExportedResourceInstance.name}</span>
                                    %{--<div class="col s3">--}%
                                    %{--<img src="/data/users/${myExportedResourceInstance.resource.owner.username}/profile-picture"--}%
                                    %{--alt="${myExportedResourceInstance.resource.owner.firstName}" class="circle game-owner"--}%
                                    %{--data-beloworigin="true">--}%
                                    %{--</div>--}%
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
                                <div class="row">
                                    %{--<div class="col s6">--}%
                                    %{--<div class="pull-left tiny-stars">--}%
                                    %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                                    %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                                    %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                                    %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                                    %{--<img src="/images/star.png" width="14" height="14" alt="Estrela" />--}%
                                    %{--</div>--}%
                                    %{--</div>--}%
                                    <div class="col s1 offset-s9">
                                        <a class="dropdown-button" data-activates='dropdown${myExportedResourceInstance.id}'><i class="material-icons">more_vert</i></a>
                                        <!-- Dropdown Structure -->
                                        <ul id='dropdown${myExportedResourceInstance.id}' class='dropdown-content'>
                                            <li style="text-align: center;">
                                                <a href="/exported-resource/publish/${myExportedResourceInstance.id}"
                                                   class="tooltipped"  data-position="bottom" data-delay="50" data-tooltip="Editar">
                                                <i class="fa fa-pencil" style="color: #FF5722;" ></i>
                                                </a>
                                            </li>
                                            <li style="text-align: center;">
                                                <a href="/exported-resource/delete/${myExportedResourceInstance.id}"
                                                   class="tooltipped"  data-position="bottom" data-delay="50" data-tooltip="Excluir">
                                                <i class="fa fa-trash" style="color: #FF5722;"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4"><small class="left">Jogar:</small><i class="material-icons right">close</i></span>
                            <div class="clearfix"></div>
                            <div class="plataform-card left-align">
                                <g:if test="${myExportedResourceInstance.webUrl != null}">
                                    <a href="${myExportedResourceInstance.webUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão web"><i class="fa fa-globe"></i></a> <br>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.androidUrl != null}">
                                    <a href="${myExportedResourceInstance.androidUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão android"><i class="fa fa-android"></i></a> <br>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.linuxUrl != null}">
                                    <a href="${myExportedResourceInstance.linuxUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão linux"><i class="fa fa-linux"></i></a> <br>
                                </g:if>
                                <g:if test="${myExportedResourceInstance.moodleUrl != null}">
                                    <a href="${myExportedResourceInstance.moodleUrl}" class="tooltipped"  data-position="right" data-delay="50" data-tooltip="Versão moodle"><i class="fa fa-graduation-cap"></i></a>
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