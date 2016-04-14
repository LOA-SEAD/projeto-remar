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
            <i class="small material-icons left">list</i>Tarefas
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
        </article>
    </div>
</div>
<g:javascript src="menu.js"/>
<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
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
