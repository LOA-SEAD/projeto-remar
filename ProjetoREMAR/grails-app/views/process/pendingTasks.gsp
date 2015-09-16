<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 06/08/15
  Time: 11:14
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <meta name="layout" content="new-main-inside">
</head>

<body>

<div class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-body box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                    <i class="fa fa-list-alt"></i>
                    Tarefas pendentes
                    </h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                    <div class="direct-chat-messages page-size" >

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
                                                    <th class="sorting" tabindex="0" aria-controls="pending-tasks" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Atribuído por (Dono do Processo):</th>
                                                    <th class="sorting" tabindex="0" aria-controls="pending-tasks" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending">Realizar Tarefa</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <g:each in="${tasks}" var="task">
                                                    <tr role="row">
                                                        <td >${task[0]}</td>
                                                        <td >${task[1]}</td>
                                                        <td >${task[2]}</td>
                                                        <td><g:link uri="/frame${task[3]}">Ir</g:link></td>
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
        </div>
    </div>
</div>

</body>
</html>