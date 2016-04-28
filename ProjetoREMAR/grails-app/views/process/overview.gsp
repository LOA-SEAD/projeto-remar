<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    td a {
        display: block;
        width: 100%;
    }
    </style>

    <meta name="layout" content="materialize-layout">
    <title>Customizando Jogo</title>

</head>

<body>
<div class="row cluster">
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">list</i>Etapas de customização
        </p>

        <div class="divider"></div>
    </div>

    <div class="row show">
        <article class="row">
            <g:if test="${params.toast}">
                <script>
                    Materialize.toast('Tarefa realizada com sucesso!', 3000, 'rounded');
                </script>
            </g:if>
            <div class="subtitle space">
                <h3 class="text-teal text-darken-3 center truncate">
                    ${process.definition.name}
                </h3>
                <h5 class="center date">
                    <i class="fa fa-clock-o"></i> Iniciado em <g:formatDate format="dd/MM/yy HH:mm"
                                                                              date="${process.createdAt}"/>
                </h5>
            </div>

            <div class="row space">
                <blockquote>
                    Abaixo estão listadas as tarefas que devem ser cumpridas para concluir a customização do seu jogo!
                </blockquote>
            </div>

            <ul class="collapsible popout" data-collapsible="expandable">
                <!-- 1 Etapa - informações básicas -->
                <li>
                    <div class="collapsible-header active"> <i class="material-icons">info_outline</i>Informações básicas</div>
                    <div class="collapsible-body">
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons suffix green-text active">done</i>
                                <input value="${process.definition.name}" id="name" type="text" class="validate" data-process-id="${process.id}">
                                <label class="active" for="name" data-error="" data-success="">Nome do jogo</label>
                                <span id="name-error" class="invalid-input" style="left: 0.75rem">Já existe um jogo com esse nome!</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s2 img-preview">
                                <img id="img1Preview" class="materialboxed my-orange" width="100" height="100" src="/processes/${process.id}/banner.png" />
                            </div>
                            <div class="col s10">
                                <div class="file-field input-field">
                                    %{--<input type="hidden" name="photo" value="${baseUrl}/banner.png" id="srcImage">--}%
                                    <div class="btn waves-effect waves-light my-orange">
                                        <span>Arquivo</span>
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
                <!-- Fim 1 Etapa - informações básicas -->
                <!-- 2 Etapa - tarefas -->
                <li>
                    <div id="tasks-header" class="collapsible-header">
                        <i class="material-icons">done_all</i>Tarefas
                    </div>
                    <div class="collapsible-body">
                        <main id="tasks">
                            <table class="responsive-table bordered highlight centered">
                                <thead>
                                <tr>
                                    <th data-field="id">Nome</th>
                                    <th data-field="name">Ação</th>
                                    <th data-field="status">Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${process.pendingTasks}" var="task">
                                    <tr class="pending">
                                        <td>
                                            <span class="">
                                                ${task.definition.name}
                                            </span>
                                        </td>
                                        <td><a href="/frame/${process.definition.uri}/${task.definition.uri}?t=${task.id}">REALIZAR</a>
                                        </td>

                                        <td>Pendente</td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </main>
                    </div>
                </li>
                <!-- Fim 2 Etapa - tarefas -->
                <!-- 3 Etapa - plataformas -->
                <li>
                    <div class="collapsible-header">
                        <i class="material-icons">view_column</i>Plataformas
                    </div>
                    <div class="collapsible-body">
                        <main id="plataforms">
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
                            %{--<div id="plataforms-icons" class="row" style="margin: 0;">--}%
                            %{--<div class="col s12">--}%
                            %{--<a style="color: inherit" target="_blank">--}%
                            %{--<div id="web" class="col s6 m2">--}%
                            %{--<div class="row no-margin-bottom">--}%
                            %{--<i class="fa fa-globe big-platform-logo"></i>--}%
                            %{--</div>--}%
                            %{--<div class="row">--}%
                            %{--Web--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</a>--}%
                            %{--<g:if test="${exportsTo.desktop}">--}%
                            %{--<a style="color: inherit">--}%
                            %{--<div class="col s6 m2 platform" data-text="Windows" data-name="windows">--}%
                            %{--<div class="row no-margin-bottom">--}%
                            %{--<i class="fa fa-windows big-platform-logo"></i>--}%
                            %{--</div>--}%
                            %{--<div class="row">--}%
                            %{--Windows--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</a>--}%
                            %{--<a style="color: inherit">--}%
                            %{--<div class="col s6 m2 platform" data-text="Linux (64 bits)"  data-name="linux">--}%
                            %{--<div class="row no-margin-bottom">--}%
                            %{--<i class="fa fa-linux big-platform-logo"></i>--}%
                            %{--</div>--}%
                            %{--<div class="row">--}%
                            %{--Linux (64 bits)--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</a>--}%

                            %{--<a style="color: inherit">--}%
                            %{--<div class="col s6 m2 platform" data-text="OS X" data-name="mac">--}%
                            %{--<div class="row no-margin-bottom">--}%
                            %{--<i class="fa fa-apple big-platform-logo"></i>--}%
                            %{--</div>--}%
                            %{--<div class="row">--}%
                            %{--OS X--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</a>--}%
                            %{--</g:if>--}%

                            %{--<g:if test="${exportsTo.android}">--}%
                            %{--<a style="color: inherit">--}%
                            %{--<div class="col s6 m2 platform" data-text="Android" data-name="android">--}%
                            %{--<div class="row no-margin-bottom">--}%
                            %{--<i class="fa fa-android big-platform-logo"></i>--}%
                            %{--</div>--}%
                            %{--<div class="row">--}%
                            %{--Android--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</a>--}%
                            %{--</g:if>--}%

                            %{--<g:if test="${exportsTo.moodle}">--}%
                            %{--<div id="moodle" class="col s6 m2">--}%
                            %{--<div class="row no-margin-bottom">--}%
                            %{--<i class="fa fa-graduation-cap big-platform-logo"></i>--}%
                            %{--</div>--}%
                            %{--<div class="row">--}%
                            %{--Moodle--}%
                            %{--</div>--}%
                            %{--</div>--}%
                            %{--</g:if>--}%
                            %{--</div>--}%
                            %{--</div>--}%
                        </main>
                    </div>
                </li>
                <!-- Fim 3 Etapa - plataformas -->
            </ul>
        </article>
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
<g:javascript src="menu.js"/>
<g:javascript src="platforms.js"/>
<g:javascript src="imgPreview.js"/>
<g:javascript src="jquery/jquery.Jcrop.js"/>
<script>
    $(document).ready(function () {
        $('.collapsible').collapsible({
            accordion: false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
        });
        $('.tooltipped').tooltip({delay: 50});
    });
</script>
</body>
</html>
