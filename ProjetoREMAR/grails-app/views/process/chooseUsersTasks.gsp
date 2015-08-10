<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 10/06/15
  Time: 09:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main-beta">

    <title></title>
    </head>

        <body>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header-blue">Atribuição de Tarefas</h1>
                </div>
            </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">Tabela de tarefas e usuários disponíveis</div>
                                <div class="panel-body">
                                    <div class="dataTables_wrapper">
                                        <div id="tasks-table" class="dataTables_wrapper form-inline dt-boostrap no-footer">
                                            <div class="col-sm-12">
            <g:form action="delegateTasks" >
                <table id="tasks-users" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="tasks-users-info" >
                    <thead>
                        <tr role="row">
                            <th class="sorting_asc" tabindex="0" style="width: 100px;" aria-controls="tasks-users" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending" </th>                                                                                                                                                                                  > Nome </th>
                            <th class="sorting" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending" > Usuarios Disponíves </th>
                            <th class="sorting" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending" > Delegação   </th>
                            <th class="sorting" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending" >Usuário delegado</th>
                            <th class="sorting" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending" > Completar</th>
                            <th class="sorting" tabindex="0" aria-controls="tasks-users" rowspan="1" colspan="1"  aria-label="Rendering engine: activate to sort column descending" > Realizar Tarefa  </th>
                        </tr>
                    </thead>
                <tbody>
                    <g:each in="${alltasks}" status="i" var="task" >
                      <tr role="row">
                        <td  value="task"> ${task.getName()} </td>
                          <td><select  name="${task.getId()}">
                              <g:each in="${allusers}" status="j" var="user" >
                                  <option value="${user.id}"> ${user.getFirstName()} </option>
                              </g:each>

                              </select>
                          </td>
                              <td >${task.getDelegationState()}</td>
                          <g:if test="${task.getAssignee() == null}">
                              <td>SEM USUARIO</td>
                          </g:if>
                          <g:else test="${task.getId() == null}">
                              <td>${task.getAssignee()}</td>
                          </g:else>

                        <td> <g:link action="completeTask" id="${task.getId()}" >Ok</g:link></td>

                          <td><g:link target="_blank" uri="/${uri}/${task.taskDefinitionKey}" id="${task.getId()}">Ir</g:link></td>

                      </tr>
                    </g:each>
                </tbody>
                </table>
                <div class="input-group">
                    <input class="btn btn-sm btn-primary" type="submit" value="Enviar" />
                </div>
            </g:form>


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