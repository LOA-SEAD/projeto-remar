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
    table, th, td {
        border: 1px solid black;
    }
    </style>

    <title></title>
    </head>

        <body>

            <g:form action="assignTasks" >
                <table>
                    <p> <h2>Tarefas Disponiveis no momento</h2></p>
                    <thead>
                        <tr>
                            <th> Nome </th>
                            <th> Usuarios Disponíves </th>
                            <th> Delegação   </th>
                            <th> Usuário delegado</th>
                            <th> Completar</th>
                            <th> Realizar Tarefa  </th>
                        </tr>
                    </thead>
                <tbody>
                    <g:each in="${alltasks}" status="i" var="task" >
                      <tr>
                        <td value="task"> ${task.getName()} </td>
                          <td><select  name="${task.getId()}">
                              <g:each in="${allusers}" status="j" var="user" >
                                  <option value="${user.id}"> ${user.getFirstName()} </option>
                              </g:each>

                              </select>
                          </td>
                              <td>${task.getDelegationState()}</td>
                          <g:if test="${task.getAssignee() == null}">
                              <td>SEM USUARIO</td>
                          </g:if>
                          <g:else test="${task.getId() == null}">
                              <td>${task.getAssignee()}</td>
                          </g:else>

                        <td> <g:link action="completeTask" id="${task.getId()}" >Ok</g:link></td>

                          <td><g:link action="doTask" id="${task.getId()}">Ir</g:link></td>

                      </tr>
                    </g:each>
                </tbody>
                </table>

                <input type="submit" value="Enviar" />
            </g:form>




        </body>

    </html>