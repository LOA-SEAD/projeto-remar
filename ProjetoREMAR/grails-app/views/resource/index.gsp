<%--
  Created by IntelliJ IDEA.
  User: loa
  Date: 25/06/15
  Time: 11:04
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="materialize-layout">
</head>
<body>
    <div class="row cluster">
        <p class="left-align margin-bottom" style="font-size: 24px;">
            <i class="left small material-icons">work</i>Gerenciar jogos
        </p>
        <div class="divider"></div>
        <br />
        %{--<div style="position:relative; left: 1.0em;" class="card-list two-cards">--}%
        <main class="cardGames">
            <div class="row">
                <g:if test="${resourceInstanceList}">
                    <g:render template="developerCads" model="[resourceInstanceList:resourceInstanceList]" />
                </g:if>
                <g:else>
                    <p>Você ainda não submeteu nenhum jogo. Nos envie um agora mesmo!  :)</p>
                </g:else>
                <div class="fixed-action-btn my-position">
                    <a class="btn-floating btn-large my-orange" href="/resource/create">
                        <i class="material-icons large">add</i>
                    </a>
                </div>
            </div>
        </main>
        %{--</div>--}%
    </div>
    <footer class="row">
        <ul class="pagination">

        </ul>
    </footer>

    <!-- Modal Structure -->
    <div id="sqlError" class="modal">
        <div class="modal-content">
            <h4>Não é possivel excluir esse modelo!</h4>
            <p>Existe jogos customizados apartir deste modelo.</p>
        </div>
        <div class="modal-footer">
            <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">ok</a>
        </div>
    </div>
    <div id="userDetailsModal" class="modal" style="width:40%">
        <div class="modal-content">
        </div>
        <div class="modal-footer">
            <button class="btn waves-effect waves-light modal-close my-orange" style="margin-right: 10px;">Ok</button>
        </div>
    </div>
    <g:javascript src="game-index.js"/>
</body>
</html>
