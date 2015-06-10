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
                          <td><select>
                              <g:each in="${allusers}" status="j" var="user" >
                                  <option value="firstname"> ${user.getFirstName()} </option>

                              </g:each>

                                </select> </td>
                      </tr>
                    </g:each>
                </tbody>
            </table>

            <div ><g:link action="assignTasks" controller="process" >Ok</g:link></div>
        </body>

    </html>