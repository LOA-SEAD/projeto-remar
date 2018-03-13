<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="${resource(dir: "css", file: "card.css")}"/>
    <meta name="layout" content="materialize-layout">
</head>
<body>
    <div class="row cluster">

        <div class="cluster-header">
            <h4><g:message code="resource.index.label.title" /></h4>
            <div class="divider"></div>
        </div>

        <div class="row show">
            <main class="cardGames">
                <div class="row">
                    <g:if test="${resourceInstanceList}">
                        <g:render template="developerCards" model="[resourceInstanceList:resourceInstanceList]" />
                    </g:if>
                    <g:else>
                        <p><g:message code="resource.index.message.noGame" /></p>
                    </g:else>
                    <div class="col s1 offset-s10">
                        <a href="/resource/create"  name="create"
                           class="btn-floating btn-large waves-effect waves-light my-orange tooltipped modal-trigger"
                           data-tooltip="Adicionar modelo de jogo"><i class="material-icons">add</i></a>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <footer class="row">
        <ul class="pagination">
        </ul>
    </footer>

    <div id="userDetailsModal" class="modal">
        %{-- Preenchido pelo Javascript --}%
    </div>

    <g:javascript src="remar/game-index.js"/>
</body>
</html>
