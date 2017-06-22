<%@ page import="br.ufscar.sead.loa.remar.GroupExportedResources" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title></title>
</head>
<body>
<div class="row cluster">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
           ${exportedResourceInstance.name}
        </p>
        <div class="divider"></div>
    </div>
    <div class="row space">
        <g:if test="${params.toast}">
            <p>
                O seu jogo foi publicado com <span class="bold">sucesso</span>! Agora ele já esta disponível no menu
                <span class="chip">
                    <a class="center" href="/exported-resource/publicGames">Banco de jogos</a>
                    <i class="medium material-icons">videogame_asset</i>
                </span>
            </p>
        </g:if>
    </div>
    <div class="row show">
        <div class="row">
            <input type="hidden" name="id" id="resource-id" value="${resourceInstance.id}">

            <ul class="collapsible popout" data-collapsible="expandable">
                <li>
                    <div class="collapsible-header active">Informações</div>
                    <div id="info" class="collapsible-body">
                        <div class="row">
                            <img id="img1Preview" class="my-orange right" width="100" height="100"
                                 src="/published/${exportedResourceInstance.processId}/banner.png" />
                            <p><span class="bold">Nome do jogo: </span>${exportedResourceInstance.name}</p>
                            <p><span class="bold">Categoria: </span>${exportedResourceInstance.resource.category.name}</p>
                            <p><span class="bold">Autor: </span>${exportedResourceInstance.owner.username}</p>
                            <p><span class="bold">Customizado em:</span>
                                <g:formatDate format="dd/MM/yyyy HH:mm"
                                              date="${createdAt}"/></p>
                            <p><span class="bold">Baseado no modelo: </span>${exportedResourceInstance.resource.name}</p>
                            <p><span class="bold">Área de conteúdo: </span>${exportedResourceInstance.contentArea}</p>
                            <p><span class="bold">Conteúdo específico: </span>${exportedResourceInstance.specificContent}</p>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </li>
                <g:if test="${!handle.isEmpty()}">
                    <li>
                        <div class="collapsible-header active"> <i class="material-icons">cloud</i>Repositório</div>
                        <div class="collapsible-body">
                            <div class="row">
                                <blockquote>Abaixo estão os artefatos customizados enviados para o repositório digital.</blockquote>
                                <g:each in="${handle}" var="h">
                                    <p><span class="bold">${h.key}: </span>
                                        <a href="${h.value}" target="_blank">${h.value}</a>
                                    </p>
                                </g:each>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </li>
                </g:if>
                <li>
                    <div id="platforms" class="collapsible-header active" data-exported="true">
                        Plataformas
                    </div>
                    <div class="collapsible-body">
                        <div id="platforms-icons" class="row" style="margin: 0;">
                            <div class="col s12">
                                <div id="web" class="platform-icon">
                                    <a style="color: inherit" target="_blank">
                                        <div class="col s6 m2 platform" data-text="Web" data-name="web">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-globe big-platform-logo"></i>
                                            </div>
                                            <div class="platform-title row">
                                                Web
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <g:if test="${exportsTo.desktop}">
                                    <div id="windows" class="platform-icon">
                                        <a style="color: inherit">
                                            <div class="col s6 m2 platform" data-text="Windows" data-name="windows">
                                                <div class="row no-margin-bottom">
                                                    <i class="fa fa-windows big-platform-logo"></i>
                                                </div>
                                                <div class="platform-title row">
                                                    Windows
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div id="linux" class="platform-icon">
                                        <a style="color: inherit">
                                            <div class="col s6 m2 platform" data-text="Linux (64 bits)"  data-name="linux">
                                                <div class="row no-margin-bottom">
                                                    <i class="fa fa-linux big-platform-logo"></i>
                                                </div>
                                                <div class="platform-title row">
                                                    Linux (64 bits)
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                    <div id="mac" class="platform-icon">
                                        <a style="color: inherit">
                                            <div class="col s6 m2 platform" data-text="MacOS" data-name="mac">
                                                <div class="row no-margin-bottom">
                                                    <i class="fa fa-apple big-platform-logo"></i>
                                                </div>
                                                <div class="platform-title row">
                                                    macOS
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </g:if>
                                <g:if test="${exportsTo.android}">
                                    <div id="android" class="platform-icon">
                                        <a style="color: inherit">
                                            <div class="col s6 m2 platform" data-text="Android" data-name="android">
                                                <div class="row no-margin-bottom">
                                                    <i class="fa fa-android big-platform-logo"></i>
                                                </div>
                                                <div class="platform-title row">
                                                    Android
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </g:if>
                                <g:if test="${exportsTo.moodle}">
                                    <div id="moodle" class="platform-icon col s6 m2">
                                        <div class="row no-margin-bottom">
                                            <i class="fa fa-graduation-cap big-platform-logo"></i>
                                        </div>
                                        <div class="platform-title row">
                                            Moodle
                                        </div>
                                    </div>
                                </g:if>
                            </div>
                        </div>
                        <div id="progress-viewer">
                            <div class="progress">
                                <div class="determinate" style="width: 1%">
                                    <div id="inner-bar" class="progress">
                                        <div class="indeterminate"></div>
                                    </div>
                                </div>
                                <div id="progress-percentage">
                                    <!-- Dynamically modified in javascript -->
                                </div>
                            </div>
                            <div id="progress-text">
                                <!-- Dynamically modified in javascript -->
                            </div>
                        </div>
                    </div>
                </li>
                <g:if test="${exportedResourceInstance.resource.shareable}">
                    <li id="groups">
                       <div class="collapsible-header active"><i class="material-icons">people</i>Compartilhar para grupos </div>
                       <div class="collapsible-body">
                          <ul class="collection with-header">
                             %{--<g:if test="${!groupsIOwn.isEmpty()}">--}%
                            %{--<g:each var="group" in="${groupsIOwn}">--}%
                                %{--<li class="collection-item">--}%
                            <div class="col l12">
                                    <a href="#modal-group-${exportedResourceInstance.id}" class="tooltipped modal-trigger" data-position="down" data-delay="50" data-tooltip="Compartilhar para grupos">
                                       Compartilhar para grupo(s)
                                    </a>
                            </div>
                </g:if>
                <g:else>
                    <div class="col l4">
                        <div style="font-size: 2em;" class="tooltipped" data-position="down" data-delay="50" data-tooltip="Sem compartilharmento para grupos">
                            <i class="fa fa-users" style="color: #DCDCDC;"></i>
                        </div>
                    </div>
                </g:else>
                        </ul>
            </div>
                    </li>

                <div id="modal-group-${exportedResourceInstance.id}" class="modal col l6 offset-l3 s6">
                    <div class="modal-content">
                        <ul class="collection with-header">
                            <g:if test="${!groupsIOwn.empty}">
                                <g:each var="group" in="${groupsIOwn}">
                                    <li class="collection-item">
                                        <div>
                                            <p>${group.name}</p>
                                            <p>
                                                Dono: ${group.owner.firstName + " " + group.owner.lastName}<br>
                                            </p>
                                        </div>
                                        <g:if test="${!GroupExportedResources.findByGroupAndExportedResource(group,instance)}">
                                            <input name="groupsid" class="filled-in" id="groups-${group.id}-instance-${exportedResourceInstance.id}" value="${group.id}" type="checkbox">
                                        </g:if>
                                        <g:else>
                                            <input name="groupsid2"  checked="checked" disabled="disabled" type="checkbox">
                                        </g:else>
                                        <label style="position:relative; bottom: 2em;" for="groups-${group.id}-instance-${exportedResourceInstance.id}" class="secondary-content"></label>
                                    </li>
                                </g:each>
                            </g:if>
                            <g:if test="${!groupsIAdmin.empty}">
                                <g:each var="group" in="${groupsIAdmin}">
                                    <li class="collection-item">
                                        <div>
                                            <p>${group.name}</p>
                                            <p>
                                                Dono: ${group.owner.firstName + " " + group.owner.lastName}<br>
                                            </p>
                                        </div>
                                        <g:if test="${!GroupExportedResources.findByGroupAndExportedResource(group,instance)}">
                                            <input name="groupsid" class="filled-in" id="groups-${group.id}-instance-${exportedResourceInstance.id}" value="${group.id}" type="checkbox">
                                        </g:if>
                                        <g:else>
                                            <input name="groupsid2"  checked="checked" disabled="disabled" type="checkbox">
                                        </g:else>
                                        <label style="position:relative; bottom: 2em;" for="groups-${group.id}-instance-${exportedResourceInstance.id}" class="secondary-content"></label>
                                    </li>
                                </g:each>
                            </g:if>
                            <g:if test="${groupsIAdmin?.empty && groupsIOwn?.empty}">
                                <li class="collection-header"><h5>Você não possui grupos disponíveis</h5></li>
                            </g:if>
                            <g:else>
                                <input type="hidden" name="exportedresource" value="${exportedResourceInstance.id}">
                                <div class="row">
                                    <button data-instance-id="${exportedResourceInstance.id}" style=" top: 0.8em; right: -2.4em; position:relative;" class="btn waves-effect waves-light" type="submit" name="action">Compartilhar
                                        <i class="material-icons right">send</i>
                                    </button>
                                </div>
                            </g:else>
                        </ul>
                    </div>
                </div>
