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

            <ul class="collapsible popout" data-collapsible="expandable">
                <li>
                    <div class="collapsible-header active"> <i class="material-icons">feedback</i>Informações</div>
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

                            %{--<p><span class="bold">Licenciado: </span>${exportedResourceInstance.name}</p>--}%

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
                    <div id="plataforms" class="collapsible-header active" data-exported="true">
                        <i class="material-icons">view_column</i>Plataformas
                    </div>
                    <div class="collapsible-body">


                        <div id="plataforms-icons" class="row" style="margin: 0;">
                            <div class="col s12">
                                <a href="/published/${exportedResourceInstance.processId}/web" style="color: inherit" target="_blank">
                                    <div id="web" class="col s6 m2">
                                        <div class="row no-margin-bottom">
                                            <i class="fa fa-globe big-platform-logo"></i>
                                        </div>
                                        <div class="row">
                                            Web
                                        </div>
                                    </div>
                                </a>
                                <g:if test="${exportsTo.desktop}">
                                    <a href="/published/${exportedResourceInstance.processId}/desktop/${exportedResourceInstance.resource.uri}-windows.zip" style="color: inherit">
                                        <div class="col s6 m2 platform" data-text="Windows" data-name="windows">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-windows big-platform-logo"></i>
                                            </div>
                                            <div class="row">
                                                Windows
                                            </div>
                                        </div>
                                    </a>
                                    <a href="/published/${exportedResourceInstance.processId}/desktop/${exportedResourceInstance.resource.uri}-linux.zip" style="color: inherit">
                                        <div class="col s6 m2 platform" data-text="Linux (64 bits)"  data-name="linux">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-linux big-platform-logo"></i>
                                            </div>
                                            <div class="row">
                                                Linux (64 bits)
                                            </div>
                                        </div>
                                    </a>

                                    <a href="/published/${exportedResourceInstance.processId}/desktop/${exportedResourceInstance.resource.uri}-mac.zip" style="color: inherit">
                                        <div class="col s6 m2 platform" data-text="OS X" data-name="mac">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-apple big-platform-logo"></i>
                                            </div>
                                            <div class="row">
                                                OS X
                                            </div>
                                        </div>
                                    </a>
                                </g:if>

                                <g:if test="${exportsTo.android}">
                                    <a href="/published/${exportedResourceInstance.processId}/mobile/${exportedResourceInstance.resource.uri}-android.zip" style="color: inherit">
                                        <div class="col s6 m2 platform" data-text="Android" data-name="android">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-android big-platform-logo"></i>
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
                    <div class="collapsible-header active"><i class="material-icons">people</i>Compartilhar para grupos </div>
    
                        <div class="collapsible-body">
                            <ul class="collection with-header">
                                <g:each var="group" in="${groupsIOwn}">
                                    <li class="collection-item">
                                        <div class="left-align">
                                            <p>${group.name}</p>
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

                                <g:if test="${!groupsIAdmin.empty}">
                                    <li class="collection-header"><h5>Grupos que administro</h5></li>
                                </g:if>
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
                            %{--<input type="hidden" name="exportedresource" value="${instance.id}">--}%
                                <div class="row">
                                    <g:if test="${groupsIAdmin.empty && groupsIOwn.empty}">
                                        <li class="collection-item"><h5>Nenhum grupo disponível</h5></li>
                                    </g:if>
                                    <g:else>
                                        <button data-instance-id="${exportedResourceInstance.id}" style="left:2.8em; top: 0.8em; position:relative;" class="btn waves-effect waves-light my-orange" type="submit" name="action">Compartilhar</button>
                                    </g:else>
                                </div>
                            </ul>
                        </div>
                    </li>
                    </g:if>
                <li id="reportAbuse">
                    <div class="collapsible-header"><i class="material-icons">block</i>Reportar abuso</div>
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
                                    <div class="g-recaptcha text-center" data-sitekey="6LdA8QkTAAAAANzRpkGUT__a9B2zHlU5Mnl6EDoJ"> </div>
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
<g:javascript src="add-resource-to-group.js"/>
<g:javascript src="licenseShow.js"/>
<recaptcha:script/>
</body>
</html>
