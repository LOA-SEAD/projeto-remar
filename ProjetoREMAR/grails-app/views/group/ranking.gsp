<%@ page import="br.ufscar.sead.loa.remar.User;" contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="materialize-layout">

        <title>Ranking ${resource}</title>
    </head>

    <body>
        <div class="row cluster">
            <div class="cluster-header">
                <h4>Ranking ${resource}</h4>
                <div class="divider"></div>
            </div>
            <div class="row show">
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
                                    <td>
                                        <a data-user-id="${entry.user.id}" class="user-profile-anchor modal-trigger" href="#user-details-modal">
                                        ${entry.user.name}
                                        </a>
                                    </td>
                                    <td>
                                        <g:formatNumber number="${entry.score}" maxFractionDigits="3"/>
                                    </td>
                                    <td>${entry.timestamp}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="user-details-modal" class="modal remar-modal">
            <div class="modal-content">
                <h4>TESTE</h4>
                <p>Lorem Ipsum</p>
            </div>
            <div class="modal-footer">
                <a href="#!" class="modal-action modal-close waves-effect btn-flat">OK</a>
            </div>
        </div>

        <g:javascript src="ranking.js"/>
    </body>
</html>
