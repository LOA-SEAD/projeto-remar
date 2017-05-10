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
    <style>
        .toast { line-height: 20px !important; }
        .row .cluster p { font-size: 24px; }
    </style>
</head>
<body>
    <div class="row cluster">
        <p class="left-align margin-bottom">
            Gerenciar Jogos
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
                    <p>Você ainda não submeteu nenhum jogo. Nos envie um agora mesmo!</p>
                </g:else>



                <div class="col s1 offset-s10">
                    <a href="/resource/create"  name="create"
                       class="btn-floating btn-large waves-effect waves-light my-orange tooltipped modal-trigger"
                       data-tooltip="Adicionar modelo de jogo"><i class="material-icons">add</i></a>
                </div>


            </div>
        </main>
        %{--</div>--}%
    </div>
    <footer class="row">
        <ul class="pagination">

        </ul>
    </footer>

    <g:javascript src="game-index.js"/>
</body>
</html>
