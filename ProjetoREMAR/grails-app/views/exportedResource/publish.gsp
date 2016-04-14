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
                                <img id="img1Preview" class="materialboxed my-orange" width="100" height="100" src="${baseUrl}/banner.png" />
                            </div>
                            <div class="col s10">
                                <div class="file-field input-field">
                                    %{--<input type="hidden" name="photo" value="${baseUrl}/banner.png" id="srcImage">--}%
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
                        <div class="right">
                            <a href="#!" class="waves-effect waves-light btn-flat send" id="send" name="send" >
                                salvar
                            </a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </li>
                <li>
                    <div class="collapsible-header active">
                        <i class="material-icons">view_column</i>Plataformas
                    </div>
                    <div class="collapsible-body">
                       <aside class="plataforms-progress">
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

                        <div id="plataforms" class="row" style="margin: 0;">
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
        <span class="chip center">
            <a class="center" href="/">Ir para o inicio</a>
            <i class="mdi-action-dashboard"></i>
        </span>
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
<g:javascript src="platforms.js"/>
<g:javascript src="imgPreview.js"/>
<g:javascript src="jquery/jquery.Jcrop.js"/>
</body>
</html>