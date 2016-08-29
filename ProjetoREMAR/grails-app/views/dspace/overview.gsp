<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Dspace-overview</title>
</head>
<body>
<div class="row cluster">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom title-page">
            <i class="medium material-icons left">cloud_upload</i>Enviar para o repositório
        </p>
        <div class="divider"></div>
        <div class="subtitle space">
            <h3 class="text-teal text-darken-3 center truncate">
                ${process.definition.name}
            </h3>
        </div>
        <div class="row center">
            <p>
                Abaixo estão listadas as tarefas realizadas durante a customização do jogo. Selecione as tarefas que
                gostaria de enviar para o repositório.
            </p>
        </div>
        <article class="width-position left-align">
            <section class="row">
                <div class="col s12">

                </div>
                <input type="hidden" id="taskCount" value="${process.completedTasks.size()}">
                <div class="col s12">
                    <table class="bordered">
                        <thead>
                        <tr>
                            <th data-field="answer">Selecionar</th>
                            <th data-field="name">Tarefas</th>
                            <th data-field="action">Metadados</th>
                        </tr>
                        </thead>
                        <tbody>
                            <g:each in="${process.completedTasks}" var="task" status="i">
                                <tr class="line">
                                    <td>
                                        <g:if test="${task.getVariable('step') == "completed" }" >
                                            <p>
                                                <input type="checkbox" id="task${i}" checked disabled/>
                                                <label for="task${i}"></label>
                                            </p>
                                        </g:if>
                                        <g:elseif test="${task.getVariable('step') == "submit_bitstreams"}">
                                            <p>
                                                <input type="checkbox" id="task${i}" checked disabled/>
                                                <label for="task${i}"></label>
                                            </p>
                                        </g:elseif>
                                        <g:else>
                                            <p>
                                                <input class="checkbox" type="checkbox" id="task${i}" />
                                                <label for="task${i}"></label>
                                            </p>
                                        </g:else>
                                    </td>
                                    <td>
                                        ${task.definition.name}
                                    </td>
                                    <td>

                                    <g:if test="${task.getVariable('step') == "completed" }">
                                        <div class="icon-metadata-done">
                                            <input type="hidden" id="task${i}-metadata" value="true">
                                            <span>OK</span>
                                            %{--<a href="#!" class="tooltipped right" data-position="bottom"--}%
                                               %{--data-delay="50" data-tooltip="Visualizar"--}%
                                               %{--data-task-id="${task.id}">--}%
                                                %{--<i class="material-icons">visibility</i>--}%
                                            %{--</a>--}%
                                            %{--<a href="#!" class="tooltipped right" data-position="bottom"--}%
                                               %{--data-delay="50" data-tooltip="Editar"--}%
                                               %{--data-task-id="${task.id}">--}%
                                                %{--<i class="material-icons">mode_edit</i>--}%
                                            %{--</a>--}%
                                        </div>
                                    </g:if>
                                    <g:elseif test="${task.getVariable('step') == "submit_bitstreams"}">
                                        <input type="hidden" id="task${i}-metadata" value="false">
                                        <div class="">
                                            <a href="listMetadata?taskId=${task.id}" class="tooltipped" data-position="right"
                                               data-delay="50" data-tooltip="Submissão incompleta">
                                                Continuar
                                            </a>
                                        </div>
                                    </g:elseif>
                                    <g:else>
                                        <input type="hidden" id="task${i}-metadata" value="false">
                                        <div class="icon-metadata-disabled">
                                            <span>Nenhum</span>
                                        </div>
                                        <div class="icon-metadata-pending">
                                            <a href="listMetadata?taskId=${task.id}" class="tooltipped" data-position="right"
                                               data-delay="50" data-tooltip="Adicionar Metadados">
                                                Adicionar
                                            </a>
                                        </div>
                                    </g:else>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </section>
        </article>
        <a id="finishLabel" class="btn disabled right hide">Finalizar</a>
        <a id="finishLink" href="../process/publishProcess?id=${process.id}" data-process-id="${process.id}" id="publish" type="submit" class="btn waves-effect waves-light my-orange right">
            Finalizar
        </a>
    </div>
</div>

<!-- Modal Structure -->
<div id="messenger" class="modal modal-fixed-footer">
    <div class="modal-content">
        <h4>Modal Header</h4>
            <p>
                Nesta página você pode enviar os artefatos customizados por você, neste jogo, para um repositório Dspace.
                Abaixo estão listadas as terefas que vocÊ realizou durante a customização do jogo. Para enviar os artefatos
                customizados em cada customização selecione a tarefa e click em adicionar metadados.
            </p>
    </div>
    <div class="modal-footer">
        <div class="row">
            <div class="col s10">
                <p class="right">
                    <input type="checkbox" id="show-messenger" />
                    <label for="show-messenger">Não mostrar novamente</label>
                </p>
            </div>
            <div class="col s2">
                <a href="#!" class="modal-action modal-close btn my-orange right">Ok</a>
            </div>
        </div>
    </div>
</div>


<g:javascript src="dspace.js"/>
<g:javascript src="dspace/checkMetadata.js"/>

</body>
</html>