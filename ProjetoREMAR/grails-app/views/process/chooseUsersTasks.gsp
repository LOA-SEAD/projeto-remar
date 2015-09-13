    <%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 10/06/15
  Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="new-main-inside">
    <g:javascript src="help.js"/>
    <g:if test="${dev}">
        <script>window.dev = true</script>
    </g:if>
    <title></title>
</head>
<body>


<div class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-body box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <i class="fa fa-tasks"></i>
                       Atribuição de Tarefas
                        <div class="test">aaa</div>
                    </h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                    <div class="direct-chat-messages page-size" >

                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="dataTables_wrapper">
                                    <div id="tasks-table" class="dataTables_wrapper form-inline dt-boostrap no-footer">
                                        <div class="col-sm-12">
                                            <form action="/process/tasks/delegate/${processId}" method="post">
                                                <table id="tasks-users" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="tasks-users-info" >
                                                    <thead>
                                                    <tr role="row">
                                                        <th class="sorting col-md-2" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Nome</th>
                                                        <th class="sorting col-md-2" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">
                                                            Usuario responsável
                                                            <i class="fa fa-question-circle help" data-content="Cada tarefa deve ser atribuída a um usuário – pode ser você ou outra pessoa :)" rel="popover" data-placement="bottom" data-original-title="Ajuda" data-trigger="hover"></i>
                                                        </th>
                                                        <th class="sorting col-md-2" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">
                                                            Status
                                                            <i class="fa fa-question-circle help" data-content="Cada tarefa deve ser resolvida e depois aprovada. Futuramente você poderá ver o que foi feito antes de aprová-la :)" rel="popover" data-placement="bottom" data-original-title="Ajuda" data-trigger="hover"></i>
                                                        </th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <g:each in="${alltasks}" status="i" var="task" >
                                                        <tr role="row">
                                                            <td>${task.getName()}</td>
                                                            <td>
                                                                <label>
                                                                    <select name="${task.getId()}">
                                                                        <g:if test="${task.getAssignee() == null}">
                                                                            <option disabled selected>Selecione</option>
                                                                        </g:if>
                                                                        <g:each in="${allusers}" status="j" var="user">
                                                                            <g:if test="${task.getAssignee() == user.id}">
                                                                                <option selected value="${user.id}">${user.getFirstName()}</option>
                                                                            </g:if>
                                                                            <g:else>
                                                                                <option value="${user.id}">${user.getFirstName()}</option>
                                                                            </g:else>
                                                                        </g:each>
                                                                    </select>
                                                                </label>
                                                            </td>

                                                            <g:if test="${task.getDelegationState().toString() == "PENDING" && currentUser.username == task.getAssignee()}">
                                                                %{--<td>Pendente – <g:link target="_blank" uri="/${uri}/${task.taskDefinitionKey}" id="${task.getId()}">REALIZAR</g:link></td>--}%
                                                                <td>Pendente – <a href="/frame/${uri}/${task.taskDefinitionKey}" >REALIZAR</a></td>

                                                            </g:if>
                                                            <g:elseif test="${task.getDelegationState().toString() == "PENDING"}">
                                                                <td>Pendente</td>
                                                            </g:elseif>
                                                            <g:elseif test="${task.getDelegationState().toString() == "RESOLVED"}">
                                                                <td>Realizada – Aguardando aprovação – <g:link uri="/process/task/complete/${task.getId()}">APROVAR</g:link></td>
                                                            </g:elseif>
                                                            <g:elseif test="${task.getDelegationState().toString() == "null"}">
                                                                <td>Sem usuário responsável</td>
                                                            </g:elseif>
                                                        </tr>
                                                    </g:each>
                                                    </tbody>
                                                </table>
                                                <div class="input-group">
                                                    <input class="btn btn-sm btn-primary" type="submit" value="Enviar" />
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>