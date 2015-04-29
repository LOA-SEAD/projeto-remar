
<%@ page import="br.ufscar.sead.loa.quiforca.remar.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
        <g:javascript src="editableTable.js"/>
        <g:javascript src="scriptTable.js"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'stylesheet.css')}" />

        <meta property="user-name" content="${userName}"/>
        <meta property="user-id" content="${userId}"/>

		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="list-question" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
            <table id="table">
                <thead>
                <tr>
                    <th>Selecionar</th>

                    <g:sortableColumn property="statement" title="${message(code: 'question.statement.label', default: 'Pergunta')}" />

                    <g:sortableColumn property="answer" title="${message(code: 'question.answer.label', default: 'Resposta')}" />

                    <g:sortableColumn property="category" title="${message(code: 'question.category.label', default: 'Categoria')}" />

                    <g:sortableColumn property="author" title="${message(code: 'question.author.label', default: 'Autor')}" />

                </tr>
                </thead>
                <tbody>
                <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                    <tr data-id="${fieldValue(bean: questionInstance, field: "id")}" data-owner-id="${fieldValue(bean: questionInstance, field: "ownerId")}"
                        data-checked="false"  class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td class="_not_editable"> <input class="checkbox" type="checkbox"/> </td>

                        <td>${fieldValue(bean: questionInstance, field: "statement")}</td>

                        <td>${fieldValue(bean: questionInstance, field: "answer")} </td>

                        <td>${fieldValue(bean: questionInstance, field: "category")} </td>

                        <td >${fieldValue(bean: questionInstance, field: "author")}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
            <fieldset class="buttons">
                <g:submitButton  name="create" class="create" value="Nova questão" />
                <g:submitButton  name="save" class="save" value="Gerar JSON"/>
                <g:submitButton  name="delete" class="delete" value="Remover questões selecionadas"/>
			<div class="pagination">
				<g:paginate total="${questionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
