<%@ page import="br.ufscar.sead.loa.propeller.domain.ProcessInstance" contentType="text/html;charset=UTF-8" %>
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
        <p id="start" class="text-teal text-darken-3 left-align margin-bottom">
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
                    Abaixo estão as etapas para customizar o seu jogo!
                </blockquote>
            </div>

            <ul class="collapsible popout" data-collapsible="expandable">
                <!-- 1 Etapa - informações básicas -->
                <li>
                    <div class="collapsible-header active"> <i class="material-icons">feedback</i>Informações básicas</div>
                        <div id="info" class="collapsible-body"
                             data-basic-info="${process.getVariable("updated")}">
                            ${process.putVariable("updated","false",true)}
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons suffix green-text active">done</i>
                                    <input value="${process.name}" id="name" type="text"
                                           class="validate" data-resource-id="${process.getVariable("resourceId")}" data-process-id="${process.id}">
                                    <label class="active" for="name" data-error="" data-success="">Nome do jogo</label>
                                    <span id="name-error" class="invalid-input" style="left: 0.75rem">Já existe um jogo com esse nome!</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s2 img-preview">
                                    <img id="img1Preview" class="materialboxed my-orange" width="100" height="100" src="/data/processes/${process.id}/banner.png?${new java.util.Date()}" />
                                </div>
                                <div class="col s10">
                                    <div class="file-field input-field">
                                        %{--<input type="hidden" name="photo" value="${baseUrl}/banner.png" id="srcImage">--}%
                                        <div id="file" class="btn waves-effect waves-light my-orange">
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
                                    Enviar
                                </a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                </li>
                <!-- Fim 1 Etapa - informações básicas -->
                <!-- 2 Etapa - tarefas -->
                <li>
                    <g:if test="${process.getVariable("showTasks")}">
                        <div id="tasks-header" class="collapsible-header active">
                            <i class="material-icons">linear_scale</i>Tarefas
                        </div>
                        <div class="collapsible-body">
                            <main id="tasks"
                                  data-all-tasks-completed="${process.status == br.ufscar.sead.loa.propeller.domain.ProcessInstance.STATUS_ALL_TASKS_COMPLETED}">
                                <table class="responsive-table bordered highlight centered">
                                    <thead>
                                    <tr>
                                        <th data-field="id">Nome</th>
                                        <th data-field="name">Status</th>
                                        <th data-field="status"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${tasks}" var="task">
                                        <tr class="pending">
                                            <td>
                                                <span class="">
                                                    ${task.definition.name}
                                                </span>
                                            </td>
                                            <g:if test="${task.status == 1}">
                                                <td>
                                                    <a href="/frame/${process.definition.uri}/${task.definition.uri}?t=${task.id}">REALIZAR</a>
                                                </td>
                                                <td>
                                                </td>
                                            </g:if>
                                            <g:else>
                                                <td onload="Materialize.toast('Informações salva com sucesso!', 3000, 'rounded') ">
                                                    <i class="material-icons" style="color:green;">check</i>
                                                </td>
                                                <td>
                                                </td>
                                            </g:else>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </main>
                        </div>
                    </g:if>
                    <g:else>
                        <div id="tasks-header" class="collapsible-header">
                            <i class="material-icons">linear_scale</i>Tarefas
                        </div>
                    </g:else>
                </li>
                <!-- Fim 2 Etapa - tarefas -->
            </ul>
            <a href="/process/finish?id=${process.id}" id="publish" type="submit" class="btn waves-effect waves-light my-orange right">
                Publicar
            </a>
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
%{--<g:javascript src="menu.js"/>--}%
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
