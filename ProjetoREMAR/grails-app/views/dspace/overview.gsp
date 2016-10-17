<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Repositório</title>
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
            <g:if test="${!finished}">
                <p> Os itens criados para suas tarefas de customização  (imagens, questões etc.)
                também podem ser Recursos Educacionais Abertos!
                Selecione uma tarefa de customização e
                informe os metadados para a publicação de seus itens, sob licença Creative Commons, no
                Repositório Digital do REMAR.
                </p>
            </g:if>
            <g:else>
                <p>Todos os itens de customização foram publicados com sucesso no Repositório Digital do REMAR.</p>
            </g:else>
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
                                        <g:elseif test="${task.getVariable('step') == "preview-metadata"}">
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
                                            <a href="${task.getVariable('handle')}" target="_blank">Visualizar</a>
                                        </div>
                                    </g:if>
                                    <g:elseif test="${task.getVariable('step') == "preview-metadata"}">
                                        <input type="hidden" id="task${i}-metadata" value="false">
                                        <div class="">
                                            <a href="preview-metadata?taskId=${task.id}" class="tooltipped" data-position="right"
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

<g:javascript src="dspace/dspace.js"/>
<g:javascript src="dspace/checkMetadata.js"/>

</body>
</html>