%{--                <li id="groups">
                    <div class="collapsible-header active"><i class="material-icons">people</i>Compartilhar para grupos </div>
                    <div class="collapsible-body">
                        <ul class="collection with-header">
                        <g:if test="${!groupsIOwn.isEmpty()}">
                            <g:each var="group" in="${groupsIOwn}">
                                <li class="collection-item">
                                    <div class="left-align">
                                    <p>${group.name}</p>
                                        <p>
                                            Dono: ${group.owner.firstName + " " + group.owner.lastName}<br>
                                        </p>

                                    </div>
                                    <g:if test="${!GroupExportedResources.findByGroupAndExportedResource(group,exportedResourceInstance)}">
                                        <input name="groupsid" class="group-input" id="groups-${group.id}-instance-${exportedResourceInstance.id}" value="${group.id}" type="checkbox">
                                    </g:if>
                                    <g:else>
                                        <input name="groupsid2" id="groups-${group.id}-instance-${exportedResourceInstance.id}" checked="checked" disabled="disabled" type="checkbox">
                                    </g:else>
                                    <label style="position:relative; bottom: 2em;" for="groups-${group.id}-instance-${exportedResourceInstance.id}" class="secondary-content"></label>
                                </li>
                            </g:each>
                        </g:if>
                        <g:if test="${!groupsIAdmin.isEmpty()}">
                            <g:each var="group" in="${groupsIAdmin}">
                                <li class="collection-item">
                                    <div>
                                        <p>${group.name}</p>
                                        <p>
                                            Dono: ${group.owner.firstName + " " + group.owner.lastName}<br>
                                        </p>
                                    </div>
                                    <g:if test="${!GroupExportedResources.findByGroupAndExportedResource(group,exportedResourceInstance)}">
                                            <input name="groupsid" id="groups-${group.id}-instance-${exportedResourceInstance.id}" value="${group.id}" type="checkbox">
                                    </g:if>
                                    <g:else>
                                        <input name="groupsid2"  checked="checked" disabled="disabled" type="checkbox">
                                    </g:else>
                                    <label style="position:relative; bottom: 2em;" for="groups-${group.id}-instance-${exportedResourceInstance.id}" class="secondary-content"></label>
                                    </li>
                            </g:each>
                        </g:if>
                        <g:if test="${groupsIAdmin.isEmpty() && groupsIAdmin.isEmpty()}">
                            <li class="collection-header"><h5>Você não possui grupos disponíveis</h5></li>
                        </g:if>
                        <g:else>
                            <div class="row">
                                <button data-instance-id="${exportedResourceInstance.id}" style="left:2.8em; top: 0.8em; position:relative;" class="btn waves-effect waves-light my-orange" type="submit" name="action">Compartilhar</button>
                            </div>
                        </g:else>
                        </ul>
                    </div>
                </li>--}%
                %{--</g:if>--}%
            </ul>
        </div>
    </li>
    </ul>
    </div>
</div>
</div>
<div id="modal-picture" class="modal">
    <div class="modal-content center">
        <img id="crop-preview" class="responsive-img">
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close waves-effect btn-flat">Enviar</a>
    </div>
</div>
<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "jquery.Jcrop.css")}"/>
<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "export.css")}"/>
<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
<g:javascript src="exported-platforms.js"/>
<g:javascript src="add-resource-to-group.js"/>
<g:javascript src="licenseShow.js"/>
<g:javascript src="imgPreview.js"/>
<g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>