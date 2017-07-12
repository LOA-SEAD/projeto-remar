<%@ page import="br.ufscar.sead.loa.remar.User;" contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="materialize-layout">
    </head>

    <body>
        <div class="table-container">
            <table class="highlight">
                <thead>
                    <tr>
                        <th>Jogador</th>
                        <th>Pontuação</th>
                        <th>Data</th>
                    </tr>
                </thead>

                <tbody>
                    <g:each var="entry" in="${ranking}">
                        <tr>
                            <td><a href="#!">${entry.user.name}</a></td>
                            <td>${entry.score}</td>
                            <td>${entry.timestamp}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>
