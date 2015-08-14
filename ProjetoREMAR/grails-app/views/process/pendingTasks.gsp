<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 06/08/15
  Time: 11:14
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="main-beta">
</head>

<body>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header-blue">Tarefas Pendentes</h1>
    </div>
</div>
    </div>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Tabela de Tarefas Pendentes</div>
            <div class="panel-body">
                <div class="dataTables_wrapper">
                    <div id="tasks-table" class="dataTables_wrapper form-inline dt-boostrap no-footer">
                        <div class="col-sm-12">
                                <table id="pending-tasks" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="tasks-users-info" >
                                    <thead>
                                        <tr role="row">
                                            <th class="sorting" tabindex="0" aria-controls="pending-tasks" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Nome do Jogo</th>
                                            <th class="sorting" tabindex="0" aria-controls="pending-tasks" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Nome da Tarefa</th>
                                            <th class="sorting" tabindex="0" aria-controls="pending-tasks" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Atribuído por: (Dono do Processo)</th>
                                            <th class="sorting" tabindex="0" aria-controls="pending-tasks" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Realizar Tarefa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${myProcessesAndTasks}">
                                            <tr role="row">
                                                <td  value="task">${it.gameName}</td>
                                                <td >${it.taskName}</td>
                                                <td >${it.taskOwner}</td>
                                                <td><g:link target="_blank" uri="${it.taskURI}">Ir</g:link></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
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