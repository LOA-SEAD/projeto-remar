
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.QuestionEscola" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'questionEscola.label', default: 'QuestionEscola')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-questionEscola" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-questionEscola" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="level" title="${message(code: 'questionEscola.level.label', default: 'Level')}" />
					
						<g:sortableColumn property="answers" title="${message(code: 'questionEscola.answers.label', default: 'Answers')}" />
					
						<g:sortableColumn property="correctAnswer" title="${message(code: 'questionEscola.correctAnswer.label', default: 'Correct Answer')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'questionEscola.title.label', default: 'Title')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${questionEscolaInstanceList}" status="i" var="questionEscolaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${questionEscolaInstance.id}">${fieldValue(bean: questionEscolaInstance, field: "level")}</g:link></td>
					
						<td>${fieldValue(bean: questionEscolaInstance, field: "answers")}</td>
					
						<td>${questionEscolaInstance.correctAnswer + 1}</td>
					
						<td>${fieldValue(bean: questionEscolaInstance, field: "title")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
                <g:link action="createXML">Finalizar</g:link>
				<g:paginate total="${questionEscolaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
