
<%@ page import="br.ufscar.sead.loa.escolamagica.remar.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-question" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="level" title="${message(code: 'question.level.label', default: 'Level')}" />
					
						<g:sortableColumn property="answers" title="${message(code: 'question.answers.label', default: 'Answers')}" />
					
						<g:sortableColumn property="correctAnswer" title="${message(code: 'question.correctAnswer.label', default: 'Correct Answer')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'question.title.label', default: 'Title')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${questionInstanceList}" status="i" var="questionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "level")}</g:link></td>
					
						<td>${fieldValue(bean: questionInstance, field: "answers")}</td>
					
						<td>${fieldValue(bean: questionInstance, field: "correctAnswer")}</td>
					
						<td>${fieldValue(bean: questionInstance, field: "title")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
                <g:link action="createXML" >Finalizar</g:link>
				<g:paginate total="${questionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
