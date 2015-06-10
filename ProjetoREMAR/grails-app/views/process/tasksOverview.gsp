<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 10/06/15
  Time: 08:32
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

    <body>
        <tbody>
        <g:each in="${list}" status="i" var="task">
            <table>
                <tr>
                    <td><g:link action="--"> ${task.getName()}  </g:link> <br>
                        ${task.assignee}

                    </td>

                </tr>

            </table>
        </g:each>
        </tbody>
    </body>
</html>