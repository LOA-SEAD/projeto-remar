<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 21/01/16
  Time: 13:57
  Desc: Tela que lista os jogos públicos
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Jogos Públicados</title>
    <meta name="layout" content="materialize-layout">
</head>
<body>
<div class="row">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 24px;">
           Banco de Jogos
        </p>

        <div class="divider"></div>
    </div>
    <div class="row search">
        <div class="input-field col s6">
            <input id="search" type="text" placeholder="Buscar jogo" class="validate" autocomplete="off">
            <label for="search"><i class="fa fa-search" ></i></label>
        </div>
        <div class="input-field col s6">
            <select>
                <option class="option" value="-1" selected>Todas</option>
                <g:if test="${categories.size() > 0}">
                    <g:each in="${categories}" var="category">
                        <option class="option" value="${category.id}">${category.name}</option>
                    </g:each>
                </g:if>
            </select>
            <label>Categoria</label>
        </div>
    </div>
    <div style="position:relative; left: 1.2em" id="showCards" class="row ">
        <g:render template="cardGames" model="${pageScope.variables}" />
    </div>
</div>
<div id="userDetailsModal" class="modal remar-modal">
    <div class="modal-content">
        <h4>Informações de Usuário</h4>
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-action modal-close btn waves-effect waves-light my-orange">OK</a>
    </div>
</div>
<script>
    $(document).ready(function(){
        $('.modal-trigger').leanModal();
    });
</script>
<g:javascript src="add-resource-to-group.js"/>
<g:javascript src="menu.js"/>
<g:javascript src="utility/utility-public-game.js"/>
</body>
</html>