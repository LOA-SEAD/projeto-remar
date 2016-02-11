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
    <g:javascript src="platforms.js" />
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
        <article class="row">

        %{--<h5 class="center"> Jogos em customização</h5>--}%
            <ul class="collapsible popout" data-collapsible="expandable">
                <li>
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    <div class="collapsible-header active"> <i class="material-icons">info_outline</i>Informações básicas</div>
                    <div class="collapsible-body">
                        <div class="row">
                            <div class="input-field col s6">
                                <input value="${resourceName}" id="name" type="text" class="validate" data-resource-id="${resourceId}">
                                <label class="active" for="name">Nome do jogo</label>
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
                                <img id="img1Preview" class="materialboxed" width="100" height="100" src="/images/${resourceUri}-banner.png" />
                            </div>
                            <div class="col s10">
                                <div class="file-field input-field">
                                    <div class="btn waves-effect waves-light my-orange">
                                        <span>File</span>
                                        <input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png"  src="/images/${resourceUri}-banner.png" >
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text" id="img-1-text" value="${resourceUri}-banner.png" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </li>
                <li>
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    <div class="collapsible-header active"><i class="material-icons">list</i>Tarefas </div>
                    <div class="collapsible-body">
                        <div class="row">
                            <div class="col s6">
                                    <p class="title">Tipo: </p>
                                    <div class="divider"></div>

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
                            <div class="col s6">
                                <p class="title">Plataformas: </p>
                                <div class="divider"></div>

                                <g:set var="link" value="null" scope="page" />

                                <g:each in="${platforms}" var="platform">
                                    <g:if test="${platform.contains(':')}">
                                        <p>
                                            <input type="checkbox" id="web" checked="checked" />
                                            <label for="web" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Web">
                                                <i class="fa fa-globe" ></i>
                                                %{--<a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>--}%
                                                <g:set var="link" value="${platform.substring(platform.indexOf(':') + 1)}" scope="page" />
                                            </label>
                                        </p>
                                        %{--<input type="checkbox" checked disabled readonly/>--}%
                                        %{--<b> ${platform.substring(0, platform.indexOf(':'))}:--}%
                                          %{--</b>--}%
                                    </g:if>
                                    <g:else>
                                        <g:if test="${platform.toLowerCase() != 'web'}">
                                            <p>
                                                <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform" disabled readonly/>
                                                <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Android">
                                                    <i class="fa fa-android"></i>
                                                    %{--<a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>--}%
                                                </label>
                                            </p>
                                            %{--<label for="${platform.toLowerCase()}" data-resource-id="${resourceId}">${platform}</label>--}%
                                            %{--<span class="label label-warning">Em breve</span>--}%
                                        </g:if>
                                        <g:else>
                                            %{--<p>--}%
                                                %{--<input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform"/>--}%
                                                %{--<label for="${platform.toLowerCase()}" data-resource-id="${resourceId}" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Android">--}%
                                                    %{--<i class="fa fa-android"></i>--}%
                                                    %{--<a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>--}%
                                                %{--</label>--}%
                                            %{--</p>--}%
                                        </g:else>
                                    </g:else>
                                    <br>
                                </g:each>
                                <p>
                                    <input type="checkbox" name="windows" id="windows" class="checkbox-platform" disabled readonly/>
                                    <label for="windows"  class="tooltipped" data-position="right" data-delay="50" data-tooltip="Windows">
                                        <i class="fa fa-windows"></i>
                                        %{--<a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a>--}%
                                    </label>
                                </p>
                                %{--<p>--}%
                                    %{--<input type="checkbox" id="linux"/>--}%
                                    %{--<label for="linux" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Linux"><i class="fa fa-linux"></i></label>--}%
                                %{--</p>--}%
                                %{--<p>--}%
                                    %{--<input type="checkbox" id="moodle"/>--}%
                                    %{--<label  for="moodle" class="tooltipped" data-position="right" data-delay="50" data-tooltip="Moodle"><i class="fa fa-graduation-cap"></i></label>--}%
                                %{--</p>--}%
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12" >
                                %{--<div id="preloader-wrapper" class="preloader-wrapper small active right">--}%
                                    %{--<div class="spinner-layer spinner-red-only">--}%
                                        %{--<div class="circle-clipper left">--}%
                                            %{--<div class="circle"></div>--}%
                                        %{--</div><div class="gap-patch">--}%
                                        %{--<div class="circle"></div>--}%
                                    %{--</div><div class="circle-clipper right">--}%
                                        %{--<div class="circle"></div>--}%
                                    %{--</div>--}%
                                    %{--</div>--}%
                                %{--</div>--}%
                                <div class="send-war right">
                                    %{--<g:if test="${link != null}" >--}%
                                        <a href="#!" class="waves-effect waves-light btn-flat send" id="send" name="send" >
                                            Finalizar
                                        </a>
                                    %{--</g:if>--}%
                                    %{--<g:submitButton id="send" name="send" class="waves-effect waves-light btn-flat send" value="Finalizar" />--}%
                                </div>
                            </div>
                            <br class="clear" />
                        </div>
                    </div>
                </li>
            </ul>
        </article>
    </div>
</div>
<g:javascript src="imgPreview.js"/>
<g:javascript src="platforms.js"/>
%{--<script>--}%
    %{--$(document).ready(function(){--}%
        %{--$('.collapsible').collapsible({--}%
            %{--accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style--}%
        %{--});--}%
        %{--$('.tooltipped').tooltip({delay: 50});--}%
    %{--});--}%
%{--</script>--}%

<!--
<div class="content">
    <div class="row">
        <article class="row">
            <div class="col-md-12" align="center">
                <div class="box box-body box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            <i class="fa fa-info-circle"></i>
                            Dados do recurso
                        </h3>
                    </div>
                    <div class="box-body">
                        <div class="direct-chat-messages page-size" style="width: 30%;" >

                           <p>Nome: </p>
                           <input type="text" placeholder="${resourceName}" class="form-control-remar"/>
                            <fieldset>
                                <legend>Tipo</legend>
                                <div class="form-group">
                                    <input type="radio" name="type" value="public" checked/>
                                    <label>Público</label>
                                </div>
                                <div class="form-group">
                                    <input type="radio" name="type" value="private" disabled readonly/>
                                    <label>Privado</label>
                                    <span class="label label-warning">Em breve</span>
                                </div>
                                <div class="form-group">
                                    <input type="radio" name="type" value="group" disabled readonly />
                                    <label>Grupo</label>
                                    <select disabled>
                                        <option>Turma 1</option>
                                    </select>
                                </div>

                            </fieldset>
                            <fieldset>
                                <legend>Plataformas</legend>

                                    <g:each in="${platforms}" var="platform">
                                        <g:if test="${platform.contains(':')}">
                                            <input type="checkbox" checked disabled readonly/>
                                            <b> ${platform.substring(0, platform.indexOf(':'))}:
                                                <a target="_blank" href="${platform.substring(platform.indexOf(':') + 1)}"> Acessar </a> </b>
                                        </g:if>
                                        <g:else>
                                            <g:if test="${platform.toLowerCase() != 'web'}">
                                                <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform" disabled readonly/>
                                                <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}">${platform}</label>
                                                <span class="label label-warning">Em breve</span>
                                            </g:if>
                                            <g:else>
                                                <input type="checkbox" name="${platform.toLowerCase()}" id="${platform.toLowerCase()}" class="checkbox-platform"/>
                                                <label for="${platform.toLowerCase()}" data-resource-id="${resourceId}">${platform}</label>
                                            </g:else>
                                        </g:else>
                                        <br>
                                    </g:each>
                                    <input type="checkbox" name="windows" id="windows" class="checkbox-platform" disabled readonly/>
                                    <label for="windows">Windows <span class="label label-warning">Em breve</span></label>

                            </fieldset>
                            <g:submitButton id="send" name="send" class="btn btn-success" value="Enviar" />

                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
</div>

-->
</body>
</html>