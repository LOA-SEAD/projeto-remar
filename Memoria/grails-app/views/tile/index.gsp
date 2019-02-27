
<%@ page import="br.ufscar.sead.loa.memoria.Tile" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
    %{-- Loading Screen --}%
    <div id="loading-screen">
        <div class="spinner outer" style="background-image: url(${resource(dir: 'images', file: 'outerspinner.png')});"></div>
        <img class="spinner inner" src="${resource(dir: 'images', file: 'innerspinner.png')}">
    </div>

    <div class="row cluster">
        <div class="cluster-header">
            <h4>Memória - Fase 3x2</h4>
            <div class="divider"></div>
        </div>

        <div class="row show">
            %{-- Lista de peças --}%
            <div class="row tile-display-container">
                <table>
                    <thead>
                    <tr>
                        <th><g:message code="tile.table.id.header"/></th>
                        <th><g:message code="tile.table.textA.header"/></th>
                        <th><g:message code="tile.table.textB.header"/></th>
                        <th><g:message code="tile.table.actions.header"/></th>
                    </tr>
                    </thead>
                    <tbody>
                        <g:if test="${tilesCount > 0}">
                            <g:each var="tile" in="tilesList">

                            </g:each>
                        </g:if>
                        <g:else>
                            <td colspan="3">Não há pares cadastrados!</td>
                        </g:else>

                    </tbody>
                </table>
            </div>

            <div class="row no-margin">
                <div class="col s3 offset-s7 right-align ">
                    <g:link class="btn btn-success btn-lg remar-orange" action="create">Novo par</g:link>
                </div>
                <div class="col s2 center-align ">
                    <a href="#!" id="send" class="btn btn-success btn-lg remar-orange">Enviar</a>
                </div>
            </div>
        </div>
    </div>

    <div id="fail-modal" class="modal remar-modal">
        <div class="modal-content">
            <h4>Não foi possível enviar</h4>
            <p></p>
        </div>
        <div class="modal-footer">
            <a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">OK</a>
        </div>
    </div>

    <g:javascript src="rememoria.js"/>
</body>
</html>
