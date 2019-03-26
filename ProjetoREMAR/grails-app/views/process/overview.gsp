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
    <link type="text/css" rel="stylesheet" href="${resource(dir: 'css/jquery', file: 'jquery.jcrop.css')}"/>
    <title><g:message code="overview.title" default="Customizando Jogo"/></title>
</head>
<body>

<div class="row show">

</div>

<div class="row cluster">

    <div class="row cluster-header">
        <h4 id="start"><g:message code="overview.custom" default="Etapas de customização - Modelo de jogo"/> <strong>${process.definition.name}</strong></h4>
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
                <p class="date">
                    <i class="fa fa-clock-o"></i> <g:message code="overview.started" default="Customização iniciada em: "/><g:formatDate format="dd/MM/yy HH:mm" date="${process.createdAt}"/>
                </p>
            </div>
            <div class="row">
                <p>
                    <g:message code="overview.steps" default="Abaixo estão as etapas para customizar o seu jogo!"/>
                </p>
            </div>
            <g:form action="finish" method="POST">
                <ul class="collapsible popout" data-collapsible="accordion">
                    <!-- 1 Etapa - informações básicas -->
                    <li class="no-margin" style="width: 100% !important">
                        <g:if test="${!process.getVariable("updated")}">
                            <div class="collapsible-header active">
                                <g:message code="overview.basicInfo" default="Informações básicas"/>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="collapsible-header"><g:message code="overview.basicInfo" default="Informações básicas"/></div>
                        </g:else>

                        <div id="info" class="collapsible-body"
                             data-basic-info="${process.getVariable("updated")}">
                            ${process.putVariable("updated","false",true)}
                            <div class="row">
                                <div class="input-field col s12">
                                    <i class="material-icons suffix green-text active">done</i>
                                    <input value="${process.name}" id="name" type="text" maxlength="50"
                                           class="validate" data-resource-id="${process.getVariable("resourceId")}" data-process-id="${process.id}">
                                    <label class="active" for="name" data-error="" data-success="">
                                        <g:message code="overview.gameName" default="Nome do jogo"/>
                                    </label>
                                    <span id="name-error" class="invalid-input" style="left: 0.75rem">
                                        <g:message code="overview.message.existingName" default="Já existe um jogo com esse nome!"/>
                                    </span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 m2 l2 img-preview">
                                    <img id="img1Preview" class="materialboxed my-orange" width="180" height="180" src="/data/processes/${process.id}/banner.png?${new java.util.Date()}" />
                                    <span style="font-size: 0.8rem">
                                        <g:message code="overview.size" default="180 x 180 pixels"/>
                                    </span>
                                </div>
                                <div class="col s12 m10 l10">
                                    <div class="file-field input-field">
                                        <div id="file" class="btn waves-effect waves-light my-orange">
                                            <span>
                                                <g:message code="overview.label.file" default="Arquivo"/>
                                            </span>
                                            <input type="file" data-image="true" id="img-1" name="img1" accept="image/jpeg, image/png"  >
                                        </div>
                                        <div class="file-path-wrapper">
                                            <i class="material-icons suffix green-text active">done</i>
                                            <input class="file-path validate" type="text" id="img-1-text"  placeholder="Envie um ícone para o jogo (opcional)" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="right">
                                <a id="backButton" name="Back" class="btn my-orange" href="/resource/customizableGames">
                                    <g:message code="overview.label.back" default="Voltar"/>
                                </a>
                                <a href="#!" class="btn waves-effect waves-light my-orange" id="send" name="send" >
                                    <g:message code="overview.label.send" default="Enviar"/>
                                </a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </li>
                <!-- Fim 1 Etapa - informações básicas -->
                    <g:if test="${process.getVariable("showTasks")}">
                        <!-- 2 Etapa - tarefas -->
                        <li class="no-margin" style="width: 100% !important">
                            <g:if test="${tasks.size() != 0}">
                                <div id="tasks-header-sim" class="collapsible-header active">
                            </g:if>
                            <g:else>
                                <div id="tasks-header-nao" class="collapsible-header">
                            </g:else>

                            Tarefas
                            <g:if test="${process.getVariable("hasOptionalTasks")}">
                                <br/>
                                <tr>
                                    <td colspan="2">
                                        <span>
                                            <g:message code="overview.message.tasks" default="Atenção: Tarefas marcadas com * são obrigatórias"/>
                                        </span>
                                    </td>
                                </tr>
                            </g:if>
                        </div>
                            <div class="collapsible-body">
                                <main id="tasks"
                                      data-all-tasks-completed="${process.status == br.ufscar.sead.loa.propeller.domain.ProcessInstance.STATUS_ALL_TASKS_COMPLETED}">
                                    <table class="responsive-table bordered highlight centered">
                                        <thead>
                                        <tr>
                                            <th data-field="id">
                                                <g:message code="overview.field.name" default="Nome"/>
                                            </th>
                                            <th data-field="name">
                                                <g:message code="overview.field.status" default="Status"/>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <g:each in="${tasks}" var="task">
                                            <tr class="pending">
                                                <td>
                                                    <span>
                                                        ${task.definition.name}
                                                        <g:if test="${process.getVariable("hasOptionalTasks")}">
                                                            <g:if test="${task.definition.optional}">
                                                                <span class="optional-indicator">(Opcional)</span>
                                                            </g:if>
                                                            <g:else>
                                                                <span class="required-indicator">*</span>
                                                            </g:else>
                                                        </g:if>
                                                    </span>
                                                </td>
                                                <g:if test="${task.status == 1}">
                                                    <td>
                                                        <a href="/frame/${process.definition.uri}/${task.definition.uri}?t=${task.id}&p=${process.id}">
                                                            <g:message code="overview.label.pending" default="Pendente"/>
                                                        </a>
                                                    </td>
                                                </g:if>
                                                <g:else>
                                                    <td onload="Materialize.toast('Informações salva com sucesso!', 3000, 'rounded') ">
                                                        <i class="material-icons" style="color:green;">check</i>
                                                    </td>
                                                </g:else>
                                            </tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </main>
                                <div id="row-content-area" class="row hide">
                                    <blockquote style="margin-top: 25px;">
                                        <g:message code="overview.moreInfo" default="Digite mais algumas informações sobre o seu jogo."/>
                                    </blockquote>
                                    <div class=" input-field col s12 m12 l12">
                                        <input id="content-area" type="text" name="contentArea" value="${process.getVariable("contentArea")}"><label class="active" for="content-area" >
                                            <g:message code="overview.contentArea" default="Área de conteúdo"/>
                                        <span class="required-indicator">*</span></label>

                                    </div>
                                </div>
                                <div id="row-specific-content" class="row hide">
                                    <div class=" input-field col s12 m12 l12">
                                        <input id="specific-content" name="specificContent" type="text" value="${process.getVariable("specificContent")}"><label class="active" for="specific-content">
                                        <g:message code="overview.specificContent" default="Conteúdo específico"/>
                                        <span class="required-indicator">*</span></label>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!-- Fim 2 Etapa - tarefas -->
                    </g:if>
                </ul>

                <div class="row">
                    <div class="col s12 m12 l12">
                        <input name="id" id="processId" type="hidden" value="${process.id}">
                        <a id="submitButtonDisabled" class="btn disabled right hide">
                            <g:message code="overview.label.publish" default="Publicar"/>
                        </a>
                        <a  onclick="finishGame()" id="submitButton" name="Submit" value="PUBLICAR" class="btn my-orange right hide">
                            <g:message code="overview.label.publish" default="Publicar"/>
                        </a>
                    </div>
                </div>
            </g:form>
        </article>
    </div>
</div>
<div id="modal-picture" class="modal">
    <div class="modal-content center">
        <div class="img-container">
            <img id="crop-preview" class="responsive-img">
        </div>
    </div>
    <div class="modal-footer">
        <!-- Botão Enviar -->
        <div class="buttons col s1 m1 l1 offset-s8 offset-m10 offset-l10" style="margin-top:20px">
            <a href="#!" class="modal-action modal-close btn waves-effect waves-light my-orange">
                <g:message code="overview.label.send" default="Enviar"/>
            </a>
        </div>
    </div>
</div>
<g:external dir="css" file="process.css"/>
<g:javascript src="remar/platforms.js"/>
<g:javascript src="remar/imgPreview.js"/>
<g:javascript src="libs/jquery/jquery.jcrop.js"/>
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
