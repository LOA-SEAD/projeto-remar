<%--
  Created by IntelliJ IDEA.
  User: deniscapp
  Date: 07/08/15
  Time: 08:29
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

</head>
<body>
    <div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom">
                <i class="small material-icons left">list</i>Minhas tarefas
            </p>
            <div class="divider"></div>
        </div>
        <div class="row search">
            <div class="input-field col s6">
                <input id="search" type="text" class="validate">
                <label for="search"><i class="fa fa-search"></i></label>
            </div>
        </div>
        <div class="row show developer">
            <article class="row">
                <g:if test="${processes}">
                    <g:render template="process" model="[processes:processes]" />
                </g:if>
                <g:else>
                    <p>Você não possui nenhum jogo em customização. Customize um agora mesmo! :)</p>
                </g:else>
                %{--<ul class="collapsible popout" data-collapsible="accordion">--}%
                    %{--<g:each in="${processes}" var="process">--}%
                        %{--<li>--}%
                            %{--<a href="/process/tasks/overview/${process[3]}">--}%
                            %{--<div class="collapsible-header">--}%
                                %{--<div class="row">--}%
                                    %{--<div class="input-field col s6">--}%
                                        %{--<input value="${process[0]}" id="first_name2" type="text" class="validate">--}%
                                        %{--<label class="active" for="first_name2">First Name</label>--}%
                                    %{--</div>--}%
                                    %{--<a href="/process/delete/${process[3]}" class=""><i class="large material-icons right tooltipped" data-position="right" data-delay="50" data-tooltip="Excluir">delete</i></a>--}%
                                %{--</div>--}%
                            %{--</div>--}%
                            %{--<div class="collapsible-body">--}%
                                %{--<p>Lorem ipsum dolor sit amet.</p>--}%
                                %{--<table class="striped responsive-table">--}%
                                    %{--<thead>--}%
                                        %{--<tr>--}%
                                            %{--<th data-field="id">Nome da tarefa</th>--}%
                                            %{--<th data-field="name">status</th>--}%
                                        %{--</tr>--}%
                                    %{--</thead>--}%
                                    %{--<tbody>--}%
                                        %{--<g:each in="${process[4]}"  var="allTasks" >--}%
                                            %{--<g:each in="${allTasks}"  var="task" >--}%
                                                %{--<tr class="pending">--}%
                                                    %{--<td class="">--}%
                                                        %{--<a href="/frame/${process[5]}/${task.taskDefinitionKey}">--}%
                                                            %{--${task.getName()}--}%
                                                            %{--${task.taskDefinitionKey}--}%
                                                        %{--</a>--}%
                                                    %{--</td>--}%

                                                    %{--<td> <i class="small material-icons right tooltipped" data-position="right" data-delay="50" data-tooltip="Pendente">warning</i></td>--}%
                                                    %{--</tr>--}%

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


                                                    %{--<g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">--}%
                                                    %{--<td>Pendente – <g:link target="_blank" uri="/${uri}/${task.taskDefinitionKey}" id="${task.getId()}">REALIZAR</g:link></td>--}%
                                                        %{--<td>Pendente – <a href="/frame/${uri}/${task.taskDefinitionKey}" >REALIZAR</a></td>--}%

                                                    %{--</g:if>--}%
                                                    %{--<g:elseif test="${task.getDelegationState().toString() == "PENDING"}">--}%
                                                        %{--<td>Pendente</td>--}%
                                                    %{--</g:elseif>--}%
                                                    %{--<g:elseif test="${task.getDelegationState().toString() == "RESOLVED"}">--}%
                                                        %{--<td>Realizada – Aguardando aprovação – <g:link uri="/process/task/complete/${task.getId()}">APROVAR</g:link></td>--}%
                                                    %{--</g:elseif>--}%
                                                    %{--<g:elseif test="${task.getDelegationState().toString() == "null"}">--}%
                                                        %{--<td>Sem usuário responsável</td>--}%
                                                    %{--</g:elseif>--}%
                                                %{--</tr>--}%
                                            %{--</g:each>--}%
                                        %{--</g:each>--}%
                                    %{--</tbody>--}%
                                %{--</table>--}%
                            %{--</div>--}%

                            %{--<!-- pensar um algum método para mostrar processo ativo ou desativado-->--}%
                            %{--<g:if test="${!process[2]}">--}%
                                %{--<td>Ativo</td>--}%
                            %{--</g:if>--}%
                        %{--</li>--}%
                    %{--</g:each>--}%
                %{--</ul>--}%
            </article>
        </div>
        <footer class="row">
            <ul class="pagination">
                <li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a></li>
                <li class="active"><a href="#!">1</a></li>
                <li class="waves-effect"><a href="#!">2</a></li>
                <li class="waves-effect"><a href="#!">3</a></li>
                <li class="waves-effect"><a href="#!">4</a></li>
                <li class="waves-effect"><a href="#!">5</a></li>
                <li class="waves-effect"><a href="#!"><i class="material-icons">chevron_right</i></a></li>
            </ul>
        </footer>
    </div>
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
