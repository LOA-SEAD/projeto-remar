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
        <article class="width-position left-align">
            <section class="row">
                <div class="col s12">
                    <div class="card-content text-justify">
                        <p>Neste espaço estão disponíveis alguns artefatos customizados por nossos usuários e
                        usados na criação dos jogos. Tais artefatos encontram-se no Dspace
                        Este espaço faz uma abstração dos artefatos lá encontrados. Eles estão divididos em
                        comunidades, nomeadas pelo nome de cada jogo, coleções e os items de cada coleção.
                        O usuário pode baixar o artefato por este espaço e usá-lo, por exemplo, para customizar
                        um jogo.
                        </p>
                    </div>
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
                                        <g:if test="${tasksSendToDspace.containsKey(task.id.toString())==true}">
                                            <p>
                                                <input type="checkbox" id="task${i}" checked disabled/>
                                                <label for="task${i}"></label>
                                            </p>
                                        </g:if>
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

                                    <g:if test="${tasksSendToDspace.containsKey(task.id.toString())==true}">
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
                                    <g:else>
                                        <input type="hidden" id="task${i}-metadata" value="false">

                                        <div class="icon-metadata-disabled">
                                            <span>Nenhum</span>
                                        </div>

                                        <div class="icon-metadata-pending">

                                            <a href="listMetadata?processId=${process.id}&&taskId=${task.id}&&step=0" class="tooltipped" data-position="right"
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
<g:javascript src="dspace.js"/>
<g:javascript src="dspace/checkMetadata.js"/>

</body>
</html>