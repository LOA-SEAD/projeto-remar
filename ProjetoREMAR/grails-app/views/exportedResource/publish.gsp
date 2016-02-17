<%--
Created by IntelliJ IDEA.
User: loa
Date: 10/06/15
Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title></title>
</head>
<body>

<div class="row cluster">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">games</i>Publicar jogo
        </p>
        <div class="divider"></div>
    </div>
    <div class="row show">
        <div class="row">
            <ul class="collapsible popout" data-collapsible="expandable">
                <li>
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    <div class="collapsible-header active"> <i class="material-icons">info_outline</i>Informações básicas</div>
                    <div class="collapsible-body">
                        <div class="row">
                            <div class="input-field col s6">
                                <i class="material-icons suffix green-text active">done</i>
                                <input value="${resourceName}" id="name" type="text" class="validate" data-resource-id="${resourceId}">
                                <label class="active" for="name" data-error="" data-success="">Nome do jogo</label>
                                <span id="name-error" class="invalid-input" style="left: 0.75rem">Já existe um jogo com esse nome!</span>
                            </div>
                            <div class="input-field col s6">
                                <select>
                                    <option value="1" selected>Todas</option>
                                    <option value="2">Ação</option>
                                    <option value="3">Aventura</option>
                                    <option value="4">Educacional</option>
                                </select>
                                <label>Escolha uma categoria</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s2 img-preview">
                                <img id="img1Preview" class="materialboxed" width="100" height="100" src="${resourceInstanceUrl}/banner.png" />
                            </div>
                            <div class="col s10">
                                <div class="file-field input-field">
                                    <div class="btn waves-effect waves-light my-orange">
                                        <span>File</span>
                                        <input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png"  >
                                    </div>
                                    <div class="file-path-wrapper">
                                        <i class="material-icons suffix green-text active">done</i>
                                        <input class="file-path validate" type="text" id="img-1-text"  placeholder="Carregue um novo icone customizado para o jogo, se desejado!" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </li>
                <li>
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    <div class="collapsible-header active"><i class="material-icons">view_column</i>Informações adicionais</div>
                        <div class="collapsible-body">
                            <div class="row" style="margin: 0;">
                                <div class="col s6">
                                        <p class="title">Tipo: </p>
                                        %{--<div class="divider"></div>--}%

                                        <p>
                                            <input type="radio" name="type" value="public" checked/>
                                            <label>Público</label>
                                        </p>
                                        %{--<div class="form-group">--}%
                                            %{--<input type="radio" name="type" value="private" disabled readonly/>--}%
                                            %{--<label>Privado</label>--}%
                                            %{--<span class="label label-warning">Em breve</span>--}%
                                        %{--</div>--}%
                                        %{--<div class="form-group">--}%
                                            %{--<input type="radio" name="type" value="group" disabled readonly />--}%
                                            %{--<label>Grupo</label>--}%
                                            %{--<select disabled>--}%
                                                %{--<option>Turma 1</option>--}%
                                            %{--</select>--}%
                                        %{--</div>--}%
                                </div>
                                <div class="col s6 platforms">
                                    <p class="title">Plataformas: </p>
                                    %{--<div class="divider"></div>--}%

                                    %{--<g:set var="link" value="null" scope="page" />--}%

                                    <g:each in="${platforms}" var="platform">
                                        <g:if test="${platform.contains(':')}">
                                            <p>
                                                <input type="checkbox" id="web" checked="checked" class="checkbox-platform"  disabled />
                                                <label for="web" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Web">
                                                    <i class="fa fa-globe" ></i>
                                                    <span class="chip center">
                                                        <a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>
                                                        <i class="fa fa-link"></i>
                                                    </span>
                                                    %{--<g:set var="link" value="${platform.substring(platform.indexOf(':') + 1)}" scope="page" />--}%
                                                </label>
                                            </p>
                                        </g:if>
                                        <g:else>
                                            <g:if test="${platform.toLowerCase() == 'windows'}">
                                                <p>
                                                    <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform" disabled readonly/>
                                                    <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Windows">
                                                        <i class="fa fa-windows"></i>
                                                        <span class="label label-warning">Em breve</span>
                                                    </label>
                                                </p>
                                            </g:if>
                                            <g:else>
                                                <g:if test="${platform.toLowerCase() == 'moodle'}">
                                                    <g:if test="${session.user.moodleUsername == null}">
                                                        <p>
                                                            <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform" disabled readonly/>
                                                            <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Moodle">
                                                                <i class="fa fa-graduation-cap"></i>
                                                                <span class="chip center">
                                                                    Vincule sua conta ao Moodle
                                                                    <i class="material-icons">close</i>
                                                                </span>
                                                            </label>
                                                        </p>
                                                    </g:if>
                                                    <g:else>
                                                        <p>
                                                            <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform"/>
                                                            <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Moodle">
                                                                <i class="fa fa-graduation-cap"></i>
                                                            </label>
                                                        </p>
                                                    </g:else>
                                                </g:if>
                                                <g:else>
                                                    <g:if test="${platform.toLowerCase() == 'android'}">
                                                        <p>
                                                            <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform" disabled readonly/>
                                                            <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Android">
                                                                <i class="fa fa-android"></i>
                                                                %{--<a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>--}%
                                                            </label>
                                                        </p>
                                                    </g:if>
                                                    <g:else>
                                                        <g:if test="${platform.toLowerCase() == 'android'}">
                                                            <p>
                                                                <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform"/>
                                                                <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Linux">
                                                                    <i class="fa fa-linux"></i>
                                                                </label>
                                                            </p>
                                                        </g:if>
                                                    </g:else>
                                                </g:else>
                                            </g:else>
                                        </g:else>
                                    </g:each>
                                    %{--<p>--}%
                                        %{--<input type="checkbox" name="windows" id="windows" class="checkbox-platform" disabled readonly/>--}%
                                        %{--<label for="windows"  class="tooltipped" data-position="right" data-delay="50" data-tooltip="Windows">--}%
                                            %{--<i class="fa fa-windows"></i>--}%
                                            %{--<a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>--}%
                                        %{--</label>--}%
                                    %{--</p>--}%
                            </div>
                            <div class="row">
                                <div class="col s12" >
                                    <div class="send-publish right">
                                        <div id="preloader-wrapper" class="preloader-wrapper small active right">
                                            <div class="spinner-layer spinner-red-only">
                                                <div class="circle-clipper left">
                                                    <div class="circle"></div>
                                                </div><div class="gap-patch">
                                                <div class="circle"></div>
                                            </div><div class="circle-clipper right">
                                                <div class="circle"></div>
                                            </div>
                                            </div>
                                        </div>
                                        <a href="#!" class="waves-effect waves-light btn-flat send" id="send" name="send" >
                                            Enviar
                                        </a>
                                    </div>
                                </div>
                                <br class="clear" />
                            </div>

                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <span class="chip center">
            <a class="center" href="/">Ir para o inicio</a>
            <i class="mdi-action-dashboard"></i>
        </span>

    </div>
</div>
<g:javascript src="platforms.js"/>
<g:javascript src="imgPreview.js"/>
</body>
</html>