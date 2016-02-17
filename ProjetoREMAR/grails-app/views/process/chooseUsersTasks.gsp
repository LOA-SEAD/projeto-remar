<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 10/06/15
  Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    td a {
        display:block;
        width:100%;
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
            <g:if test="${completedTask}">
                <script>
//                    console.log("tarefa completada");
                    Materialize.toast('Tarefa completada com sucesso!', 3000, 'rounded');
                </script>
            </g:if>
            <div class="subtitle space">
                <h3 class="text-teal text-darken-3 center truncate" title="${nameProcess}">
                    ${nameProcess}
                </h3>
                <h5 class="center date">
                    <i class="fa fa-clock-o"></i> Inializado em <g:formatDate format="dd-MM-yyyy HH:mm" date="${startedProcess}"/>
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
                    <th data-field="status">status</th>

                </tr>
                </thead>
                <tbody>
                <g:each in="${tasks}" var="task">
                    <tr class="pending">
                        <td>
                           <span class="">
                               ${task.getName()}
                           </span>
                            %{--${task.taskDefinitionKey}--}%
                        </td>

                    %{--<td> <i class="small material-icons right tooltipped" data-position="right" data-delay="50" data-tooltip="Pendente">warning</i></td>--}%

                    %{--<g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">--}%
                        <g:if test="${task.getDelegationState().toString() == "PENDING"}">
                            <td><a href="/frame/${uri}/${task.taskDefinitionKey}" >REALIZAR</a></td>
                        </g:if>
                        <td> <i class="small material-icons tooltipped" data-position="down" data-delay="50" data-tooltip="Pendente">warning</i></td>

                        %{--<g:elseif test="${task.getDelegationState().toString() == "RESOLVED"}">--}%
                    %{--<td>Realizada – Aguardando aprovação – <g:link uri="/process/task/complete/${task.getId()}">APROVAR</g:link></td>--}%
                    %{--</g:elseif>--}%
                    %{--<g:elseif test="${task.getDelegationState().toString() == "null"}">--}%
                    %{--<td>Sem usuário responsável</td>--}%
                    %{--</g:elseif>--}%
                    </tr>
                %{--${task.getName()} <br>--}%
                %{--<tr role="row">--}%
                %{--<td>${task.getName()} </td>--}%
                %{--<td>--}%
                %{--<g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">--}%
                %{--<input name="${task.getId()}"  id="userlabel" value="${task.getAssignee()}">--}%
                %{--</g:if>--}%
                %{--<g:else>--}%
                %{--<input name="${task.getId()}"  id="userlabel" value="${currentUser.username}">--}%
                %{--</g:else>--}%
                %{--</td>--}%
                </g:each>
                </tbody>
            </table>
            %{--<ul class="collapsible popout" data-collapsible="expandable">--}%
                %{--<li>--}%
                    %{--<a href="/process/tasks/overview/${process[3]}">--}%
                    %{--<div class="collapsible-header active"><i class="material-icons">list</i>Tarefas </div>--}%
                    %{--<div class="collapsible-body">--}%

                    %{--</div>--}%
                %{--<!-- pensar um algum método para mostrar processo ativo ou desativado-->--}%
                %{--<g:if test="${!process[2]}">--}%
                %{--<td>Ativo</td>--}%
                %{--</g:if>--}%
                %{--</li>--}%
            %{--</ul>--}%
        </article>
    </div>
</div>
<g:javascript src="menu.js"/>
<script type="text/javascript" src="${resource(dir: 'js', file: "imgPreview.js")}"></script>
<script>
    $(document).ready(function(){
        $('.collapsible').collapsible({
            accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
        });
        $('.tooltipped').tooltip({delay: 50});
    });
</script>
</body>
</html>