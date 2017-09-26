<%--
  Created by IntelliJ IDEA.
  User: lucas
  Date: 21/01/16
  Time: 13:57
  Desc: Tela que lista os jogos customizáveis
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Modelos</title>
    <meta name="layout" content="materialize-layout">
</head>

<body>
    <div class="row cluster">
        <div class="cluster-header">
            <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 24px;">
               Customizar
            </p>
            <div class="divider"></div>
        </div>
        <div class="row search">
            <div class="input-field col s6">
                <input id="search" type="text" placeholder="Buscar modelo de jogo" class="validate">
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
        <div id="resourcesShow" class="row">
            <g:render template="custCards" model="${pageScope.variables}" />
        </div>
    </div>
    <div id="userDetailsModal" class="modal" style="width:40%">
        %{-- Preenchido pelo Javascript --}%
    </div>

    <g:javascript src="jquery/jquery.rateyo.min.js"/>
    <g:javascript src="remar/menu.js"/>
    <g:javascript src="/remar/utility/utility-customizable-game.js"/>
</body>
</html>
