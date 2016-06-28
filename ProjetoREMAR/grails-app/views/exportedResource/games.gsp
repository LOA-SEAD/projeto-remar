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
    <meta name="layout" content="materialize-layout-publicGames">
</head>

<body>
<div class="row cluster">
    <div class="cluster-header">
        <p id="title-page" class="text-teal text-darken-3 left-align margin-bottom">
            <i class="small material-icons left">videogame_asset</i>Banco de Jogos
        </p>

        <div class="divider"></div>
    </div>

    <div class="row search">
        <div class="input-field col s6">
            <input id="search" type="text" class="validate" autocomplete="off">
            <label for="search"><i class="fa fa-search"></i></label>
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
<g:javascript src="menu.js"/>
<g:javascript src="utility/utility-public-game.js"/>
</body>
</html>