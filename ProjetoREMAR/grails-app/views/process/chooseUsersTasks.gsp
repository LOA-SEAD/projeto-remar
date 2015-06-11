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
                    <thead>
                        <tr>
                            <th>  Tarefas </th>
                            <th> Usuarios Disponíves </th>
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
                      </tr>
                    </g:each>
                </tbody>
                </table>

                <input type="submit" value="Enviar" />
            </g:form>




        </body>

    </html>