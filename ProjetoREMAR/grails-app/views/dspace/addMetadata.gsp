<%--
  Created by IntelliJ IDEA.
  User: lucasbocanegra
  Date: 28/06/16
  Time: 17:24
--%>

<html>
<head>
    <meta name="layout" content="materialize-layout">
    <title>Categorias</title>
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
                            <g:each in="${process.completedTasks}" var="task">
                                <tr class="line">
                                    <td>
                                        <p>
                                            <input type="checkbox" id="test${task.id}" />
                                            <label for="test${task.id}"></label>
                                        </p>
                                    </td>
                                    <td>
                                        ${task.definition.name}
                                    </td>
                                    <td>

                                        <div class="icon-metadata-disabled">
                                            <span>Nenhum</span>
                                        </div>

                                        <div class="icon-metadata-pending">
                                            <a href="#!" class="tooltipped" data-position="right"
                                               data-delay="50" data-tooltip="Adicionar Metadados"
                                                data-task-id="${task.id}">
                                                Adicionar
                                            </a>
                                        </div>

                                        <div class="icon-metadata-done">
                                            <span>OK - </span>
                                            <a href="#!" class="tooltipped right" data-position="bottom"
                                               data-delay="50" data-tooltip="Visualizar"
                                               data-task-id="${task.id}">
                                                <i class="material-icons">visibility</i>
                                            </a>
                                            <a href="#!" class="tooltipped right" data-position="bottom"
                                               data-delay="50" data-tooltip="Editar"
                                               data-task-id="${task.id}">
                                                <i class="material-icons">mode_edit</i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </section>
        </article>
    </div>
</div>
<g:javascript src="dspace.js"/>
</body>
</html>