<%@ page import="br.ufscar.sead.loa.remar.User;" contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
        <p>Usuários membros do grupo</p>
        <ul>
            <g:each var="user" in="${usersInGroup}">
                <li>${user.name} - ${user.id}</li>
            </g:each>
        </ul>

        <p>Usuários não membros do grupo</p>
        <ul>
            <g:each var="user" in="${usersNotInGroup}">
                <li>${user.name} - ${user.id}</li>
            </g:each>
        </ul>
    </body>
</html>
