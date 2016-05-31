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
            <i class="small material-icons left">games</i>${exportedResourceInstance.name}
        </p>
        <div class="divider"></div>
    </div>
    <div class="row space">
        <g:if test="${params.toast}">
            <blockquote>
                O seu jogo foi publicado com <span class="bold">sucesso</span>! Agora ele já esta disponível no menu
                <span class="chip">
                    <a class="center" href="/exported-resource/publicGames">Jogos publicados</a>
                    <i class="medium material-icons">videogame_asset</i>
                </span>
            </blockquote>
        </g:if>
    </div>
    <div class="row show">
        <div class="row">
            <input type="hidden" name="id" id="resource-id" value="${resourceInstance.id}">

            <ul class="collapsible popout" data-collapsible="expandable">
                <li>
                    <div class="collapsible-header active"> <i class="material-icons">feedback</i>Informações</div>
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

                            %{--<p><span class="bold">Licenciado: </span>${exportedResourceInstance.name}</p>--}%

                        </div>
                        <div class="clearfix"></div>
                    </div>
                </li>
                <li>
                    <div id="plataforms" class="collapsible-header active" data-exported="true">
                        <i class="material-icons">view_column</i>Plataformas
                    </div>
                    <div class="collapsible-body">

                        <aside class="plataforms-progress center">
                            <div class="center">
                                <p>Gerando o jogo para diferentes plataformas... </p>
                            </div>
                            <div class="preloader-wrapper big active">
                                <div class="spinner-layer spinner-blue">
                                    <div class="circle-clipper left">
                                        <div class="circle"></div>
                                    </div><div class="gap-patch">
                                    <div class="circle"></div>
                                </div><div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                                </div>

                                <div class="spinner-layer spinner-red">
                                    <div class="circle-clipper left">
                                        <div class="circle"></div>
                                    </div><div class="gap-patch">
                                    <div class="circle"></div>
                                </div><div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                                </div>

                                <div class="spinner-layer spinner-yellow">
                                    <div class="circle-clipper left">
                                        <div class="circle"></div>
                                    </div><div class="gap-patch">
                                    <div class="circle"></div>
                                </div><div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                                </div>

                                <div class="spinner-layer spinner-green">
                                    <div class="circle-clipper left">
                                        <div class="circle"></div>
                                    </div><div class="gap-patch">
                                    <div class="circle"></div>
                                </div><div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                                </div>
                            </div>
                        </aside>

                        <div id="plataforms-icons" class="row" style="margin: 0;">
                            <div class="col s12">
                                <a style="color: inherit" target="_blank">
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
                                    <a style="color: inherit">
                                        <div class="col s6 m2 platform" data-text="Windows" data-name="windows">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-windows big-platform-logo"></i>
                                            </div>
                                            <div class="row">
                                                Windows
                                            </div>
                                        </div>
                                    </a>
                                    <a style="color: inherit">
                                        <div class="col s6 m2 platform" data-text="Linux (64 bits)"  data-name="linux">
                                            <div class="row no-margin-bottom">
                                                <i class="fa fa-linux big-platform-logo"></i>
                                            </div>
                                            <div class="row">
                                                Linux (64 bits)
                                            </div>
                                        </div>
                                    </a>

                                    <a style="color: inherit">
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
                                    <a style="color: inherit">
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

                                <g:if test="${exportsTo.moodle}">
                                    <div id="moodle" class="col s6 m2">
                                        <div class="row no-margin-bottom">
                                            <i class="fa fa-graduation-cap big-platform-logo"></i>
                                        </div>
                                        <div class="row">
                                            Moodle
                                        </div>
                                    </div>
                                </g:if>
                            </div>
                        </div>
                    </div>
                </li>
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
<g:javascript src="exported-plataforms.js"/>
<g:javascript src="licenseShow.js"/>
<g:javascript src="imgPreview.js"/>
<g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>
