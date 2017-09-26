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
            <i class="small material-icons left">games</i>${exportedResourceInstance.name}
        </p>
        <div class="divider"></div>
    </div>
    <div class="row show">
        <div class="row">
            <input type="hidden" name="id" id="resource-id" value="${resourceInstance.id}">

            <ul data-instance_id="${exportedResourceInstance.id}" class="collapsible popout infos-exportedResource" data-collapsible="expandable">
                <li>
                    <div class="collapsible-header active">Informações</div>
                    <div id="info" class="collapsible-body">
                        <div class="row">
                            <img id="img1Preview" class="my-orange right materialboxed" width="100" height="100"
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
                            <input type="hidden" id="licenseValue" value="${exportedResourceInstance.license}">
                            <br>
                            <div id="licenseInfo"></div>
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
                    <div id="plataforms" class="collapsible-header active" data-exported="true">Plataformas</div>
                    <div class="collapsible-body">
                        <div class="row" style="margin-top: 30px">
                            <div id="plataforms-icons" class="col s12" style="display:flex; justify-content: space-around">

                                <a href="/published/${exportedResourceInstance.processId}/web" style="color: inherit" target="_blank">
                                    <div id="web" class="platform-icon">
                                        <div class="row no-margin-bottom">
                                            <i class="fa fa-globe big-platform-logo" data-tooltip="Web"></i>
                                        </div>
                                        <div class="row">
                                            Web
                                        </div>
                                    </div>
                                </a>

                                <g:if test="${exportsTo.desktop}">
                                    <a href="/published/${exportedResourceInstance.processId}/desktop/${exportedResourceInstance.resource.uri}-windows.zip" style="color: inherit">
                                        <div class="platform-icon" data-text="Windows" data-name="windows">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-windows big-platform-logo" data-tooltip="Windows"></i>
                                            </div>
                                            <div class="row">
                                                Windows
                                            </div>
                                        </div>
                                    </a>
                                    <a href="/published/${exportedResourceInstance.processId}/desktop/${exportedResourceInstance.resource.uri}-linux.zip" style="color: inherit">
                                        <div class="platform-icon" data-text="Linux (64 bits)"  data-name="linux">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-linux big-platform-logo" data-tooltip="Linux"></i>
                                            </div>
                                            <div class="row">
                                                Linux (64 bits)
                                            </div>
                                        </div>
                                    </a>

                                    <a href="/published/${exportedResourceInstance.processId}/desktop/${exportedResourceInstance.resource.uri}-mac.zip" style="color: inherit">
                                        <div class="platform-icon" data-text="macOS" data-name="mac">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-apple big-platform-logo" data-tooltip="Mac"></i>
                                            </div>
                                            <div class="row">
                                                macOS
                                            </div>
                                        </div>
                                    </a>
                                </g:if>

                                <g:if test="${exportsTo.android}">
                                    <a href="/published/${exportedResourceInstance.processId}/mobile/${exportedResourceInstance.resource.uri}-android.zip" style="color: inherit">
                                        <div class="platform-icon" data-text="Android" data-name="android">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-android big-platform-logo" data-tooltip="Android"></i>
                                            </div>
                                            <div class="row">
                                                Android
                                            </div>
                                        </div>
                                    </a>
                                </g:if>

                            </div>
                        </div>
                    </div>
                </li>

                <g:if test="${exportedResourceInstance.resource.shareable}">
                    <li id="groups">
                        <div class="collapsible-header active">Compartilhar para grupos </div>
                        <div class="collapsible-body">
                            <ul class="collection with-header">
                                <div id="share-container" class="col l12" style="max-height: 300px !important">
                                </div>
                            </ul>
                        </div>
                    </li>
                </g:if>

                <li id="reportAbuse">
                    <div class="collapsible-header">Reportar abuso</div>
                    <div class="collapsible-body"><p>Se este conteúdo te incomodou de alguma forma, ou se você o achou ofensivo, por favor entre em contato
                    com a equipe REMAR. Utilize o campo texto abaixo para descrever o que lhe incomodou e como podemos lhe ajudar.</p>

                        <g:form action="reportAbuse">
                            <input type="hidden" name="exportedResourceId" value="${exportedResourceInstance.id}">
                            <div class="row">
                                <div class="input-field col s12 m12 l12">
                                    <textarea id="message" name="text" class="materialize-textarea"></textarea>
                                    <label for="message">Mensagem</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s6 m7 offset-m3 l7 offset-l3">
                                    <div class="g-recaptcha text-center" data-sitekey="6Le6wh8UAAAAAP9Gs9OkQEWIZZBcQJDHWht_zYpG"> </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s3 offset-s7 m3 offset-m9 l3 offset-l9">
                                    <input id="submit" type="submit" class="btn btn-large my-orange" value="Enviar">
                                </div>
                            </div>
                        </g:form>
                    </div>
                </li>
            </ul>
        </div>
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
<link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
<g:javascript src="remar/group/add-resource-to-group.js"/>
<g:javascript src="remar/info-share.js"/>
<g:javascript src="remar/licenseShow.js"/>
<recaptcha:script/>
</body>
</html>