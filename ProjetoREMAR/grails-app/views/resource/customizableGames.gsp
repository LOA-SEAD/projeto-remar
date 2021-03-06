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
    <title><g:message code="customizable.title" default="Modelos"/></title>
    <meta name="layout" content="materialize-layout">
</head>

<body>
    <div class="row cluster">
        <div class="cluster-header">
            <h4><g:message code="customizable.label.title" default="Customizar"/></h4>

            <div class="divider"></div>
        </div>
        <div class="row search">
            <div class="input-field col s6">
                <input id="search" type="text" placeholder="Buscar modelo de jogo" class="validate">
                <label for="search"><i class="fa fa-search"></i></label>
            </div>
            <div class="input-field col s6">
                <select>
                    <option class="option" value="-1" selected><g:message code="customizable.label.option" default="Todas"/></option>
                    <g:if test="${categories.size() > 0}">
                        <g:each in="${categories}" var="category">
                            <option class="option" value="${category.id}">${category.name}</option>
                        </g:each>
                    </g:if>
                </select>
                <label><g:message code="customizable.label.category" default="Categoria"/></label>
            </div>
        </div>
        <div id="resourcesShow" class="row">
            <g:render template="gameModelCard" model="${pageScope.variables}" />
        </div>
    </div>
    <div id="userDetailsModal" class="modal" style="width:40%">
        %{-- Preenchido pelo Javascript --}%
    </div>

    <g:javascript src="libs/jquery/jquery.rateyo.min.js"/>
    <g:javascript src="remar/menu.js"/>
    <g:javascript src="/remar/utility/utility-customizable-game.js"/>
</body>
</html>
