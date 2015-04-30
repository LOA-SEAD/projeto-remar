
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Theme" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:javascript src="scriptTheme.js"/>
    <g:set var="entityName" value="${message(code: 'Theme.label', default: 'Theme')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<a href="#list-Theme" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
</div>
<div id="list-Theme" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table id="table">
        <thead>
        <tr>
            <th>Selecionar</th>

            <g:sortableColumn property="icone" title="${message(code: 'Theme.icone.label', default: 'Icone')}" />

            <g:sortableColumn property="telaFundo" title="${message(code: 'Theme.telaFundo.label', default: 'Tela Fundo')}" />

            <g:sortableColumn property="telaAbertura" title="${message(code: 'Theme.telaAbertura.label', default: 'Tela Abertura')}" />

        </tr>
        </thead>
        <tbody>
        <g:each in="${themeInstanceList}" status="i" var="themeInstance">
            <tr data-id="${fieldValue(bean: themeInstance, field: "id")}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td> <input class="checkbox" type="checkbox"/> </td>

                <td><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/icon.png" width="200" height="200"/></td>
                <td><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/opening.png" width="200" height="200"/></td>
                <td><img src="../data/${fieldValue(bean: themeInstance, field: "ownerId")}/themes/${fieldValue(bean: themeInstance, field: "id")}/background.png" width="200" height="200"/></td>



            </tr>
        </g:each>
        </tbody>
    </table>
    <fieldset class="buttons">
        <g:submitButton  name="save" class="save" value="Enviar"/>
        <div class="pagination">
            <g:paginate total="${questionInstanceCount ?: 0}" />
        </div>
</div>
</body>
</html>