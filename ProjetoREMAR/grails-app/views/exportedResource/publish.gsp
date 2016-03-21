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
                    <div class="collapsible-header active"> <i class="material-icons">info_outline</i>Informações básicas</div>
                    <div class="collapsible-body">
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons suffix green-text active">done</i>
                                <input value="${resourceInstance.name}" id="name" type="text" class="validate" data-resource-id="${resourceInstance.id}">
                                <label class="active" for="name" data-error="" data-success="">Nome do jogo</label>
                                <span id="name-error" class="invalid-input" style="left: 0.75rem">Já existe um jogo com esse nome!</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s2 img-preview">
                                <img id="img1Preview" class="materialboxed" width="100" height="100" src="${baseUrl}/banner.png" />
                            </div>
                            <div class="col s10">
                                <div class="file-field input-field">
                                    <div class="btn waves-effect waves-light my-orange">
                                        <span>File</span>
                                        <input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png"  >
                                    </div>
                                    <div class="file-path-wrapper">
                                        <i class="material-icons suffix green-text active">done</i>
                                        <input class="file-path validate" type="text" id="img-1-text"  placeholder="Envie um ícone para o jogo (opicional)" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </li>
                <li>
                    <div class="collapsible-header active"><i class="material-icons">view_column</i>Informações adicionais</div>
                        <div class="collapsible-body">
                            <div class="row" style="margin: 0;">
                                <div class="col s6">
                                        <p class="title">Tipo: </p>
                                        <p>
                                            <input type="radio" name="type" value="public" checked/>
                                            <label>Público</label>
                                        </p>
                                </div>
                                <div class="col s6 platforms">
                                    <p class="title">Plataformas: </p>
                                    <p>
                                        <input type="checkbox" id="web" checked="checked" disabled/>
                                        <label for="web" class="checkbox-label">Web</label>
                                        <span class="chip center">
                                            <a target="_blank" href="${baseUrl}/web">Acessar</a>
                                            <i class="fa fa-link"></i>
                                        </span>
                                    </p>
                                    <g:if test="${exportsTo.linux}">
                                        <p>
                                        <g:if test="${urls.linux}">
                                            <input type="checkbox" id="linux" checked="checked" disabled/>
                                            <label for="linux" class="checkbox-label">Linux</label>
                                            <span class="chip center">
                                                <a target="_blank" href="${baseUrl}/linux.zip">Baixar</a>
                                                <i class="fa fa-link"></i>
                                            </span>
                                        </g:if>
                                        <g:else>
                                            <input type="checkbox" id="linux" class="checkbox-platform"/>
                                            <label for="linux" class="checkbox-label" data-id="${resourceInstance.id}">Linux</label>
                                        </g:else>
                                        </p>
                                    </g:if>
                                    <g:if test="${exportsTo.android}">
                                        <p>
                                            <g:if test="${urls.android}">
                                                <input type="checkbox" id="android" checked="checked" disabled/>
                                                <label for="android" class="checkbox-label" data-position="right" data-delay="50" data-tooltip="Android">Android</label>
                                                <span class="chip center">
                                                    <a target="_blank" href="${baseUrl}/android.zip">Baixar</a>
                                                    <i class="fa fa-link"></i>
                                                </span>
                                            </g:if>
                                            <g:else>
                                                <input type="checkbox" id="android" class="checkbox-platform"/>
                                                <label for="android" class="checkbox-label" data-id="${resourceInstance.id}">Android</label>
                                            </g:else>
                                        </p>
                                    </g:if>
                                    <g:if test="${exportsTo.moodle}">
                                        <p>
                                            <g:if test="${urls.moodle}">
                                                <input type="checkbox" id="moodle" checked="checked" disabled>
                                                <label for="moodle" class="checkbox-label">Moodle</label>
                                                <span class="chip center">Jogo disponível no Moodle</span>
                                            </g:if>
                                            <g:else>
                                                <g:if test="${!moodleExport}">
                                                    <input type="checkbox" id="moodle" disabled>
                                                    <label for="moodle" class="checkbox-label">Moodle</label>
                                                    <span>Vincule sua conta ao Moodle</span>
                                                </g:if>
                                                <g:else>
                                                    <input type="checkbox" id="moodle" class="checkbox-platform">
                                                    <label for="moodle" class="checkbox-label" data-id="${resourceInstance.id}">Moodle</label>
                                                </g:else>
                                            </g:else>

                                        </p>
                                    </g:if>
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
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
</body>
</html>